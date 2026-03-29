import 'dart:async';
import 'dart:io'; // 💡 [윈도우 수정] 플랫폼(Windows, Android 등) 구분을 위해 추가



// 💡 [윈도우 수정] 1. 패키지 임포트 변경
// 기존 모바일용 FlutterBluePlus 클래스를 숨기고(hide), 
// 윈도우 환경을 완벽하게 지원하는 브릿지 패키지의 클래스를 대신 사용합니다.
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_blue_plus_windows/flutter_blue_plus_windows.dart';
import 'package:window_add_robot_arm_controller/config/bluetooth_constants.dart';


/// BLE 연결 상태를 나타내는 열거형
enum BleConnectionStatus { disconnected, connecting, connected, disconnecting }

/// 블루투스 공통 서비스 클래스 (Windows 최적화 버전)
class BleService {
  // ========================================
  // Private Fields
  // ========================================

  BluetoothDevice? _connectedDevice;
  StreamSubscription<List<ScanResult>>? _scanSubscription;
  StreamSubscription<BluetoothConnectionState>? _connectionStateSubscription;

  final StreamController<BleConnectionStatus> _connectionStatusController =
      StreamController<BleConnectionStatus>.broadcast();

  BleConnectionStatus _currentStatus = BleConnectionStatus.disconnected;

  // ========================================
  // Getters
  // ========================================

  BluetoothDevice? get connectedDevice => _connectedDevice;
  Stream<BleConnectionStatus> get connectionStatusStream => _connectionStatusController.stream;
  BleConnectionStatus get currentStatus => _currentStatus;
  bool get isConnected => _connectedDevice?.isConnected ?? false;

  // ========================================
  // Public Methods - Device Discovery
  // ========================================

  BluetoothAdapterState? _lastAdapterState;
  StreamSubscription<BluetoothAdapterState>? _adapterStateSubscription;

  BleService() {
    _adapterStateSubscription = FlutterBluePlus.adapterState.listen((state) {
      _lastAdapterState = state;
      debugPrint('[BLE] adapterState changed: $state');
    });
  }

  Future<void> waitForAdapterOn() async {
    final current = _lastAdapterState ?? await FlutterBluePlus.adapterState.first;
    if (current == BluetoothAdapterState.on) {
      debugPrint('[BLE] Adapter already ON');
      return;
    }

    debugPrint('[BLE] Waiting for adapter to turn ON...');
    await FlutterBluePlus.adapterState.firstWhere(
      (s) => s == BluetoothAdapterState.on,
    );
    debugPrint('[BLE] Adapter is ON now');
  }

  /// 페어링된 모든 기기 조회
  Future<List<BluetoothDevice>> getBondedDevices() async {
    // 💡 [윈도우 수정] 2. 윈도우 페어링 목록 지원 예외 처리
    // 윈도우 OS의 BLE API는 시스템에 페어링된 기기 목록을 가져오는 기능을 
    // 모바일처럼 완벽하게 지원하지 않을 수 있습니다.
    if (Platform.isWindows) {
      debugPrint('[BLE] Windows에서는 시스템 페어링 기기 목록 조회를 지원하지 않습니다. 스캔(Scan)을 사용해주세요.');
      return [];
    }

    try {
      return await FlutterBluePlus.bondedDevices;
    } catch (e) {
      debugPrint('Error getting bonded devices: $e');
      return [];
    }
  }

  /// 특정 키워드로 페어링된 기기 필터링
  Future<List<BluetoothDevice>> getBondedDevicesByKeywords(List<String> keywords) async {
    final bondedDevices = await getBondedDevices();
    if (bondedDevices.isEmpty) return [];

    final filteredDevices = <BluetoothDevice>[];
    for (var device in bondedDevices) {
      final name = device.platformName.toUpperCase();
      for (var keyword in keywords) {
        if (name.contains(keyword.toUpperCase())) {
          filteredDevices.add(device);
          break;
        }
      }
    }
    return filteredDevices;
  }

  /// BLE 기기 스캔 시작
  Future<void> startScan({
    List<String> serviceUuids = const [],
    Duration timeout = const Duration(seconds: BluetoothConstants.scanTimeoutSeconds),
    Function(BluetoothDevice device)? onDeviceFound,
  }) async {
    try {

      await waitForAdapterOn();

      await stopScan();

      final filters = serviceUuids.map((uuid) => Guid(uuid)).toList();

      await FlutterBluePlus.startScan(withServices: filters, timeout: timeout);

      _scanSubscription = FlutterBluePlus.scanResults.listen((results) {
        for (var result in results) {
          final device = result.device;
          final deviceName = device.platformName.toUpperCase();
          if (onDeviceFound != null) {
            final targetDeviceName = BluetoothConstants.armDeviceName.toUpperCase();
            if( deviceName.contains(targetDeviceName)){
              debugPrint('Device found: $deviceName (${device.remoteId.str})');
              onDeviceFound.call(device);
              stopScan();
            }
          }
        }
      });
  
    } catch (e) {
      debugPrint('Error starting scan: $e');
      rethrow;
    }
  }

  /// BLE 스캔 중지
  Future<void> stopScan() async {
    try {
        await _scanSubscription?.cancel();
        _scanSubscription = null;

      if (FlutterBluePlus.isScanningNow) {
        await FlutterBluePlus.stopScan();
      }
    } catch (e) {
      debugPrint('Error stopping scan: $e');
    }
  }

  // ========================================
  // Public Methods - Connection Management
  // ========================================

