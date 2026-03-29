import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/core/bluetooth_service.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_controller_notifier.dart';

import '../../core/theme/app_theme.dart';

class TopSection extends ConsumerWidget {
  
  const TopSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final bleState = ref.watch(robotArmControllerProvider);
    final currentStatus = bleState.connectionStatus;

    Color statusColor;
    String statusText;

    switch (currentStatus) {
      case BleConnectionStatus.connected:
        statusColor = AppColors.greenColor;
        statusText = '블루투스 연결됨';
        break;
      case BleConnectionStatus.connecting:
        statusColor = AppColors.redColor;
        statusText = '블루투스 연결 안됨';
        break;
      case BleConnectionStatus.disconnected:
      default:
        statusColor = AppColors.redColor;
        statusText = '블루투스 연결 안됨';
        break;
    }



    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
            Row(
              children: [
                Container(width: 16, height: 16, decoration: BoxDecoration(color: AppColors.greenColor, shape: BoxShape.circle)),
                const SizedBox(width: 12),
                const Text('ADD Robot Arm Controller', style: AppTextStyles.title),
              ],
            ),
            Row(
              children: [
                Container(width: 16, height: 16, decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle)),
                const SizedBox(width: 8),
                Text(statusText, style: AppTextStyles.connectionStatus),
              ],
            )
          ],
      ),
    );
  }

}