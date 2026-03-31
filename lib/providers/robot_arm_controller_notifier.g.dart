// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'robot_arm_controller_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(RobotArmControllerNotifier)
final robotArmControllerProvider = RobotArmControllerNotifierProvider._();

final class RobotArmControllerNotifierProvider
    extends
        $NotifierProvider<RobotArmControllerNotifier, RobotArmControllerState> {
  RobotArmControllerNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'robotArmControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$robotArmControllerNotifierHash();

  @$internal
  @override
  RobotArmControllerNotifier create() => RobotArmControllerNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RobotArmControllerState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RobotArmControllerState>(value),
    );
  }
}

String _$robotArmControllerNotifierHash() =>
    r'a3b44f081183b97a127b62968b2ddfda79804d26';

abstract class _$RobotArmControllerNotifier
    extends $Notifier<RobotArmControllerState> {
  RobotArmControllerState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<RobotArmControllerState, RobotArmControllerState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<RobotArmControllerState, RobotArmControllerState>,
              RobotArmControllerState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
