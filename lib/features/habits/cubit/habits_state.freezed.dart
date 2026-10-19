// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habits_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitsState {

 HabitsStatus get status; CalendarDate? get today;/// Every habit, archived ones too.
 List<HabitToday> get habits; String get query; HabitCategory? get category; bool get showArchived; HabitNotice? get notice; int get noticeSerial;
/// Create a copy of HabitsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitsStateCopyWith<HabitsState> get copyWith => _$HabitsStateCopyWithImpl<HabitsState>(this as HabitsState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitsState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitsState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.today, _this.today) || other.today == _this.today)&&const DeepCollectionEquality().equals(other.habits, _this.habits)&&(identical(other.query, _this.query) || other.query == _this.query)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.showArchived, _this.showArchived) || other.showArchived == _this.showArchived)&&(identical(other.notice, _this.notice) || other.notice == _this.notice)&&(identical(other.noticeSerial, _this.noticeSerial) || other.noticeSerial == _this.noticeSerial));
}


@override
int get hashCode {
  final _this = this as HabitsState;
  return Object.hash(runtimeType,_this.status,_this.today,const DeepCollectionEquality().hash(_this.habits),_this.query,_this.category,_this.showArchived,_this.notice,_this.noticeSerial);
}

@override
String toString() {
  final _this = this as HabitsState;
  return 'HabitsState(status: ${_this.status}, today: ${_this.today}, habits: ${_this.habits}, query: ${_this.query}, category: ${_this.category}, showArchived: ${_this.showArchived}, notice: ${_this.notice}, noticeSerial: ${_this.noticeSerial})';
}


}

/// @nodoc
abstract mixin class $HabitsStateCopyWith<$Res>  {
  factory $HabitsStateCopyWith(HabitsState value, $Res Function(HabitsState) _then) = _$HabitsStateCopyWithImpl;
@useResult
$Res call({
 HabitsStatus status, CalendarDate? today, List<HabitToday> habits, String query, HabitCategory? category, bool showArchived, HabitNotice? notice, int noticeSerial
});




}
/// @nodoc
class _$HabitsStateCopyWithImpl<$Res>
    implements $HabitsStateCopyWith<$Res> {
  _$HabitsStateCopyWithImpl(this._self, this._then);

  final HabitsState _self;
  final $Res Function(HabitsState) _then;

/// Create a copy of HabitsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? today = freezed,Object? habits = null,Object? query = null,Object? category = freezed,Object? showArchived = null,Object? notice = freezed,Object? noticeSerial = null,}) {
  return _then(HabitsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HabitsStatus,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate?,habits: null == habits ? _self.habits : habits // ignore: cast_nullable_to_non_nullable
as List<HabitToday>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory?,showArchived: null == showArchived ? _self.showArchived : showArchived // ignore: cast_nullable_to_non_nullable
as bool,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as HabitNotice?,noticeSerial: null == noticeSerial ? _self.noticeSerial : noticeSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [HabitsState].
extension HabitsStatePatterns on HabitsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitsState value)  $default,){
final _that = this;
switch (_that) {
case _HabitsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitsState value)?  $default,){
final _that = this;
switch (_that) {
case _HabitsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HabitsStatus status,  CalendarDate? today,  List<HabitToday> habits,  String query,  HabitCategory? category,  bool showArchived,  HabitNotice? notice,  int noticeSerial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitsState() when $default != null:
return $default(_that.status,_that.today,_that.habits,_that.query,_that.category,_that.showArchived,_that.notice,_that.noticeSerial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HabitsStatus status,  CalendarDate? today,  List<HabitToday> habits,  String query,  HabitCategory? category,  bool showArchived,  HabitNotice? notice,  int noticeSerial)  $default,) {final _that = this;
switch (_that) {
case _HabitsState():
return $default(_that.status,_that.today,_that.habits,_that.query,_that.category,_that.showArchived,_that.notice,_that.noticeSerial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HabitsStatus status,  CalendarDate? today,  List<HabitToday> habits,  String query,  HabitCategory? category,  bool showArchived,  HabitNotice? notice,  int noticeSerial)?  $default,) {final _that = this;
switch (_that) {
case _HabitsState() when $default != null:
return $default(_that.status,_that.today,_that.habits,_that.query,_that.category,_that.showArchived,_that.notice,_that.noticeSerial);case _:
  return null;

}
}

}

/// @nodoc


class _HabitsState extends HabitsState {
  const _HabitsState({this.status = HabitsStatus.loading, this.today,  List<HabitToday> habits = const <HabitToday>[], this.query = '', this.category, this.showArchived = false, this.notice, this.noticeSerial = 0}): _habits = habits,super._();
  

@override@JsonKey() final  HabitsStatus status;
@override final  CalendarDate? today;
/// Every habit, archived ones too.
 final  List<HabitToday> _habits;
/// Every habit, archived ones too.
@override@JsonKey() List<HabitToday> get habits {
  if (_habits is EqualUnmodifiableListView) return _habits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_habits);
}

@override@JsonKey() final  String query;
@override final  HabitCategory? category;
@override@JsonKey() final  bool showArchived;
@override final  HabitNotice? notice;
@override@JsonKey() final  int noticeSerial;

/// Create a copy of HabitsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitsStateCopyWith<_HabitsState> get copyWith => __$HabitsStateCopyWithImpl<_HabitsState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitsState&&(identical(other.status, status) || other.status == status)&&(identical(other.today, today) || other.today == today)&&const DeepCollectionEquality().equals(other.habits, _habits)&&(identical(other.query, query) || other.query == query)&&(identical(other.category, category) || other.category == category)&&(identical(other.showArchived, showArchived) || other.showArchived == showArchived)&&(identical(other.notice, notice) || other.notice == notice)&&(identical(other.noticeSerial, noticeSerial) || other.noticeSerial == noticeSerial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,today,const DeepCollectionEquality().hash(_habits),query,category,showArchived,notice,noticeSerial);
}

@override
String toString() {
    return 'HabitsState(status: $status, today: $today, habits: $habits, query: $query, category: $category, showArchived: $showArchived, notice: $notice, noticeSerial: $noticeSerial)';
}


}

/// @nodoc
abstract mixin class _$HabitsStateCopyWith<$Res> implements $HabitsStateCopyWith<$Res> {
  factory _$HabitsStateCopyWith(_HabitsState value, $Res Function(_HabitsState) _then) = __$HabitsStateCopyWithImpl;
@override @useResult
$Res call({
 HabitsStatus status, CalendarDate? today, List<HabitToday> habits, String query, HabitCategory? category, bool showArchived, HabitNotice? notice, int noticeSerial
});




}
/// @nodoc
class __$HabitsStateCopyWithImpl<$Res>
    implements _$HabitsStateCopyWith<$Res> {
  __$HabitsStateCopyWithImpl(this._self, this._then);

  final _HabitsState _self;
  final $Res Function(_HabitsState) _then;

/// Create a copy of HabitsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? today = freezed,Object? habits = null,Object? query = null,Object? category = freezed,Object? showArchived = null,Object? notice = freezed,Object? noticeSerial = null,}) {
  return _then(_HabitsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HabitsStatus,today: freezed == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate?,habits: null == habits ? _self._habits : habits // ignore: cast_nullable_to_non_nullable
as List<HabitToday>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory?,showArchived: null == showArchived ? _self.showArchived : showArchived // ignore: cast_nullable_to_non_nullable
as bool,notice: freezed == notice ? _self.notice : notice // ignore: cast_nullable_to_non_nullable
as HabitNotice?,noticeSerial: null == noticeSerial ? _self.noticeSerial : noticeSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
