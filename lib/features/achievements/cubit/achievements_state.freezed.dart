// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievements_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AchievementsState {

 AchievementsStatus get status; CalendarDate? get today; List<AchievementStatus> get statuses;
/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementsStateCopyWith<AchievementsState> get copyWith => _$AchievementsStateCopyWithImpl<AchievementsState>(this as AchievementsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AchievementsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.today, _this.today) || other.today == _this.today)&&const DeepCollectionEquality().equals(other.statuses, _this.statuses));
}


@override
int get hashCode {
  final _this = this as AchievementsState;
  return Object.hash(runtimeType,_this.status,_this.today,const DeepCollectionEquality().hash(_this.statuses));
}

@override
String toString() {
  final _this = this as AchievementsState;
  return 'AchievementsState(status: ${_this.status}, today: ${_this.today}, statuses: ${_this.statuses})';
}


}

/// @nodoc
abstract mixin class $AchievementsStateCopyWith<$Res>  {
  factory $AchievementsStateCopyWith(AchievementsState value, $Res Function(AchievementsState) _then) = _$AchievementsStateCopyWithImpl;
@useResult
$Res call({
 AchievementsStatus status, CalendarDate? today, List<AchievementStatus> statuses
});




}
/// @nodoc
class _$AchievementsStateCopyWithImpl<$Res>
    implements $AchievementsStateCopyWith<$Res> {
  _$AchievementsStateCopyWithImpl(this._self, this._then);

  final AchievementsState _self;
  final $Res Function(AchievementsState) _then;

/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? today = freezed,Object? statuses = null,}) {
  return _then(AchievementsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AchievementsStatus,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate?,statuses: null == statuses ? _self.statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<AchievementStatus>,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementsState].
extension AchievementsStatePatterns on AchievementsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementsState value)  $default,){
final _that = this;
switch (_that) {
case _AchievementsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementsState value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AchievementsStatus status,  CalendarDate? today,  List<AchievementStatus> statuses)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
return $default(_that.status,_that.today,_that.statuses);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AchievementsStatus status,  CalendarDate? today,  List<AchievementStatus> statuses)  $default,) {final _that = this;
switch (_that) {
case _AchievementsState():
return $default(_that.status,_that.today,_that.statuses);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AchievementsStatus status,  CalendarDate? today,  List<AchievementStatus> statuses)?  $default,) {final _that = this;
switch (_that) {
case _AchievementsState() when $default != null:
return $default(_that.status,_that.today,_that.statuses);case _:
  return null;

}
}

}

/// @nodoc


class _AchievementsState extends AchievementsState {
  const _AchievementsState({this.status = AchievementsStatus.loading, this.today,  List<AchievementStatus> statuses = const <AchievementStatus>[]}): _statuses = statuses,super._();
  

@override@JsonKey() final  AchievementsStatus status;
@override final  CalendarDate? today;
 final  List<AchievementStatus> _statuses;
@override@JsonKey() List<AchievementStatus> get statuses {
  if (_statuses is EqualUnmodifiableListView) return _statuses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_statuses);
}


/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementsStateCopyWith<_AchievementsState> get copyWith => __$AchievementsStateCopyWithImpl<_AchievementsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementsState&&(identical(other.status, status) || other.status == status)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other.statuses, _statuses));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,today,const DeepCollectionEquality().hash(_statuses));
}

@override
String toString() {
    return 'AchievementsState(status: $status, today: $today, statuses: $statuses)';
}


}

/// @nodoc
abstract mixin class _$AchievementsStateCopyWith<$Res> implements $AchievementsStateCopyWith<$Res> {
  factory _$AchievementsStateCopyWith(_AchievementsState value, $Res Function(_AchievementsState) _then) = __$AchievementsStateCopyWithImpl;
@override @useResult
$Res call({
 AchievementsStatus status, CalendarDate? today, List<AchievementStatus> statuses
});




}
/// @nodoc
class __$AchievementsStateCopyWithImpl<$Res>
    implements _$AchievementsStateCopyWith<$Res> {
  __$AchievementsStateCopyWithImpl(this._self, this._then);

  final _AchievementsState _self;
  final $Res Function(_AchievementsState) _then;

/// Create a copy of AchievementsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? today = freezed,Object? statuses = null,}) {
  return _then(_AchievementsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as AchievementsStatus,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate?,statuses: null == statuses ? _self._statuses : statuses // ignore: cast_nullable_to_non_nullable
as List<AchievementStatus>,
  ));
}


}

// dart format on
