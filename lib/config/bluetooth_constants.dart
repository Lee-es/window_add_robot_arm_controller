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


}
