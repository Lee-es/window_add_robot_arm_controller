import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_controller_notifier.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

class BottomCenterSection extends ConsumerStatefulWidget {
  const BottomCenterSection({super.key});

  @override
  ConsumerState<BottomCenterSection> createState() =>
      _BottomCenterSectionState();
}

class _BottomCenterSectionState extends ConsumerState<BottomCenterSection> {
  late TextEditingController _timeController;
  late FocusNode _timeFocus;
  late FocusNode _speedFocus;

  @override
  void initState() {
    super.initState();
    // 초기 상태값을 가져와서 컨트롤러에 세팅
    final state = ref.read(robotArmControllerProvider);
    _timeController = TextEditingController(
      text: state.currentRunTime.toString(),
    );

    _timeFocus = FocusNode()..addListener(_onTimeFocusChange);
  }

  @override
  void dispose() {
    _timeController.dispose();
    _timeFocus.dispose();
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

  @override
  Widget build(BuildContext context) {
    final armControllerNotifier = ref.read(robotArmControllerProvider.notifier);
    final bleState = ref.watch(robotArmControllerProvider);
    final runMode = bleState.currentRunMode;
    final receivedData = bleState.currentReceivedData;
    final runSpeed = bleState.currentRunSpeed;
    final isRunning = bleState.isRobotArmRunning;

    // 💡 [추가] 외부에서 상태가 변경되면 UI 텍스트도 동기화합니다.
    ref.listen(robotArmControllerProvider, (prev, next) {
      if (prev?.currentRunTime != next.currentRunTime && !_timeFocus.hasFocus) {
        _timeController.text = next.currentRunTime.toString();
      }
    });

    final String assetWalking = runMode == RobotArmRunMode.walking
        ? 'assets/rac_bt_walking_on.png'
        : 'assets/rac_bt_walking_off.png';
    final String assetRunning = runMode == RobotArmRunMode.running
        ? 'assets/rac_bt_running_on.png'
        : 'assets/rac_bt_running_off.png';

    final String assetSlow = runSpeed == RobotArmRunSpeedMode.slow
        ? 'assets/rac_bt_slow_on.png'
        : 'assets/rac_bt_slow_off.png';
    final String assetNormal = runSpeed == RobotArmRunSpeedMode.normal
        ? 'assets/rac_bt_standard_on.png'
        : 'assets/rac_bt_standard_off.png';
    final String assetFast = runSpeed == RobotArmRunSpeedMode.fast
        ? 'assets/rac_bt_fast_on.png'
        : 'assets/rac_bt_fast_off.png';
    final String assetStart = isRunning
        ? 'assets/rac_bt_run_stop.png'
        : 'assets/rac_bt_start.png';

    return Column(
      children: [
        const SizedBox(height: 5),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 150,
              height: 80,
              child: GestureDetector(
                onTap: () async {
                  if (isRunning) return; // 실행 중에는 모드 변경 불가
                  await armControllerNotifier.changRunMode(
                    RobotArmRunMode.walking,
                  );
                },
                child: Image.asset(assetWalking, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 30),
            SizedBox(
              width: 150,
              height: 80,
              child: GestureDetector(
                onTap: () async {
                  if (isRunning) return; // 실행 중에는 모드 변경 불가
                  await armControllerNotifier.changRunMode(
                    RobotArmRunMode.running,
                  );
                },
                child: Image.asset(assetRunning, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
        const SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 50),
            const Text('팔 동작 시간 :', style: AppTextStyles.armController),
            const SizedBox(width: 16),
            SizedBox(
              width: 100,
              child: TextBox(
                controller: _timeController, // 💡 컨트롤러 연결
                focusNode: _timeFocus, // 💡 포커스 연결
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20),
                onSubmitted: (_) => _timeFocus.unfocus(), // 엔터 누르면 즉시 검증
                enabled: !isRunning, // 실행 중에는 입력 비활성화
              ),
            ),
            const SizedBox(width: 8),
            const Text('min', style: TextStyle(fontSize: 20)),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 50),
            const Text('팔 동작 속도 :', style: AppTextStyles.armController),
            const SizedBox(width: 16),
            SizedBox(
              width: 100,
              height: 80,
              child: GestureDetector(
                onTap: () async {
                  if (isRunning) return; // 실행 중에는 속도 변경 불가
                  await armControllerNotifier.changeRunSpeed(
                    RobotArmRunSpeedMode.fast,
                  );
                },
                child: Image.asset(assetFast, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              height: 80,
              child: GestureDetector(
                onTap: () async {
                  if (isRunning) return; // 실행 중에는 속도 변경 불가
                  await armControllerNotifier.changeRunSpeed(
                    RobotArmRunSpeedMode.normal,
                  );
                },
                child: Image.asset(assetNormal, fit: BoxFit.contain),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 100,
              height: 80,
              child: GestureDetector(
                onTap: () async {
                  if (isRunning) return; // 실행 중에는 속도 변경 불가
                  await armControllerNotifier.changeRunSpeed(
                    RobotArmRunSpeedMode.slow,
                  );
                },
                child: Image.asset(assetSlow, fit: BoxFit.contain),
              ),
            ),

            const Spacer(),
          ],
        ),
        const Spacer(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 130,
              child: GestureDetector(
                onTap: () async {
                  debugPrint('[긴급 정지] COMMAND 데이터전송');
                  try {
                    await armControllerNotifier.writeToRobotArm(
                      RobotArmCommandId.emergencyStop,
                    );
                    await armControllerNotifier.changeRobotArmRunningStatus(
                      false,
                    ); // 정지 상태로 변경
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: Image.asset(
                  'assets/rac_bt_stop.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              width: 300,
              height: 130,
              child: GestureDetector(
                onTap: () async {
                  if (isRunning) return; // 실행 중에는 속도 변경 불가
                  // 💡 전송 전 입력 중인 포커스를 해제하여 현재 텍스트 값을 검증 및 상태에 반영시킴
                  FocusManager.instance.primaryFocus?.unfocus();

                  debugPrint('[동작 시작] COMMAND 데이터전송');
                  try {
                    await armControllerNotifier.writeToRobotArm(
                      RobotArmCommandId.start,
                    );
                    await armControllerNotifier.changeRobotArmRunningStatus(
                      true,
                    ); // 실행 상태로 변경
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                },
                child: Image.asset(assetStart, fit: BoxFit.contain),
              ),
            ),
          ],
        ),
        const Spacer(),
        Text('Received Data: $receivedData', style: AppTextStyles.title),
        const SizedBox(height: 50),
      ],
    );
  }
}
