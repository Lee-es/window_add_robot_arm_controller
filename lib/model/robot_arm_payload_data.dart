
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

part 'robot_arm_payload_data.freezed.dart';

@freezed
sealed class RobotArmPayloadData with _$RobotArmPayloadData {

  const RobotArmPayloadData._();

  const factory RobotArmPayloadData({
    required RobotArmCommandId commandId,
    required RobotArmRunMode runMode,
    required int runSpeed,
    required int turnAngle
  }) = _RobotArmPayloadData;

  factory RobotArmPayloadData.initial() => const RobotArmPayloadData(
    commandId: RobotArmCommandId.idle,
    runMode: RobotArmRunMode.idle,
    runSpeed: 1,
    turnAngle: -180
  );
}