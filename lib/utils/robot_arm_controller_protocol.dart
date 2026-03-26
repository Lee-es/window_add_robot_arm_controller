

import 'dart:typed_data';

import 'package:window_add_robot_arm_controller/config/bluetooth_constants.dart';
import 'package:window_add_robot_arm_controller/model/robot_arm_payload_data.dart';

enum RobotArmCommandId {
  
  idle(BluetoothConstants.cmdIdle,'IDLE'),
  clothed(BluetoothConstants.cmdClothed,'의복 착의'),
  reset(BluetoothConstants.cmdReset,'원 위치'),
  emergencyStop(BluetoothConstants.cmdEmergencyStop,'긴급 정지'),
  start(BluetoothConstants.cmdStart,'동작 시작'),
  turnTable(BluetoothConstants.cmdTurnTable,'턴 테이블');

  final int code;
  final String name;

  const RobotArmCommandId(this.code, this.name);
}

enum RobotArmRunMode{

  idle(BluetoothConstants.runIdle,'정지'),
  walking(BluetoothConstants.runWalking,'걷기'),
  running(BluetoothConstants.runRunning,'달리기');

  final int code;
  final String name;
  const RobotArmRunMode(this.code, this.name);

}


class RobotArmControllerProtocol {

  RobotArmControllerProtocol._();


  /// 프로토콜 패킷 생성
  static Uint8List createProtocolPacket({required final RobotArmPayloadData payloadData}) {
    Uint8List packet = Uint8List(BluetoothConstants.maxPacketSizeBytes);
    
    packet[BluetoothConstants.indexStxFirst] = BluetoothConstants.stxFirst;
    packet[BluetoothConstants.indexStxSecond] = BluetoothConstants.stxSecond;
    packet[BluetoothConstants.indexCmd] = payloadData.commandId;
    packet[BluetoothConstants.indexRunMode] = payloadData.runMode;
    packet[BluetoothConstants.indexRunSpeed] = payloadData.runSpeed;

    Uint8List angleBytes = TurnAngleConverter.angleToBytes(payloadData.turnAngle);
    packet[BluetoothConstants.indexTurnAngleHigh] = angleBytes[0];
    packet[BluetoothConstants.indexTurnAngleLow] = angleBytes[1];

    // 체크섬 계산
    packet[BluetoothConstants.indexChecksum] = _calculateChecksum(packet);

    return packet;
  }



  /// XOR 방식의 체크섬 계산
  /// 패킷의 0번 인덱스부터 maxPacketSizeBytes - 1 인덱까지의 바이트를 XOR 연산하여 체크섬을 계산
  static int _calculateChecksum(Uint8List packet) {
    int checksum = 0x00;
    int length = BluetoothConstants.maxPacketSizeBytes -1;
    for (int i = 0; i < length; i++) {
      checksum ^= packet[i];
    }
    return checksum; 
  }


}

class TurnAngleConverter {
  TurnAngleConverter._();

  static const int protocolValueMin = 0;
  static const int protocolValueMax = 359;

  // 사용자 입력 각도를 프로토콜에 맞춰서 바이트로 변환 (예: -180도 ~ 180도를  0 ~ 359  2바이트 값으로 변환)
  static Uint8List angleToBytes(int angle){

    int protocolValue = angle + 180;

    if(protocolValue >protocolValueMax){
      protocolValue = protocolValueMax;
    } else if(protocolValue <protocolValueMin){
      protocolValue = protocolValueMin;
    }

    Uint8List bytes = Uint8List(2);
    bytes[0] = (protocolValue >> 8) & 0xFF; // high
    bytes[1] = protocolValue & 0xFF; // low
    return bytes;

  }

  static int bytesToAngle(int high, int low){
    int protocolValue = (high << 8) | low;
    int angle = protocolValue - 180;
    return angle;
  }
}