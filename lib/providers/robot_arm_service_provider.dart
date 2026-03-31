import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:window_add_robot_arm_controller/services/robot_arm_bluetooth_service.dart';

final robotArmServiceProvider = Provider<RobotArmBluetoothService>((ref) {
  final service = RobotArmBluetoothService();
  ref.onDispose(service.dispose);
  return service;
});
