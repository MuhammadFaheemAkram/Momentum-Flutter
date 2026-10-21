// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'today_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TodayState {

 TodayStatus get status; TodayOverview? get overview;/// The next reminders still to ring today, soonest first.
 List<PlannedNotification> get upcoming;/// A one-time message (a SnackBar); [noticeSerial] makes each one
/// distinct, so the same message twice still shows twice.
 HabitNotice? get notice; int get noticeSerial;
/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayStateCopyWith<TodayState> get copyWith => _$TodayStateCopyWithImpl<TodayState>(this as TodayState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TodayState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.overview, _this.overview) || other.overview == _this.overview)&&const DeepCollectionEquality().equals(other.upcoming, _this.upcoming)&&(identical(other.notice, _this.notice) || other.notice == _this.notice)&&(identical(other.noticeSerial, _this.noticeSerial) || other.noticeSerial == _this.noticeSerial));
}


@override
int get hashCode {
  final _this = this as TodayState;
  return Object.hash(runtimeType,_this.status,_this.overview,const DeepCollectionEquality().hash(_this.upcoming),_this.notice,_this.noticeSerial);
}

@override
String toString() {
  final _this = this as TodayState;
  return 'TodayState(status: ${_this.status}, overview: ${_this.overview}, upcoming: ${_this.upcoming}, notice: ${_this.notice}, noticeSerial: ${_this.noticeSerial})';
}


}

/// @nodoc
abstract mixin class $TodayStateCopyWith<$Res>  {
  factory $TodayStateCopyWith(TodayState value, $Res Function(TodayState) _then) = _$TodayStateCopyWithImpl;
@useResult
$Res call({
 TodayStatus status, TodayOverview? overview, List<PlannedNotification> upcoming, HabitNotice? notice, int noticeSerial
});


$TodayOverviewCopyWith<$Res>? get overview;

}
/// @nodoc
class _$TodayStateCopyWithImpl<$Res>
    implements $TodayStateCopyWith<$Res> {
  _$TodayStateCopyWithImpl(this._self, this._then);

  final TodayState _self;
  final $Res Function(TodayState) _then;

/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? overview = freezed,Object? upcoming = null,Object? notice = freezed,Object? noticeSerial = null,}) {
  return _then(TodayState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayStatus,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TodayOverview?,upcoming: null == upcoming ? _self.upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<PlannedNotification>,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as HabitNotice?,noticeSerial: null == noticeSerial ? _self.noticeSerial : noticeSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayOverviewCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TodayOverviewCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}
}


/// Adds pattern-matching-related methods to [TodayState].
extension TodayStatePatterns on TodayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayState value)  $default,){
final _that = this;
switch (_that) {
case _TodayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayState value)?  $default,){
final _that = this;
switch (_that) {
case _TodayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TodayStatus status,  TodayOverview? overview,  List<PlannedNotification> upcoming,  HabitNotice? notice,  int noticeSerial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayState() when $default != null:
return $default(_that.status,_that.overview,_that.upcoming,_that.notice,_that.noticeSerial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TodayStatus status,  TodayOverview? overview,  List<PlannedNotification> upcoming,  HabitNotice? notice,  int noticeSerial)  $default,) {final _that = this;
switch (_that) {
case _TodayState():
return $default(_that.status,_that.overview,_that.upcoming,_that.notice,_that.noticeSerial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TodayStatus status,  TodayOverview? overview,  List<PlannedNotification> upcoming,  HabitNotice? notice,  int noticeSerial)?  $default,) {final _that = this;
switch (_that) {
case _TodayState() when $default != null:
return $default(_that.status,_that.overview,_that.upcoming,_that.notice,_that.noticeSerial);case _:
  return null;

}
}

}

/// @nodoc


class _TodayState implements TodayState {
  const _TodayState({this.status = TodayStatus.loading, this.overview,  List<PlannedNotification> upcoming = const <PlannedNotification>[], this.notice, this.noticeSerial = 0}): _upcoming = upcoming;
  

@override@JsonKey() final  TodayStatus status;
@override final  TodayOverview? overview;
/// The next reminders still to ring today, soonest first.
 final  List<PlannedNotification> _upcoming;
/// The next reminders still to ring today, soonest first.
@override@JsonKey() List<PlannedNotification> get upcoming {
  if (_upcoming is EqualUnmodifiableListView) return _upcoming;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_upcoming);
}

/// A one-time message (a SnackBar); [noticeSerial] makes each one
/// distinct, so the same message twice still shows twice.
@override final  HabitNotice? notice;
@override@JsonKey() final  int noticeSerial;

/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayStateCopyWith<_TodayState> get copyWith => __$TodayStateCopyWithImpl<_TodayState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayState&&(identical(other.status, status) || other.status == status)&&(identical(other.overview, overview) || other.overview == overview)&&const DeepCollectionEquality().equals(other.upcoming, _upcoming)&&(identical(other.notice, notice) || other.notice == notice)&&(identical(other.noticeSerial, noticeSerial) || other.noticeSerial == noticeSerial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,overview,const DeepCollectionEquality().hash(_upcoming),notice,noticeSerial);
}

@override
String toString() {
    return 'TodayState(status: $status, overview: $overview, upcoming: $upcoming, notice: $notice, noticeSerial: $noticeSerial)';
}


}

/// @nodoc
abstract mixin class _$TodayStateCopyWith<$Res> implements $TodayStateCopyWith<$Res> {
  factory _$TodayStateCopyWith(_TodayState value, $Res Function(_TodayState) _then) = __$TodayStateCopyWithImpl;
@override @useResult
$Res call({
 TodayStatus status, TodayOverview? overview, List<PlannedNotification> upcoming, HabitNotice? notice, int noticeSerial
});


@override $TodayOverviewCopyWith<$Res>? get overview;

}
/// @nodoc
class __$TodayStateCopyWithImpl<$Res>
    implements _$TodayStateCopyWith<$Res> {
  __$TodayStateCopyWithImpl(this._self, this._then);

  final _TodayState _self;
  final $Res Function(_TodayState) _then;

/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? overview = freezed,Object? upcoming = null,Object? notice = freezed,Object? noticeSerial = null,}) {
  return _then(_TodayState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as TodayStatus,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as TodayOverview?,upcoming: null == upcoming ? _self._upcoming : upcoming // ignore: cast_nullable_to_non_nullable
as List<PlannedNotification>,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as HabitNotice?,noticeSerial: null == noticeSerial ? _self.noticeSerial : noticeSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of TodayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodayOverviewCopyWith<$Res>? get overview {
    if (_self.overview == null) {
    return null;
  }

  return $TodayOverviewCopyWith<$Res>(_self.overview!, (value) {
    return _then(_self.copyWith(overview: value));
  });
}
}

// dart format on
