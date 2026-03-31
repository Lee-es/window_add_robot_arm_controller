import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/theme/app_theme.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_controller_notifier.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

class BottomLeftSection extends ConsumerWidget {
  const BottomLeftSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final armControllerNotifier = ref.read(robotArmControllerProvider.notifier);
    final bleState = ref.watch(robotArmControllerProvider);
    final isRunning = bleState.isRobotArmRunning;

    final String assetsClothed = isRunning
        ? 'assets/rac_bt_wearing_off.png'
        : 'assets/rac_bt_wearing_on.png';
    final String assetsReset = isRunning
        ? 'assets/rac_bt_return_off.png'
        : 'assets/rac_bt_return_on.png';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Expanded(flex: 2, child: Text('상의 착의', style: AppTextStyles.title)),
          Expanded(
            flex: 8,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Image.asset(
                      'assets/robot_1.png',
                      fit: BoxFit.contain,
                      alignment: AlignmentGeometry.bottomCenter,
                    ),
                  ),
                ),
                const SizedBox(width: 5),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    width: double.infinity,
                    height: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Image.asset(
                        'assets/robot_2.png',
                        fit: BoxFit.contain,
                        alignment: AlignmentGeometry.bottomCenter,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 1,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: () async {
                        debugPrint('[의복 착의 시작] COMMAND 데이터전송');
                        if (isRunning) return;
                        try {
                          await armControllerNotifier.writeToRobotArm(
                            RobotArmCommandId.clothed,
                          );
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(assetsClothed, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  flex: 1,
                  child: SizedBox(
                    child: GestureDetector(
                      onTap: () async {
                        debugPrint('[의복 착의 시작] COMMAND 데이터전송');
                        if (isRunning) return; // 실행 중에는 모드 변경 불가
                        try {
                          await armControllerNotifier.writeToRobotArm(
                            RobotArmCommandId.reset,
                          );
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(5),
                        child: Image.asset(assetsReset, fit: BoxFit.contain),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
