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

  static const String robotArmServiceUuid = '0000abcd-0000-1000-8000-00805f9b34fb';
  static const String robotArmCharacteristicReadUuid = '0000dcba-0000-1000-8000-00805f9b34fb';
  static const String robotArmCharacteristicWriteUuid = '0000dcbb-0000-1000-8000-00805f9b34fb';

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
