// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_tools_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsToolsState {

/// For "Last backup: Yesterday, 23:04".
 CalendarDate get today; SettingsTask? get running;/// The system said no when notifications were turned on: the card that
/// leads to the system settings shows.
 bool get notificationsDenied;/// Settings → Developer → Simulate network failure.
 bool get failRequests;/// The plan to show in a sheet; [planSerial] opens it once per request.
 NotificationPlanPreview? get plan; int get planSerial;/// A one-time SnackBar; [messageSerial] makes each one distinct.
 String? get message; int get messageSerial;
/// Create a copy of SettingsToolsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsToolsStateCopyWith<SettingsToolsState> get copyWith => _$SettingsToolsStateCopyWithImpl<SettingsToolsState>(this as SettingsToolsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SettingsToolsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsToolsState&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.running, _this.running) || other.running == _this.running)&&(identical(other.notificationsDenied, _this.notificationsDenied) || other.notificationsDenied == _this.notificationsDenied)&&(identical(other.failRequests, _this.failRequests) || other.failRequests == _this.failRequests)&&(identical(other.plan, _this.plan) || other.plan == _this.plan)&&(identical(other.planSerial, _this.planSerial) || other.planSerial == _this.planSerial)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.messageSerial, _this.messageSerial) || other.messageSerial == _this.messageSerial));
}


@override
int get hashCode {
  final _this = this as SettingsToolsState;
  return Object.hash(runtimeType,_this.today,_this.running,_this.notificationsDenied,_this.failRequests,_this.plan,_this.planSerial,_this.message,_this.messageSerial);
}

@override
String toString() {
  final _this = this as SettingsToolsState;
  return 'SettingsToolsState(today: ${_this.today}, running: ${_this.running}, notificationsDenied: ${_this.notificationsDenied}, failRequests: ${_this.failRequests}, plan: ${_this.plan}, planSerial: ${_this.planSerial}, message: ${_this.message}, messageSerial: ${_this.messageSerial})';
}


}

