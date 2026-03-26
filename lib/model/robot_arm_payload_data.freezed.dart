// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'robot_arm_payload_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RobotArmPayloadData {

 RobotArmCommandId get commandId; RobotArmRunMode get runMode; int get runSpeed; int get turnAngle;
/// Create a copy of RobotArmPayloadData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RobotArmPayloadDataCopyWith<RobotArmPayloadData> get copyWith => _$RobotArmPayloadDataCopyWithImpl<RobotArmPayloadData>(this as RobotArmPayloadData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RobotArmPayloadData&&(identical(other.commandId, commandId) || other.commandId == commandId)&&(identical(other.runMode, runMode) || other.runMode == runMode)&&(identical(other.runSpeed, runSpeed) || other.runSpeed == runSpeed)&&(identical(other.turnAngle, turnAngle) || other.turnAngle == turnAngle));
}


@override
int get hashCode => Object.hash(runtimeType,commandId,runMode,runSpeed,turnAngle);

@override
String toString() {
  return 'RobotArmPayloadData(commandId: $commandId, runMode: $runMode, runSpeed: $runSpeed, turnAngle: $turnAngle)';
}


}

/// @nodoc
abstract mixin class $RobotArmPayloadDataCopyWith<$Res>  {
  factory $RobotArmPayloadDataCopyWith(RobotArmPayloadData value, $Res Function(RobotArmPayloadData) _then) = _$RobotArmPayloadDataCopyWithImpl;
@useResult
$Res call({
 RobotArmCommandId commandId, RobotArmRunMode runMode, int runSpeed, int turnAngle
});




}
/// @nodoc
class _$RobotArmPayloadDataCopyWithImpl<$Res>
    implements $RobotArmPayloadDataCopyWith<$Res> {
  _$RobotArmPayloadDataCopyWithImpl(this._self, this._then);

  final RobotArmPayloadData _self;
  final $Res Function(RobotArmPayloadData) _then;

/// Create a copy of RobotArmPayloadData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? commandId = null,Object? runMode = null,Object? runSpeed = null,Object? turnAngle = null,}) {
  return _then(_self.copyWith(
commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as RobotArmCommandId,runMode: null == runMode ? _self.runMode : runMode // ignore: cast_nullable_to_non_nullable
as RobotArmRunMode,runSpeed: null == runSpeed ? _self.runSpeed : runSpeed // ignore: cast_nullable_to_non_nullable
as int,turnAngle: null == turnAngle ? _self.turnAngle : turnAngle // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [RobotArmPayloadData].
extension RobotArmPayloadDataPatterns on RobotArmPayloadData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RobotArmPayloadData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RobotArmPayloadData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RobotArmPayloadData value)  $default,){
final _that = this;
switch (_that) {
case _RobotArmPayloadData():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RobotArmPayloadData value)?  $default,){
final _that = this;
switch (_that) {
case _RobotArmPayloadData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RobotArmCommandId commandId,  RobotArmRunMode runMode,  int runSpeed,  int turnAngle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RobotArmPayloadData() when $default != null:
return $default(_that.commandId,_that.runMode,_that.runSpeed,_that.turnAngle);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RobotArmCommandId commandId,  RobotArmRunMode runMode,  int runSpeed,  int turnAngle)  $default,) {final _that = this;
switch (_that) {
case _RobotArmPayloadData():
return $default(_that.commandId,_that.runMode,_that.runSpeed,_that.turnAngle);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RobotArmCommandId commandId,  RobotArmRunMode runMode,  int runSpeed,  int turnAngle)?  $default,) {final _that = this;
switch (_that) {
case _RobotArmPayloadData() when $default != null:
return $default(_that.commandId,_that.runMode,_that.runSpeed,_that.turnAngle);case _:
  return null;

}
}

}

/// @nodoc


class _RobotArmPayloadData extends RobotArmPayloadData {
  const _RobotArmPayloadData({required this.commandId, required this.runMode, required this.runSpeed, required this.turnAngle}): super._();
  

@override final  RobotArmCommandId commandId;
@override final  RobotArmRunMode runMode;
@override final  int runSpeed;
@override final  int turnAngle;

/// Create a copy of RobotArmPayloadData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RobotArmPayloadDataCopyWith<_RobotArmPayloadData> get copyWith => __$RobotArmPayloadDataCopyWithImpl<_RobotArmPayloadData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RobotArmPayloadData&&(identical(other.commandId, commandId) || other.commandId == commandId)&&(identical(other.runMode, runMode) || other.runMode == runMode)&&(identical(other.runSpeed, runSpeed) || other.runSpeed == runSpeed)&&(identical(other.turnAngle, turnAngle) || other.turnAngle == turnAngle));
}


@override
int get hashCode => Object.hash(runtimeType,commandId,runMode,runSpeed,turnAngle);

@override
String toString() {
  return 'RobotArmPayloadData(commandId: $commandId, runMode: $runMode, runSpeed: $runSpeed, turnAngle: $turnAngle)';
}


}

/// @nodoc
abstract mixin class _$RobotArmPayloadDataCopyWith<$Res> implements $RobotArmPayloadDataCopyWith<$Res> {
  factory _$RobotArmPayloadDataCopyWith(_RobotArmPayloadData value, $Res Function(_RobotArmPayloadData) _then) = __$RobotArmPayloadDataCopyWithImpl;
@override @useResult
$Res call({
 RobotArmCommandId commandId, RobotArmRunMode runMode, int runSpeed, int turnAngle
});




}
/// @nodoc
class __$RobotArmPayloadDataCopyWithImpl<$Res>
    implements _$RobotArmPayloadDataCopyWith<$Res> {
  __$RobotArmPayloadDataCopyWithImpl(this._self, this._then);

  final _RobotArmPayloadData _self;
  final $Res Function(_RobotArmPayloadData) _then;

/// Create a copy of RobotArmPayloadData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? commandId = null,Object? runMode = null,Object? runSpeed = null,Object? turnAngle = null,}) {
  return _then(_RobotArmPayloadData(
commandId: null == commandId ? _self.commandId : commandId // ignore: cast_nullable_to_non_nullable
as RobotArmCommandId,runMode: null == runMode ? _self.runMode : runMode // ignore: cast_nullable_to_non_nullable
as RobotArmRunMode,runSpeed: null == runSpeed ? _self.runSpeed : runSpeed // ignore: cast_nullable_to_non_nullable
as int,turnAngle: null == turnAngle ? _self.turnAngle : turnAngle // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
