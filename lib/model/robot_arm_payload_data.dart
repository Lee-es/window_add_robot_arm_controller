
import 'package:freezed_annotation/freezed_annotation.dart';

part 'robot_arm_payload_data.freezed.dart';

@freezed
sealed class RobotArmPayloadData with _$RobotArmPayloadData {

  const RobotArmPayloadData._();

  const factory RobotArmPayloadData({
    required int commandId,
    required int runMode,
    required int runSpeed,
    required int turnAngle
  }) = _RobotArmPayloadData;

}