/// @nodoc
abstract mixin class $SettingsToolsStateCopyWith<$Res>  {
  factory $SettingsToolsStateCopyWith(SettingsToolsState value, $Res Function(SettingsToolsState) _then) = _$SettingsToolsStateCopyWithImpl;
@useResult
$Res call({
 CalendarDate today, SettingsTask? running, bool notificationsDenied, bool failRequests, NotificationPlanPreview? plan, int planSerial, String? message, int messageSerial
});


$NotificationPlanPreviewCopyWith<$Res>? get plan;

}
/// @nodoc
class _$SettingsToolsStateCopyWithImpl<$Res>
    implements $SettingsToolsStateCopyWith<$Res> {
  _$SettingsToolsStateCopyWithImpl(this._self, this._then);

  final SettingsToolsState _self;
  final $Res Function(SettingsToolsState) _then;

/// Create a copy of SettingsToolsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? today = null,Object? running = freezed,Object? notificationsDenied = null,Object? failRequests = null,Object? plan = freezed,Object? planSerial = null,Object? message = freezed,Object? messageSerial = null,}) {
  return _then(SettingsToolsState(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as SettingsTask?,notificationsDenied: null == notificationsDenied ? _self.notificationsDenied : notificationsDenied // ignore: cast_nullable_to_non_nullable
as bool,failRequests: null == failRequests ? _self.failRequests : failRequests // ignore: cast_nullable_to_non_nullable
as bool,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as NotificationPlanPreview?,planSerial: null == planSerial ? _self.planSerial : planSerial // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,messageSerial: null == messageSerial ? _self.messageSerial : messageSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of SettingsToolsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPlanPreviewCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $NotificationPlanPreviewCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsToolsState].
extension SettingsToolsStatePatterns on SettingsToolsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsToolsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsToolsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsToolsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsToolsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsToolsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsToolsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarDate today,  SettingsTask? running,  bool notificationsDenied,  bool failRequests,  NotificationPlanPreview? plan,  int planSerial,  String? message,  int messageSerial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsToolsState() when $default != null:
return $default(_that.today,_that.running,_that.notificationsDenied,_that.failRequests,_that.plan,_that.planSerial,_that.message,_that.messageSerial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarDate today,  SettingsTask? running,  bool notificationsDenied,  bool failRequests,  NotificationPlanPreview? plan,  int planSerial,  String? message,  int messageSerial)  $default,) {final _that = this;
switch (_that) {
case _SettingsToolsState():
return $default(_that.today,_that.running,_that.notificationsDenied,_that.failRequests,_that.plan,_that.planSerial,_that.message,_that.messageSerial);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarDate today,  SettingsTask? running,  bool notificationsDenied,  bool failRequests,  NotificationPlanPreview? plan,  int planSerial,  String? message,  int messageSerial)?  $default,) {final _that = this;
switch (_that) {
case _SettingsToolsState() when $default != null:
return $default(_that.today,_that.running,_that.notificationsDenied,_that.failRequests,_that.plan,_that.planSerial,_that.message,_that.messageSerial);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsToolsState implements SettingsToolsState {
  const _SettingsToolsState({required this.today, this.running, this.notificationsDenied = false, this.failRequests = false, this.plan, this.planSerial = 0, this.message, this.messageSerial = 0});
  

/// For "Last backup: Yesterday, 23:04".
@override final  CalendarDate today;
@override final  SettingsTask? running;
/// The system said no when notifications were turned on: the card that
/// leads to the system settings shows.
@override@JsonKey() final  bool notificationsDenied;
/// Settings → Developer → Simulate network failure.
@override@JsonKey() final  bool failRequests;
/// The plan to show in a sheet; [planSerial] opens it once per request.
@override final  NotificationPlanPreview? plan;
@override@JsonKey() final  int planSerial;
/// A one-time SnackBar; [messageSerial] makes each one distinct.
@override final  String? message;
@override@JsonKey() final  int messageSerial;

/// Create a copy of SettingsToolsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsToolsStateCopyWith<_SettingsToolsState> get copyWith => __$SettingsToolsStateCopyWithImpl<_SettingsToolsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsToolsState&&(identical(other.today, today) || other.today == today)&&(identical(other.running, running) || other.running == running)&&(identical(other.notificationsDenied, notificationsDenied) || other.notificationsDenied == notificationsDenied)&&(identical(other.failRequests, failRequests) || other.failRequests == failRequests)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.planSerial, planSerial) || other.planSerial == planSerial)&&(identical(other.message, message) || other.message == message)&&(identical(other.messageSerial, messageSerial) || other.messageSerial == messageSerial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,today,running,notificationsDenied,failRequests,plan,planSerial,message,messageSerial);
}

@override
String toString() {
    return 'SettingsToolsState(today: $today, running: $running, notificationsDenied: $notificationsDenied, failRequests: $failRequests, plan: $plan, planSerial: $planSerial, message: $message, messageSerial: $messageSerial)';
}


}

/// @nodoc
abstract mixin class _$SettingsToolsStateCopyWith<$Res> implements $SettingsToolsStateCopyWith<$Res> {
  factory _$SettingsToolsStateCopyWith(_SettingsToolsState value, $Res Function(_SettingsToolsState) _then) = __$SettingsToolsStateCopyWithImpl;
@override @useResult
$Res call({
 CalendarDate today, SettingsTask? running, bool notificationsDenied, bool failRequests, NotificationPlanPreview? plan, int planSerial, String? message, int messageSerial
});


@override $NotificationPlanPreviewCopyWith<$Res>? get plan;

}
/// @nodoc
class __$SettingsToolsStateCopyWithImpl<$Res>
    implements _$SettingsToolsStateCopyWith<$Res> {
  __$SettingsToolsStateCopyWithImpl(this._self, this._then);

  final _SettingsToolsState _self;
  final $Res Function(_SettingsToolsState) _then;

/// Create a copy of SettingsToolsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? today = null,Object? running = freezed,Object? notificationsDenied = null,Object? failRequests = null,Object? plan = freezed,Object? planSerial = null,Object? message = freezed,Object? messageSerial = null,}) {
  return _then(_SettingsToolsState(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,running: freezed == running ? _self.running : running // ignore: cast_nullable_to_non_nullable
as SettingsTask?,notificationsDenied: null == notificationsDenied ? _self.notificationsDenied : notificationsDenied // ignore: cast_nullable_to_non_nullable
as bool,failRequests: null == failRequests ? _self.failRequests : failRequests // ignore: cast_nullable_to_non_nullable
as bool,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as NotificationPlanPreview?,planSerial: null == planSerial ? _self.planSerial : planSerial // ignore: cast_nullable_to_non_nullable
as int,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,messageSerial: null == messageSerial ? _self.messageSerial : messageSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of SettingsToolsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NotificationPlanPreviewCopyWith<$Res>? get plan {
    if (_self.plan == null) {
    return null;
  }

  return $NotificationPlanPreviewCopyWith<$Res>(_self.plan!, (value) {
    return _then(_self.copyWith(plan: value));
  });
}
}

// dart format on