  /// 기기에 연결
  Future<void> connect(
    BluetoothDevice device, {
    required bool autoConnect,
    bool createBond = false,
  }) async {
    try {
      _connectionStateSubscription?.cancel();
      _connectionStateSubscription = device.connectionState.listen((state) {
        _handleConnectionStateChange(device, state);
      });

      if (device.isConnected) {
        _updateConnectionStatus(BleConnectionStatus.connected);
        return;
      }

      _updateConnectionStatus(BleConnectionStatus.connecting);

      // 💡 [윈도우 수정] 3. 연결 파라미터 안정화
      // - 윈도우에서는 autoConnect: true가 오작동을 일으킬 수 있어 false로 강제하는 것이 안전합니다.
      // - 구버전의 license 파라미터는 윈도우 환경에서 에러를 유발할 수 있어 제거했습니다.
      final bool isWindowsAutoConnect = Platform.isWindows ? false : autoConnect;

      await device.connect(
        autoConnect: false, 
        mtu: null,
      );
      
      _connectedDevice = device;
    } catch (e) {
      _updateConnectionStatus(BleConnectionStatus.disconnected);
      debugPrint('Connection error: $e');
      rethrow;
    }
  }

  /// 기기 연결 해제
  Future<void> disconnect() async {
    if (_connectedDevice == null) return;

    try {
      _updateConnectionStatus(BleConnectionStatus.disconnecting);
      debugPrint('Disconnecting from ${_connectedDevice!.remoteId.str}...');

      await _connectedDevice!.disconnect();
      _connectedDevice = null;

      _updateConnectionStatus(BleConnectionStatus.disconnected);
      debugPrint('Device disconnected');
    } catch (e) {
      debugPrint('Disconnection error: $e');
      rethrow;
    }
  }

  // ========================================
  // Public Methods - Service & Characteristic
  // ========================================

  /// 연결된 기기의 서비스 탐색
  Future<List<BluetoothService>> discoverServices() async {
    if (_connectedDevice == null || !_connectedDevice!.isConnected) {
      throw Exception('No device connected');
    }

    try {
      debugPrint('Discovering services...');
      final services = await _connectedDevice!.discoverServices();
      debugPrint('Found ${services.length} services');
      return services;
    } catch (e) {
      debugPrint('Error discovering services: $e');
      rethrow;
    }
  }

  /// 특정 UUID의 서비스 찾기
  Future<BluetoothService?> findService(
    String serviceUuid, {
    List<BluetoothService>? services,
  }) async {
    services ??= await discoverServices();

    for (var service in services) {
      if (service.uuid.toString().toUpperCase().contains(
        serviceUuid.toUpperCase(),
      )) {
        return service;
      }
    }
    return null;
  }

  /// 서비스에서 특정 UUID의 특성 찾기
  BluetoothCharacteristic? findCharacteristic(
    BluetoothService service,
    String characteristicUuid,
  ) {
    for (var characteristic in service.characteristics) {
      if (characteristic.uuid.toString().toUpperCase().contains(
        characteristicUuid.toUpperCase(),
      )) {
        return characteristic;
      }
    }
    return null;
  }

  /// 특성에 알림 구독
  Future<StreamSubscription<List<int>>> subscribeToCharacteristic(
    BluetoothCharacteristic characteristic,
    void Function(List<int> data) onData,
  ) async {
    try {
      await characteristic.setNotifyValue(true);
      debugPrint('Subscribed to characteristic: ${characteristic.uuid}');

      return characteristic.lastValueStream.listen((value) {
        if (value.isNotEmpty) {
          onData(value);
        }
      });
    } catch (e) {
      debugPrint('Error subscribing to characteristic: $e');
      rethrow;
    }
  }

  /// 특성에 데이터 쓰기
  Future<void> writeCharacteristic(
    BluetoothCharacteristic characteristic,
    List<int> data,
  ) async {
    try {
     debugPrint('Data written to characteristic: ${characteristic.uuid}');
      await characteristic.write(data);
      
    } catch (e) {
      debugPrint('Error writing to characteristic: $e');
      rethrow;
    }
  }

  // ========================================
  // Private Methods
  // ========================================

  /// 연결 상태 변경 처리
  void _handleConnectionStateChange(
    BluetoothDevice device,
    BluetoothConnectionState state,
  ) {
    debugPrint('Connection state changed: $state');

    switch (state) {
      case BluetoothConnectionState.connected:
        _updateConnectionStatus(BleConnectionStatus.connected);
        break;
      case BluetoothConnectionState.disconnected:
        if (_connectedDevice?.remoteId.str == device.remoteId.str) {
          _updateConnectionStatus(BleConnectionStatus.disconnected);
        }
        break;
      // ignore: deprecated_member_use
      case BluetoothConnectionState.connecting:
        _updateConnectionStatus(BleConnectionStatus.connecting);
        break;
      // ignore: deprecated_member_use
      case BluetoothConnectionState.disconnecting:
        _updateConnectionStatus(BleConnectionStatus.disconnecting);
        break;
    }
  }

  /// 연결 상태 업데이트
  void _updateConnectionStatus(BleConnectionStatus status) {
    _currentStatus = status;
    _connectionStatusController.add(status);
  }

  // ========================================
  // Dispose
  // ========================================

  /// 리소스 정리
  void dispose() {
    _connectionStateSubscription?.cancel();
    _adapterStateSubscription?.cancel();
    
    // 💡 [윈도우 수정] 4. 안드로이드 전용 기능 분기 처리
    // clearGattCache()는 안드로이드에서만 지원되는 기능이므로, 
    // 윈도우에서 호출 시 에러(PlatformException)가 발생합니다.
    if (Platform.isAndroid) {
      _connectedDevice?.clearGattCache(); 
    }
    
    _connectedDevice?.disconnect();
    _connectionStatusController.close();
    debugPrint('BleService disposed');
  }
}