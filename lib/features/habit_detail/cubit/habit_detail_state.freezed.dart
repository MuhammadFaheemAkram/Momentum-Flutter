// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitDetailState {

 HabitDetailStatus get status; HabitDetail? get detail;/// Deleted from here: the page leaves.
 bool get deleted; String? get message; int get messageSerial;
/// Create a copy of HabitDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitDetailStateCopyWith<HabitDetailState> get copyWith => _$HabitDetailStateCopyWithImpl<HabitDetailState>(this as HabitDetailState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitDetailState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitDetailState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.detail, _this.detail) || other.detail == _this.detail)&&(identical(other.deleted, _this.deleted) || other.deleted == _this.deleted)&&(identical(other.message, _this.message) || other.message == _this.message)&&(identical(other.messageSerial, _this.messageSerial) || other.messageSerial == _this.messageSerial));
}


@override
int get hashCode {
  final _this = this as HabitDetailState;
  return Object.hash(runtimeType,_this.status,_this.detail,_this.deleted,_this.message,_this.messageSerial);
}

@override
String toString() {
  final _this = this as HabitDetailState;
  return 'HabitDetailState(status: ${_this.status}, detail: ${_this.detail}, deleted: ${_this.deleted}, message: ${_this.message}, messageSerial: ${_this.messageSerial})';
}


}

/// @nodoc
abstract mixin class $HabitDetailStateCopyWith<$Res>  {
  factory $HabitDetailStateCopyWith(HabitDetailState value, $Res Function(HabitDetailState) _then) = _$HabitDetailStateCopyWithImpl;
@useResult
$Res call({
 HabitDetailStatus status, HabitDetail? detail, bool deleted, String? message, int messageSerial
});


$HabitDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class _$HabitDetailStateCopyWithImpl<$Res>
    implements $HabitDetailStateCopyWith<$Res> {
  _$HabitDetailStateCopyWithImpl(this._self, this._then);

  final HabitDetailState _self;
  final $Res Function(HabitDetailState) _then;

/// Create a copy of HabitDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? detail = freezed,Object? deleted = null,Object? message = freezed,Object? messageSerial = null,}) {
  return _then(HabitDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HabitDetailStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as HabitDetail?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,messageSerial: null == messageSerial ? _self.messageSerial : messageSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HabitDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $HabitDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}


/// Adds pattern-matching-related methods to [HabitDetailState].
extension HabitDetailStatePatterns on HabitDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitDetailState value)  $default,){
final _that = this;
switch (_that) {
case _HabitDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _HabitDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HabitDetailStatus status,  HabitDetail? detail,  bool deleted,  String? message,  int messageSerial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitDetailState() when $default != null:
return $default(_that.status,_that.detail,_that.deleted,_that.message,_that.messageSerial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HabitDetailStatus status,  HabitDetail? detail,  bool deleted,  String? message,  int messageSerial)  $default,) {final _that = this;
switch (_that) {
case _HabitDetailState():
return $default(_that.status,_that.detail,_that.deleted,_that.message,_that.messageSerial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HabitDetailStatus status,  HabitDetail? detail,  bool deleted,  String? message,  int messageSerial)?  $default,) {final _that = this;
switch (_that) {
case _HabitDetailState() when $default != null:
return $default(_that.status,_that.detail,_that.deleted,_that.message,_that.messageSerial);case _:
  return null;

}
}

}

/// @nodoc


class _HabitDetailState implements HabitDetailState {
  const _HabitDetailState({this.status = HabitDetailStatus.loading, this.detail, this.deleted = false, this.message, this.messageSerial = 0});
  

@override@JsonKey() final  HabitDetailStatus status;
@override final  HabitDetail? detail;
/// Deleted from here: the page leaves.
@override@JsonKey() final  bool deleted;
@override final  String? message;
@override@JsonKey() final  int messageSerial;

/// Create a copy of HabitDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitDetailStateCopyWith<_HabitDetailState> get copyWith => __$HabitDetailStateCopyWithImpl<_HabitDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitDetailState&&(identical(other.status, status) || other.status == status)&&(identical(other.detail, detail) || other.detail == detail)&&(identical(other.deleted, deleted) || other.deleted == deleted)&&(identical(other.message, message) || other.message == message)&&(identical(other.messageSerial, messageSerial) || other.messageSerial == messageSerial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,detail,deleted,message,messageSerial);
}

@override
String toString() {
    return 'HabitDetailState(status: $status, detail: $detail, deleted: $deleted, message: $message, messageSerial: $messageSerial)';
}


}

/// @nodoc
abstract mixin class _$HabitDetailStateCopyWith<$Res> implements $HabitDetailStateCopyWith<$Res> {
  factory _$HabitDetailStateCopyWith(_HabitDetailState value, $Res Function(_HabitDetailState) _then) = __$HabitDetailStateCopyWithImpl;
@override @useResult
$Res call({
 HabitDetailStatus status, HabitDetail? detail, bool deleted, String? message, int messageSerial
});


@override $HabitDetailCopyWith<$Res>? get detail;

}
/// @nodoc
class __$HabitDetailStateCopyWithImpl<$Res>
    implements _$HabitDetailStateCopyWith<$Res> {
  __$HabitDetailStateCopyWithImpl(this._self, this._then);

  final _HabitDetailState _self;
  final $Res Function(_HabitDetailState) _then;

/// Create a copy of HabitDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? detail = freezed,Object? deleted = null,Object? message = freezed,Object? messageSerial = null,}) {
  return _then(_HabitDetailState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HabitDetailStatus,detail: freezed == detail ? _self.detail : detail // ignore: cast_nullable_to_non_nullable
as HabitDetail?,deleted: null == deleted ? _self.deleted : deleted // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,messageSerial: null == messageSerial ? _self.messageSerial : messageSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HabitDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitDetailCopyWith<$Res>? get detail {
    if (_self.detail == null) {
    return null;
  }

  return $HabitDetailCopyWith<$Res>(_self.detail!, (value) {
    return _then(_self.copyWith(detail: value));
  });
}
}

// dart format on
