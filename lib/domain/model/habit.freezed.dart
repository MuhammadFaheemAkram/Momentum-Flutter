// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitSchedule {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitSchedule);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HabitSchedule()';
}


}

/// @nodoc
class $HabitScheduleCopyWith<$Res>  {
$HabitScheduleCopyWith(HabitSchedule _, $Res Function(HabitSchedule) __);
}


/// Adds pattern-matching-related methods to [HabitSchedule].
extension HabitSchedulePatterns on HabitSchedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( Daily value)?  daily,TResult Function( OnWeekdays value)?  onWeekdays,TResult Function( TimesPerWeek value)?  timesPerWeek,required TResult orElse(),}){
final _that = this;
switch (_that) {
case Daily() when daily != null:
return daily(_that);case OnWeekdays() when onWeekdays != null:
return onWeekdays(_that);case TimesPerWeek() when timesPerWeek != null:
return timesPerWeek(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( Daily value)  daily,required TResult Function( OnWeekdays value)  onWeekdays,required TResult Function( TimesPerWeek value)  timesPerWeek,}){
final _that = this;
switch (_that) {
case Daily():
return daily(_that);case OnWeekdays():
return onWeekdays(_that);case TimesPerWeek():
return timesPerWeek(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( Daily value)?  daily,TResult? Function( OnWeekdays value)?  onWeekdays,TResult? Function( TimesPerWeek value)?  timesPerWeek,}){
final _that = this;
switch (_that) {
case Daily() when daily != null:
return daily(_that);case OnWeekdays() when onWeekdays != null:
return onWeekdays(_that);case TimesPerWeek() when timesPerWeek != null:
return timesPerWeek(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  daily,TResult Function( Set<int> weekdays)?  onWeekdays,TResult Function( int times)?  timesPerWeek,required TResult orElse(),}) {final _that = this;
switch (_that) {
case Daily() when daily != null:
return daily();case OnWeekdays() when onWeekdays != null:
return onWeekdays(_that.weekdays);case TimesPerWeek() when timesPerWeek != null:
return timesPerWeek(_that.times);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  daily,required TResult Function( Set<int> weekdays)  onWeekdays,required TResult Function( int times)  timesPerWeek,}) {final _that = this;
switch (_that) {
case Daily():
return daily();case OnWeekdays():
return onWeekdays(_that.weekdays);case TimesPerWeek():
return timesPerWeek(_that.times);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  daily,TResult? Function( Set<int> weekdays)?  onWeekdays,TResult? Function( int times)?  timesPerWeek,}) {final _that = this;
switch (_that) {
case Daily() when daily != null:
return daily();case OnWeekdays() when onWeekdays != null:
return onWeekdays(_that.weekdays);case TimesPerWeek() when timesPerWeek != null:
return timesPerWeek(_that.times);case _:
  return null;

}
}

}

/// @nodoc


class Daily implements HabitSchedule {
  const Daily();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is Daily);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'HabitSchedule.daily()';
}


}




/// @nodoc


class OnWeekdays implements HabitSchedule {
  const OnWeekdays( Set<int> weekdays): _weekdays = weekdays;
  

 final  Set<int> _weekdays;
 Set<int> get weekdays {
  if (_weekdays is EqualUnmodifiableSetView) return _weekdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_weekdays);
}


/// Create a copy of HabitSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnWeekdaysCopyWith<OnWeekdays> get copyWith => _$OnWeekdaysCopyWithImpl<OnWeekdays>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OnWeekdays&&const DeepCollectionEquality().equals(other.weekdays, _weekdays));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_weekdays));
}

@override
String toString() {
    return 'HabitSchedule.onWeekdays(weekdays: $weekdays)';
}


}

/// @nodoc
abstract mixin class $OnWeekdaysCopyWith<$Res> implements $HabitScheduleCopyWith<$Res> {
  factory $OnWeekdaysCopyWith(OnWeekdays value, $Res Function(OnWeekdays) _then) = _$OnWeekdaysCopyWithImpl;
@useResult
$Res call({
 Set<int> weekdays
});




}
/// @nodoc
class _$OnWeekdaysCopyWithImpl<$Res>
    implements $OnWeekdaysCopyWith<$Res> {
  _$OnWeekdaysCopyWithImpl(this._self, this._then);

  final OnWeekdays _self;
  final $Res Function(OnWeekdays) _then;

/// Create a copy of HabitSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? weekdays = null,}) {
  return _then(OnWeekdays(
null == weekdays ? _self._weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as Set<int>,
  ));
}


}

