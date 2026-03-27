
import 'dart:async';
import 'dart:typed_data';

import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_blue_plus/flutter_blue_plus.dart';
import 'package:flutter_blue_plus_windows/flutter_blue_plus_windows.dart';
import 'package:window_add_robot_arm_controller/config/bluetooth_constants.dart';
import 'package:window_add_robot_arm_controller/core/bluetooth_service.dart';
import 'package:window_add_robot_arm_controller/model/robot_arm_payload_data.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

class RobotArmBluetoothService {


late final BleService _bluetoothService;
final StreamController<Uint8List> _robotArmDataController = 
StreamController<Uint8List>.broadcast();

StreamSubscription<List<int>>? _robotArmDataSubscription;

/// 로봇 팔 데이터 스트림
Stream<Uint8List> get robotArmDataStream => _robotArmDataController.stream;

Stream<BleConnectionStatus> get connectionStatusStream =>
_bluetoothService.connectionStatusStream;

BluetoothDevice? get connectedDevice => _bluetoothService.connectedDevice;

bool get isConnected => _bluetoothService.isConnected;

StreamSubscription<BleConnectionStatus>? _connSub;


BluetoothCharacteristic? _writeCharacteristic;


RobotArmBluetoothService() {
  _bluetoothService = BleService();
  _connSub?.cancel();
  _connSub = connectionStatusStream.listen((status) async{
   
    if(status == BleConnectionStatus.connected){
      debugPrint('======connected to robot arm controller======');
      await _setupRobotArmService();
    } else if(status == BleConnectionStatus.disconnected){
      debugPrint('======disconnected from robot arm controller======');
      await _robotArmDataSubscription?.cancel();
      _robotArmDataSubscription = null;
    }

   }); 
}

Future<void> _setupRobotArmService() async{
  try{
    final service = await _bluetoothService.discoverServices();

    BluetoothService? robotArmService;

    for(var s in service){
      final uuid = s.uuid.toString().toUpperCase();

      if(uuid.contains(BluetoothConstants.robotArmServiceUuid.toUpperCase())){
        robotArmService = s;
        break;
      }
    }

    if(robotArmService != null){
      await _subscribeToRobotArmData(robotArmService);
      debugPrint('Robot Arm Service found');
      _writeCharacteristic = _bluetoothService.findCharacteristic(
          robotArmService,
          BluetoothConstants.robotArmCharacteristicWriteUuid
        );

    }else{
      debugPrint('Warning: Service UUID Not Found');
      }

  } catch(e){
    debugPrint('Error setting up Robot Arm Service: $e');
  }

}

Future<void> _subscribeToRobotArmData(BluetoothService service) async {
  try {
   
   final charcteristic = _bluetoothService.findCharacteristic(
    service,
    BluetoothConstants.robotArmCharacteristicReadUuid
   );

  if(charcteristic == null){
    debugPrint('Warning: Characteristic UUID Not Found');
    return;
  }

  await _robotArmDataSubscription?.cancel();
  _robotArmDataSubscription = null;

  _robotArmDataSubscription = await _bluetoothService.subscribeToCharacteristic(
  charcteristic,
  _handleReceivedData,
  );

   debugPrint('Subscribed to Robot Arm data stream');

  }catch (e) {
    debugPrint('Error subscribing to Robot Arm data: $e');
    rethrow;
    }
}

void _handleReceivedData(List<int> data) {
  try{
  debugPrint('Received data from Robot Arm: $data');
  _robotArmDataController.add(Uint8List.fromList(data));
  }catch(e){
    debugPrint('Error handling received data: $e');
  }
}

Future<void> writeData(RobotArmPayloadData data) async {
  try{
    if(connectedDevice == null || _writeCharacteristic == null){
      debugPrint('No device connected or write characteristic not found. Cannot write data.');
      return;
    }


    debugPrint('Data written to Robot Arm: $data');    

    final packetData = RobotArmControllerProtocol.createProtocolPacket(payloadData: data);

    await _bluetoothService.writeCharacteristic(
        _writeCharacteristic!,
        packetData,
      );


  }catch(e){
    debugPrint('Error writing data to Robot Arm: $e');
  }
}

Future<void> scanForRobotArmDevices() async {


try{

  await _bluetoothService.startScan(
    onDeviceFound: onDeviceFound
  );

}catch(e){
  debugPrint('Error during scanning: $e');
}

}

Future<void> dispose() async {
 _connSub?.cancel();
 _robotArmDataSubscription?.cancel();
  _robotArmDataSubscription = null;
  _writeCharacteristic = null;
 _bluetoothService.dispose();
 _robotArmDataController.close();
}

Future<void> disconnect() async {
  await _robotArmDataSubscription?.cancel();
  _robotArmDataSubscription = null;
  _writeCharacteristic = null;
  await _bluetoothService.disconnect();
  }

void onDeviceFound(BluetoothDevice device) async {
   debugPrint('============Robot Arm Device Servcie=====');
   debugPrint('Device found: ${device.platformName} (${device.remoteId.str})');

   await _bluetoothService.connect(device, autoConnect: false);

}

}