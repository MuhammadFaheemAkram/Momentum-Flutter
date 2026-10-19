// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_draft.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitDraft {

 String get title; String get description; HabitCategory get category; HabitColor get color; HabitIcon get icon; HabitSchedule get schedule; int get dailyTarget; CalendarDate get startDate; TimeOfDayValue? get reminder;
/// Create a copy of HabitDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitDraftCopyWith<HabitDraft> get copyWith => _$HabitDraftCopyWithImpl<HabitDraft>(this as HabitDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitDraft&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.schedule, _this.schedule) || other.schedule == _this.schedule)&&(identical(other.dailyTarget, _this.dailyTarget) || other.dailyTarget == _this.dailyTarget)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.reminder, _this.reminder) || other.reminder == _this.reminder));
}


@override
int get hashCode {
  final _this = this as HabitDraft;
  return Object.hash(runtimeType,_this.title,_this.description,_this.category,_this.color,_this.icon,_this.schedule,_this.dailyTarget,_this.startDate,_this.reminder);
}

@override
String toString() {
  final _this = this as HabitDraft;
  return 'HabitDraft(title: ${_this.title}, description: ${_this.description}, category: ${_this.category}, color: ${_this.color}, icon: ${_this.icon}, schedule: ${_this.schedule}, dailyTarget: ${_this.dailyTarget}, startDate: ${_this.startDate}, reminder: ${_this.reminder})';
}


}

/// @nodoc
abstract mixin class $HabitDraftCopyWith<$Res>  {
  factory $HabitDraftCopyWith(HabitDraft value, $Res Function(HabitDraft) _then) = _$HabitDraftCopyWithImpl;
@useResult
$Res call({
 String title, String description, HabitCategory category, HabitColor color, HabitIcon icon, HabitSchedule schedule, int dailyTarget, CalendarDate startDate, TimeOfDayValue? reminder
});


$HabitScheduleCopyWith<$Res> get schedule;

}
/// @nodoc
class _$HabitDraftCopyWithImpl<$Res>
    implements $HabitDraftCopyWith<$Res> {
  _$HabitDraftCopyWithImpl(this._self, this._then);

  final HabitDraft _self;
  final $Res Function(HabitDraft) _then;

/// Create a copy of HabitDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? category = null,Object? color = null,Object? icon = null,Object? schedule = null,Object? dailyTarget = null,Object? startDate = null,Object? reminder = freezed,}) {
  return _then(HabitDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as HabitColor,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as HabitIcon,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as HabitSchedule,dailyTarget: null == dailyTarget ? _self.dailyTarget : dailyTarget // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as CalendarDate,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue?,
  ));
}
/// Create a copy of HabitDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitScheduleCopyWith<$Res> get schedule {
  
  return $HabitScheduleCopyWith<$Res>(_self.schedule, (value) {
    return _then(_self.copyWith(schedule: value));
  });
}
}


/// Adds pattern-matching-related methods to [HabitDraft].
extension HabitDraftPatterns on HabitDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitDraft value)  $default,){
final _that = this;
switch (_that) {
case _HabitDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitDraft value)?  $default,){
final _that = this;
switch (_that) {
case _HabitDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  HabitSchedule schedule,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitDraft() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.color,_that.icon,_that.schedule,_that.dailyTarget,_that.startDate,_that.reminder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  HabitSchedule schedule,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder)  $default,) {final _that = this;
switch (_that) {
case _HabitDraft():
return $default(_that.title,_that.description,_that.category,_that.color,_that.icon,_that.schedule,_that.dailyTarget,_that.startDate,_that.reminder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  HabitSchedule schedule,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder)?  $default,) {final _that = this;
switch (_that) {
case _HabitDraft() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.color,_that.icon,_that.schedule,_that.dailyTarget,_that.startDate,_that.reminder);case _:
  return null;

}
}

}

/// @nodoc


class _HabitDraft implements HabitDraft {
  const _HabitDraft({required this.title, this.description = '', required this.category, required this.color, required this.icon, required this.schedule, this.dailyTarget = 1, required this.startDate, this.reminder});
  

@override final  String title;
@override@JsonKey() final  String description;
@override final  HabitCategory category;
@override final  HabitColor color;
@override final  HabitIcon icon;
@override final  HabitSchedule schedule;
@override@JsonKey() final  int dailyTarget;
@override final  CalendarDate startDate;
@override final  TimeOfDayValue? reminder;

/// Create a copy of HabitDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitDraftCopyWith<_HabitDraft> get copyWith => __$HabitDraftCopyWithImpl<_HabitDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.dailyTarget, dailyTarget) || other.dailyTarget == dailyTarget)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.reminder, reminder) || other.reminder == reminder));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,category,color,icon,schedule,dailyTarget,startDate,reminder);
}

@override
String toString() {
    return 'HabitDraft(title: $title, description: $description, category: $category, color: $color, icon: $icon, schedule: $schedule, dailyTarget: $dailyTarget, startDate: $startDate, reminder: $reminder)';
}


}

/// @nodoc
abstract mixin class _$HabitDraftCopyWith<$Res> implements $HabitDraftCopyWith<$Res> {
  factory _$HabitDraftCopyWith(_HabitDraft value, $Res Function(_HabitDraft) _then) = __$HabitDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, HabitCategory category, HabitColor color, HabitIcon icon, HabitSchedule schedule, int dailyTarget, CalendarDate startDate, TimeOfDayValue? reminder
});


@override $HabitScheduleCopyWith<$Res> get schedule;

}
/// @nodoc
class __$HabitDraftCopyWithImpl<$Res>
    implements _$HabitDraftCopyWith<$Res> {
  __$HabitDraftCopyWithImpl(this._self, this._then);

  final _HabitDraft _self;
  final $Res Function(_HabitDraft) _then;

/// Create a copy of HabitDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? category = null,Object? color = null,Object? icon = null,Object? schedule = null,Object? dailyTarget = null,Object? startDate = null,Object? reminder = freezed,}) {
  return _then(_HabitDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as HabitColor,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as HabitIcon,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as HabitSchedule,dailyTarget: null == dailyTarget ? _self.dailyTarget : dailyTarget // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as CalendarDate,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue?,
  ));
}

/// Create a copy of HabitDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitScheduleCopyWith<$Res> get schedule {
  
  return $HabitScheduleCopyWith<$Res>(_self.schedule, (value) {
    return _then(_self.copyWith(schedule: value));
  });
}
}

// dart format on