/// @nodoc


class TimesPerWeek implements HabitSchedule {
  const TimesPerWeek(this.times): assert(times >= 1 && times <= 6, 'one to six times a week');
  

 final  int times;

/// Create a copy of HabitSchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimesPerWeekCopyWith<TimesPerWeek> get copyWith => _$TimesPerWeekCopyWithImpl<TimesPerWeek>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is TimesPerWeek&&(identical(other.times, times) || other.times == times));
}


@override
int get hashCode {
    return Object.hash(runtimeType,times);
}

@override
String toString() {
    return 'HabitSchedule.timesPerWeek(times: $times)';
}


}

/// @nodoc
abstract mixin class $TimesPerWeekCopyWith<$Res> implements $HabitScheduleCopyWith<$Res> {
  factory $TimesPerWeekCopyWith(TimesPerWeek value, $Res Function(TimesPerWeek) _then) = _$TimesPerWeekCopyWithImpl;
@useResult
$Res call({
 int times
});




}
/// @nodoc
class _$TimesPerWeekCopyWithImpl<$Res>
    implements $TimesPerWeekCopyWith<$Res> {
  _$TimesPerWeekCopyWithImpl(this._self, this._then);

  final TimesPerWeek _self;
  final $Res Function(TimesPerWeek) _then;

/// Create a copy of HabitSchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? times = null,}) {
  return _then(TimesPerWeek(
null == times ? _self.times : times // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$Habit {

 String get id; String get title; String get description; HabitCategory get category; HabitColor get color; HabitIcon get icon; HabitSchedule get schedule;/// Check-ins a day for the day to count as done ("8 glasses"): 1–20.
 int get dailyTarget;/// The first day the habit can be due.
 CalendarDate get startDate;/// When to remind the user on a due day, if at all.
 TimeOfDayValue? get reminder;/// When it was archived: an archived habit keeps its history and is
/// never due.
 DateTime? get archivedAt; DateTime get createdAt;/// The position in the user's list.
 int get sortOrder;
/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitCopyWith<Habit> get copyWith => _$HabitCopyWithImpl<Habit>(this as Habit, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Habit;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Habit&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.schedule, _this.schedule) || other.schedule == _this.schedule)&&(identical(other.dailyTarget, _this.dailyTarget) || other.dailyTarget == _this.dailyTarget)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.reminder, _this.reminder) || other.reminder == _this.reminder)&&(identical(other.archivedAt, _this.archivedAt) || other.archivedAt == _this.archivedAt)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}


@override
int get hashCode {
  final _this = this as Habit;
  return Object.hash(runtimeType,_this.id,_this.title,_this.description,_this.category,_this.color,_this.icon,_this.schedule,_this.dailyTarget,_this.startDate,_this.reminder,_this.archivedAt,_this.createdAt,_this.sortOrder);
}

@override
String toString() {
  final _this = this as Habit;
  return 'Habit(id: ${_this.id}, title: ${_this.title}, description: ${_this.description}, category: ${_this.category}, color: ${_this.color}, icon: ${_this.icon}, schedule: ${_this.schedule}, dailyTarget: ${_this.dailyTarget}, startDate: ${_this.startDate}, reminder: ${_this.reminder}, archivedAt: ${_this.archivedAt}, createdAt: ${_this.createdAt}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $HabitCopyWith<$Res>  {
  factory $HabitCopyWith(Habit value, $Res Function(Habit) _then) = _$HabitCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, HabitCategory category, HabitColor color, HabitIcon icon, HabitSchedule schedule, int dailyTarget, CalendarDate startDate, TimeOfDayValue? reminder, DateTime? archivedAt, DateTime createdAt, int sortOrder
});


$HabitScheduleCopyWith<$Res> get schedule;

}
/// @nodoc
class _$HabitCopyWithImpl<$Res>
    implements $HabitCopyWith<$Res> {
  _$HabitCopyWithImpl(this._self, this._then);

  final Habit _self;
  final $Res Function(Habit) _then;

/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? color = null,Object? icon = null,Object? schedule = null,Object? dailyTarget = null,Object? startDate = null,Object? reminder = freezed,Object? archivedAt = freezed,Object? createdAt = null,Object? sortOrder = null,}) {
  return _then(Habit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as HabitColor,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as HabitIcon,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as HabitSchedule,dailyTarget: null == dailyTarget ? _self.dailyTarget : dailyTarget // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as CalendarDate,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitScheduleCopyWith<$Res> get schedule {
  
  return $HabitScheduleCopyWith<$Res>(_self.schedule, (value) {
    return _then(_self.copyWith(schedule: value));
  });
}
}


