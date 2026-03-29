import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_controller_notifier.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

class BottomRightSection extends ConsumerStatefulWidget {
  const BottomRightSection({super.key});

  @override
  ConsumerState<BottomRightSection> createState() => _BottomRightSectionState();
}

class _BottomRightSectionState extends ConsumerState<BottomRightSection> {
  late TextEditingController _angleController;
  late FocusNode _angleFocus;

  @override
  void initState() {
    super.initState();
    final state = ref.read(robotArmControllerProvider);
    _angleController = TextEditingController(text: state.currentTurnAngle.toString());
    _angleFocus = FocusNode()..addListener(_onAngleFocusChange);
  }

  @override
  void dispose() {
    _angleController.dispose();
    _angleFocus.dispose();
    super.dispose();
  }

  // 각도 포커스가 해제될 때 검증 (-180 ~ 180)
  void _onAngleFocusChange() {
    if (!_angleFocus.hasFocus) {
      int? val = int.tryParse(_angleController.text);
      if (val == null || val < -180) val = -180; // 비정상이거나 -180 미만이면 제일 min 값(-180)으로
      if (val > 180) val = 180; // 180 초과 시 180으로 고정
      
      _angleController.text = val.toString();
      ref.read(robotArmControllerProvider.notifier).changeTurnAngle(val);
    }
  }

  @override
  Widget build(BuildContext context) {
    // 외부 상태 업데이트 시 텍스트 동기화
    ref.listen(robotArmControllerProvider, (prev, next) {
      if (prev?.currentTurnAngle != next.currentTurnAngle && !_angleFocus.hasFocus) {
        _angleController.text = next.currentTurnAngle.toString();
      }
    });

    return Column(
      children: [
        const SizedBox(height: 10,),
        Expanded(
          flex: 2,
          child: Text('턴테이블', style: AppTextStyles.title)
        ),
        Expanded(
          flex: 5,
          child: SizedBox(
            child: Image.asset('assets/robot_3.png'),
          ),
        ),
        const SizedBox(height: 10,),
        Expanded(
          flex: 3, 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 100, 
                    child: TextBox(
                      controller: _angleController, // 💡 컨트롤러 연결
                      focusNode: _angleFocus,       // 💡 포커스 연결
                      textAlign: TextAlign.center, 
                      style: const TextStyle(fontSize: 20),
                      onSubmitted: (_) => _angleFocus.unfocus(),
                    )
                  ),
                  const SizedBox(width: 8),
                  const Text('deg', style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 15,),
              SizedBox(
                width: 150,
                height: 60,
                child: GestureDetector(
                  onTap: () async {
                    // 전송 전 입력 중인 포커스 해제 (상태 업데이트 반영)
                    FocusManager.instance.primaryFocus?.unfocus(); 

                    debugPrint('[턴테이블] COMMAND 데이터전송');
                    final service = ref.read(robotArmControllerProvider.notifier);
                    try {
                      await service.writeToRobotArm(RobotArmCommandId.turnTable);
                    } catch(e) {
                      debugPrint(e.toString());
                    }
                  },
                  child: Image.asset('assets/rac_bt_setting_on.png'),
                ),
              )
            ],
          )
        ),
        const SizedBox(height: 5,)
      ],
    );
  }
}