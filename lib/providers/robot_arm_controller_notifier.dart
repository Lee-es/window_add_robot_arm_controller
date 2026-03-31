import 'package:fluent_ui/fluent_ui.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:window_add_robot_arm_controller/core/bluetooth_service.dart';
import 'package:window_add_robot_arm_controller/model/robot_arm_payload_data.dart';
import 'package:window_add_robot_arm_controller/providers/robot_arm_service_provider.dart';
import 'package:window_add_robot_arm_controller/services/robot_arm_bluetooth_service.dart';
import 'package:window_add_robot_arm_controller/utils/robot_arm_controller_protocol.dart';

part 'robot_arm_controller_notifier.g.dart';

class RobotArmControllerState {
  final BleConnectionStatus bleConnectionStatus;
  final RobotArmRunMode runMode;
  final int runTime;
  final RobotArmRunSpeedMode runSpeed;
  final int turnAngle;
  final List<int> receivedData;
  final bool isRobotArmRunning;

  const RobotArmControllerState({
    this.bleConnectionStatus = BleConnectionStatus.disconnected,
    this.runMode = RobotArmRunMode.running,
    this.runTime = 1,
    this.runSpeed = RobotArmRunSpeedMode.normal,
    this.turnAngle = 0,
    this.receivedData = const [],
    this.isRobotArmRunning = false,
  });

  RobotArmControllerState copyWith({
    BleConnectionStatus? bleConnectionStatus,
    RobotArmRunMode? runMode,
    int? runTime,
    RobotArmRunSpeedMode? runSpeed,
    int? turnAngle,
    List<int>? receivedData,
    bool? isRobotArmRunning,
  }) {
    return RobotArmControllerState(
      bleConnectionStatus: bleConnectionStatus ?? this.bleConnectionStatus,
      runMode: runMode ?? this.runMode,
      runTime: runTime ?? this.runTime,
      runSpeed: runSpeed ?? this.runSpeed,
      turnAngle: turnAngle ?? this.turnAngle,
      receivedData: receivedData ?? this.receivedData,
      isRobotArmRunning: isRobotArmRunning ?? this.isRobotArmRunning,
    );
  }

  BleConnectionStatus get connectionStatus => bleConnectionStatus;
  RobotArmRunMode get currentRunMode => runMode;
  int get currentRunTime => runTime;
  RobotArmRunSpeedMode get currentRunSpeed => runSpeed;
  int get currentTurnAngle => turnAngle;
  List<int> get currentReceivedData => receivedData;

  static const RobotArmControllerState initial = RobotArmControllerState();
}

@Riverpod(keepAlive: true)
class RobotArmControllerNotifier extends _$RobotArmControllerNotifier {
  late final RobotArmBluetoothService _bluetoothService;

  @override
  RobotArmControllerState build() {
    _bluetoothService = ref.watch(robotArmServiceProvider);

    final subBleCurrentStatus = _bluetoothService.connectionStatusStream.listen(
      (status) {
        debugPrint('[Notifier] BLE 상태 변경: $status');
        state = state.copyWith(bleConnectionStatus: status);
      },
    );

    final subBleReceivedData = _bluetoothService.robotArmDataStream.listen((
      data,
    ) {
      debugPrint('[Notifier] BLE 데이터 수신: $data');
      state = state.copyWith(receivedData: data);
    });

    ref.onDispose(() {
      subBleCurrentStatus.cancel();
      subBleReceivedData.cancel();
    });

    return RobotArmControllerState.initial;
  }

  Future<void> startArmControl() async {
    await _bluetoothService.scanForRobotArmDevices();
  }

  Future<void> writeToRobotArm(final RobotArmCommandId commandId) async {
    final runMode = state.runMode;
    final runTime = state.runTime;
    final runSpeed = state.runSpeed;
    final turnAngle = state.turnAngle;

    final payLoadData = RobotArmPayloadData(
      commandId: commandId,
      runMode: runMode,
      runTime: runTime,
      runSpeed: runSpeed,
      turnAngle: turnAngle,
    );

    await _bluetoothService.writeData(payLoadData);
  }

  Future<void> changRunMode(RobotArmRunMode mode) async {
    state = state.copyWith(runMode: mode);
  }

  Future<void> changeRunTime(int time) async {
    state = state.copyWith(runTime: time);
  }

  Future<void> changeRunSpeed(RobotArmRunSpeedMode speed) async {
    state = state.copyWith(runSpeed: speed);
  }

  Future<void> changeTurnAngle(int angle) async {
    state = state.copyWith(turnAngle: angle);
  }

  Future<void> changeRobotArmRunningStatus(bool isRunning) async {
    state = state.copyWith(isRobotArmRunning: isRunning);
  }
}
