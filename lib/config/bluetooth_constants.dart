/// bluetooth_constants.dart
///
/// 블루투스 통신에 사용되는 UUID 및 상수 정의
///
/// 이 파일은 Bluetooth Low Energy (BLE) 통신에 필요한 모든 상수를 중앙에서 관리합니다.
/// - Blood Pressure Service UUID
/// - Current Time Service UUID
/// - 기타 BLE 관련 상수

class BluetoothConstants {
  // Private constructor to prevent instantiation
  BluetoothConstants._();


  static const String armDeviceName = 'Robot_Arm_Controller';


  static const String robotArmAdvertisedUuid = '95484DB8-8566-0B54-EA54-53B5EE31789E';
  static const String robotArmServiceUuid = '9b666c50-66c1-48aa-a2b7-552eec397c02';
  static const String robotArmCharacteristicReadUuid = '3b252962-6eac-43f7-b7d9-9293c392d72e';
  static const String robotArmCharacteristicWriteUuid = '958df18f-668f-480d-9660-37e37f67f5b4';

  // ========================================
  // Connection & Timing
  // ========================================

  /// 기기 스캔 타임아웃 (초)
  static const int scanTimeoutSeconds = 15;

  /// 데이터 수신 후 연결 유지 시간 (초)
  static const int dataReceiveDelaySeconds = 1;

  /// 연결 대기 시간 (초)
  static const int connectionWaitSeconds = 3;

  /// 데이터 수신 대기 시간 (초)
  static const int dataWaitSeconds = 2;

  /// 자동 동기화 주기 (초)
  static const int autoSyncIntervalSeconds = 5;

  /// 중복 데이터 방지 시간 간격 (초)
  static const int duplicateDataThresholdSeconds = 1;

  /// 수동 동기화 타임아웃 (초)
  static const int manualSyncTimeoutSeconds = 10;

  // 최대 패킷 크기 (바이트)
  static const int maxPacketSizeBytes = 9;

  // ========================================
  // Flags
  // ========================================
  // STX
  static const int stxFirst = 0xFF; 
  static const int stxSecond = 0xFF; 

  //CMD Flags
  static const int cmdIdle = 0x00;
  static const int cmdClothed = 0x01; // [의복 착의] 정지 상태에서 Torque를 해제
  static const int cmdReset = 0x02; // [원 위치] 동작 중은 정지를 하고 Torque를 설정
  static const int cmdEmergencyStop = 0x03; // [긴급 정지] 동작 중 일 경우 속도를 낮추고 천천히 정지를 하고 Torque는 설정
  static const int cmdStart = 0x06; // [동작 시작] 걷기, 뛰기에 따라 설정 된 속도로 설정된 시간 동안만 동작.
  static const int cmdTurnTable = 0x07; //[턴 테이블] 설정된 각도(-180 ~ 180)로 동작 단, 속도는 최대한 천천히 동작

  
 // Run Flags
  static const int runIdle = 0x00; // 정지 상태
  static const int runWalking = 0x02; // 걷기 동작으로 실행
  static const int runRunning = 0x03; // 달리기 동작으로 실행


  // ========================================================================
  // 패킷 위치 상수
  // ========================================================================
  static const int indexStxFirst = 0; // STX 첫 번째 바이트 위치
  static const int indexStxSecond = 1; // STX 두 번째 바이트 위치
  
  static const int indexCmd = 2; // CMD 위치  
  
  static const int indexRunMode = 3; // Run 위치
  static const int indexRunTime = 4;
  
  static const int indexRunSpeed = 5; // Speed 위치
  
  static const int indexTurnAngleHigh = 6; // Turn Angle High 위치
  static const int indexTurnAngleLow = 7; // Turn Angle Low 위치

  static const int indexChecksum = maxPacketSizeBytes - 1; // Checksum 위치
}