/// Adds pattern-matching-related methods to [Habit].
extension HabitPatterns on Habit {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Habit value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Habit() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Habit value)  $default,){
final _that = this;
switch (_that) {
case _Habit():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Habit value)?  $default,){
final _that = this;
switch (_that) {
case _Habit() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  HabitSchedule schedule,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder,  DateTime? archivedAt,  DateTime createdAt,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Habit() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.color,_that.icon,_that.schedule,_that.dailyTarget,_that.startDate,_that.reminder,_that.archivedAt,_that.createdAt,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  HabitSchedule schedule,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder,  DateTime? archivedAt,  DateTime createdAt,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _Habit():
return $default(_that.id,_that.title,_that.description,_that.category,_that.color,_that.icon,_that.schedule,_that.dailyTarget,_that.startDate,_that.reminder,_that.archivedAt,_that.createdAt,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  HabitSchedule schedule,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder,  DateTime? archivedAt,  DateTime createdAt,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _Habit() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.category,_that.color,_that.icon,_that.schedule,_that.dailyTarget,_that.startDate,_that.reminder,_that.archivedAt,_that.createdAt,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Habit implements Habit {
  const _Habit({required this.id, required this.title, this.description = '', required this.category, required this.color, required this.icon, required this.schedule, this.dailyTarget = 1, required this.startDate, this.reminder, this.archivedAt, required this.createdAt, required this.sortOrder});
  

@override final  String id;
@override final  String title;
@override@JsonKey() final  String description;
@override final  HabitCategory category;
@override final  HabitColor color;
@override final  HabitIcon icon;
@override final  HabitSchedule schedule;
/// Check-ins a day for the day to count as done ("8 glasses"): 1–20.
@override@JsonKey() final  int dailyTarget;
/// The first day the habit can be due.
@override final  CalendarDate startDate;
/// When to remind the user on a due day, if at all.
@override final  TimeOfDayValue? reminder;
/// When it was archived: an archived habit keeps its history and is
/// never due.
@override final  DateTime? archivedAt;
@override final  DateTime createdAt;
/// The position in the user's list.
@override final  int sortOrder;

/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitCopyWith<_Habit> get copyWith => __$HabitCopyWithImpl<_Habit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Habit&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.schedule, schedule) || other.schedule == schedule)&&(identical(other.dailyTarget, dailyTarget) || other.dailyTarget == dailyTarget)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.reminder, reminder) || other.reminder == reminder)&&(identical(other.archivedAt, archivedAt) || other.archivedAt == archivedAt)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,description,category,color,icon,schedule,dailyTarget,startDate,reminder,archivedAt,createdAt,sortOrder);
}

@override
String toString() {
    return 'Habit(id: $id, title: $title, description: $description, category: $category, color: $color, icon: $icon, schedule: $schedule, dailyTarget: $dailyTarget, startDate: $startDate, reminder: $reminder, archivedAt: $archivedAt, createdAt: $createdAt, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$HabitCopyWith<$Res> implements $HabitCopyWith<$Res> {
  factory _$HabitCopyWith(_Habit value, $Res Function(_Habit) _then) = __$HabitCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, HabitCategory category, HabitColor color, HabitIcon icon, HabitSchedule schedule, int dailyTarget, CalendarDate startDate, TimeOfDayValue? reminder, DateTime? archivedAt, DateTime createdAt, int sortOrder
});


@override $HabitScheduleCopyWith<$Res> get schedule;

}
/// @nodoc
class __$HabitCopyWithImpl<$Res>
    implements _$HabitCopyWith<$Res> {
  __$HabitCopyWithImpl(this._self, this._then);

  final _Habit _self;
  final $Res Function(_Habit) _then;

/// Create a copy of Habit
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? category = null,Object? color = null,Object? icon = null,Object? schedule = null,Object? dailyTarget = null,Object? startDate = null,Object? reminder = freezed,Object? archivedAt = freezed,Object? createdAt = null,Object? sortOrder = null,}) {
  return _then(_Habit(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as HabitColor,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as HabitIcon,schedule: null == schedule ? _self.schedule : schedule // ignore: cast_nullable_to_non_nullable
as HabitSchedule,dailyTarget: null == dailyTarget ? _self.dailyTarget : dailyTarget // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as CalendarDate,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue?,archivedAt: freezed == archivedAt ? _self.archivedAt : archivedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of Habit
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
