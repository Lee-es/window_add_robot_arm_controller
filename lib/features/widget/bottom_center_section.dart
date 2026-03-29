import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_controller_notifier.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

class BottomCenterSection extends ConsumerStatefulWidget {
  const BottomCenterSection({super.key});

  @override
  ConsumerState<BottomCenterSection> createState() => _BottomCenterSectionState();
}

class _BottomCenterSectionState extends ConsumerState<BottomCenterSection> {
  late TextEditingController _timeController;
  late TextEditingController _speedController;
  late FocusNode _timeFocus;
  late FocusNode _speedFocus;

  @override
  void initState() {
    super.initState();
    // 초기 상태값을 가져와서 컨트롤러에 세팅
    final state = ref.read(robotArmControllerProvider);
    _timeController = TextEditingController(text: state.currentRunTime.toString());
    _speedController = TextEditingController(text: state.currentRunSpeed.toString());

    _timeFocus = FocusNode()..addListener(_onTimeFocusChange);
    _speedFocus = FocusNode()..addListener(_onSpeedFocusChange);
  }

  @override
  void dispose() {
    _timeController.dispose();
    _speedController.dispose();
    _timeFocus.dispose();
    _speedFocus.dispose();
    super.dispose();
  }

  // 시간 포커스가 해제될 때 검증 (1 ~ 60)
  void _onTimeFocusChange() {
    if (!_timeFocus.hasFocus) {
      int? val = int.tryParse(_timeController.text);
      if (val == null || val < 1) val = 1; // 오류 또는 1 미만이면 min값(1) 적용
      if (val > 60) val = 60; // 60을 초과하면 최대값으로 제한
      
      _timeController.text = val.toString();
      ref.read(robotArmControllerProvider.notifier).changeRunTime(val);
    }
  }

  // 속도 포커스가 해제될 때 검증 (1 ~ 100)
  void _onSpeedFocusChange() {
    if (!_speedFocus.hasFocus) {
      int? val = int.tryParse(_speedController.text);
      if (val == null || val < 1) val = 1; // 오류 또는 1 미만이면 min값(1) 적용
      if (val > 100) val = 100; // 100을 초과하면 최대값으로 제한
      
      _speedController.text = val.toString();
      ref.read(robotArmControllerProvider.notifier).changeRunSpeed(val);
    }
  }

  @override
  Widget build(BuildContext context) {
    final armControllerNotifier = ref.read(robotArmControllerProvider.notifier);
    final bleState = ref.watch(robotArmControllerProvider);
    final runMode = bleState.currentRunMode;
    final receivedData = bleState.currentReceivedData;

    // 💡 [추가] 외부에서 상태가 변경되면 UI 텍스트도 동기화합니다.
    ref.listen(robotArmControllerProvider, (prev, next) {
      if (prev?.currentRunTime != next.currentRunTime && !_timeFocus.hasFocus) {
        _timeController.text = next.currentRunTime.toString();
      }
      if (prev?.currentRunSpeed != next.currentRunSpeed && !_speedFocus.hasFocus) {
        _speedController.text = next.currentRunSpeed.toString();
      }
    });

    final String assetWalking = runMode == RobotArmRunMode.walking
        ? 'assets/rac_bt_walking_on.png'
        : 'assets/rac_bt_walking_off.png';
    final String assetRunning = runMode == RobotArmRunMode.running
        ? 'assets/rac_bt_running_on.png'
        : 'assets/rac_bt_running_off.png';

    return Column(
      children: [
        const SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 80,
              child: GestureDetector(
                // changRunMode 오타가 있다면 updateRunMode로 맞춰주세요
                onTap: () async {
                  await armControllerNotifier.changRunMode(RobotArmRunMode.walking);
                },
                child: Image.asset(assetWalking, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 30,),
            SizedBox(
              width: 150,
              height: 80,
              child: GestureDetector(
                onTap: () async {
                  await armControllerNotifier.changRunMode(RobotArmRunMode.running);
                },
                child: Image.asset(assetRunning, fit: BoxFit.contain),
              ),
            )
          ]
        ),
        const SizedBox(height: 60,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('팔 동작 시간 :', style: AppTextStyles.armController),
            const SizedBox(width: 16),
            SizedBox(
              width: 100, 
              child: TextBox(
                controller: _timeController, // 💡 컨트롤러 연결
                focusNode: _timeFocus,       // 💡 포커스 연결
                textAlign: TextAlign.center, 
                style: const TextStyle(fontSize: 20),
                onSubmitted: (_) => _timeFocus.unfocus(), // 엔터 누르면 즉시 검증
              )
            ),
            const SizedBox(width: 8),
            const Text('min', style: TextStyle(fontSize: 20)),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 24),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text('팔 동작 속도 :', style: AppTextStyles.armController),
            const SizedBox(width: 16),
            SizedBox(
              width: 100, 
              child: TextBox(
                controller: _speedController, // 💡 컨트롤러 연결
                focusNode: _speedFocus,       // 💡 포커스 연결
                textAlign: TextAlign.center, 
                style: const TextStyle(fontSize: 20),
                onSubmitted: (_) => _speedFocus.unfocus(),
              )
            ),
            const SizedBox(width: 8),
            const Text('%', style: TextStyle(fontSize: 20)),
            const Spacer(),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200, height: 130,
              child: GestureDetector(
                onTap: () async {
                  debugPrint('[긴급 정지] COMMAND 데이터전송');
                  try {
                    await armControllerNotifier.writeToRobotArm(RobotArmCommandId.emergencyStop);
                  } catch(e) {
                    debugPrint(e.toString());
                  }
                },
                child: Image.asset('assets/rac_bt_stop.png', fit: BoxFit.contain,)
              )
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 300, height: 130,
              child: GestureDetector(
                onTap: () async {
                  // 💡 전송 전 입력 중인 포커스를 해제하여 현재 텍스트 값을 검증 및 상태에 반영시킴
                  FocusManager.instance.primaryFocus?.unfocus(); 
                  
                  debugPrint('[동작 시작] COMMAND 데이터전송');
                  try {
                    await armControllerNotifier.writeToRobotArm(RobotArmCommandId.start);
                  } catch(e) {
                    debugPrint(e.toString());
                  }
                },
                child: Image.asset('assets/rac_bt_start.png', fit: BoxFit.contain,)
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text('Received Data: $receivedData', style: AppTextStyles.title,),
        const SizedBox(height: 50,)
      ]
    );
  }
}