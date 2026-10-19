// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_overviews.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitToday {

 Habit get habit;/// Today's log, if any.
 HabitLog? get log; DayState get state;/// Whether today asks for it (it may be done, or skipped).
 bool get due; HabitStreak get streak;
/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitTodayCopyWith<HabitToday> get copyWith => _$HabitTodayCopyWithImpl<HabitToday>(this as HabitToday, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitToday;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitToday&&(identical(other.habit, _this.habit) || other.habit == _this.habit)&&(identical(other.log, _this.log) || other.log == _this.log)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.due, _this.due) || other.due == _this.due)&&(identical(other.streak, _this.streak) || other.streak == _this.streak));
}


@override
int get hashCode {
  final _this = this as HabitToday;
  return Object.hash(runtimeType,_this.habit,_this.log,_this.state,_this.due,_this.streak);
}

@override
String toString() {
  final _this = this as HabitToday;
  return 'HabitToday(habit: ${_this.habit}, log: ${_this.log}, state: ${_this.state}, due: ${_this.due}, streak: ${_this.streak})';
}


}

/// @nodoc
abstract mixin class $HabitTodayCopyWith<$Res>  {
  factory $HabitTodayCopyWith(HabitToday value, $Res Function(HabitToday) _then) = _$HabitTodayCopyWithImpl;
@useResult
$Res call({
 Habit habit, HabitLog? log, DayState state, bool due, HabitStreak streak
});


$HabitCopyWith<$Res> get habit;$HabitLogCopyWith<$Res>? get log;

}
/// @nodoc
class _$HabitTodayCopyWithImpl<$Res>
    implements $HabitTodayCopyWith<$Res> {
  _$HabitTodayCopyWithImpl(this._self, this._then);

  final HabitToday _self;
  final $Res Function(HabitToday) _then;

/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? habit = null,Object? log = freezed,Object? state = null,Object? due = null,Object? streak = null,}) {
  return _then(HabitToday(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,log: freezed == log ? _self.log : log // ignore: cast_nullable_to_non_nullable
as HabitLog?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DayState,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as bool,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as HabitStreak,
  ));
}
/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitLogCopyWith<$Res>? get log {
    if (_self.log == null) {
    return null;
  }

  return $HabitLogCopyWith<$Res>(_self.log!, (value) {
    return _then(_self.copyWith(log: value));
  });
}
}


/// Adds pattern-matching-related methods to [HabitToday].
extension HabitTodayPatterns on HabitToday {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitToday value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitToday() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitToday value)  $default,){
final _that = this;
switch (_that) {
case _HabitToday():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitToday value)?  $default,){
final _that = this;
switch (_that) {
case _HabitToday() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Habit habit,  HabitLog? log,  DayState state,  bool due,  HabitStreak streak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitToday() when $default != null:
return $default(_that.habit,_that.log,_that.state,_that.due,_that.streak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Habit habit,  HabitLog? log,  DayState state,  bool due,  HabitStreak streak)  $default,) {final _that = this;
switch (_that) {
case _HabitToday():
return $default(_that.habit,_that.log,_that.state,_that.due,_that.streak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Habit habit,  HabitLog? log,  DayState state,  bool due,  HabitStreak streak)?  $default,) {final _that = this;
switch (_that) {
case _HabitToday() when $default != null:
return $default(_that.habit,_that.log,_that.state,_that.due,_that.streak);case _:
  return null;

}
}

}

/// @nodoc


class _HabitToday extends HabitToday {
  const _HabitToday({required this.habit, this.log, required this.state, required this.due, required this.streak}): super._();
  

@override final  Habit habit;
/// Today's log, if any.
@override final  HabitLog? log;
@override final  DayState state;
/// Whether today asks for it (it may be done, or skipped).
@override final  bool due;
@override final  HabitStreak streak;

/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitTodayCopyWith<_HabitToday> get copyWith => __$HabitTodayCopyWithImpl<_HabitToday>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitToday&&(identical(other.habit, habit) || other.habit == habit)&&(identical(other.log, log) || other.log == log)&&(identical(other.state, state) || other.state == state)&&(identical(other.due, due) || other.due == due)&&(identical(other.streak, streak) || other.streak == streak));
}


@override
int get hashCode {
    return Object.hash(runtimeType,habit,log,state,due,streak);
}

@override
String toString() {
    return 'HabitToday(habit: $habit, log: $log, state: $state, due: $due, streak: $streak)';
}


}

/// @nodoc
abstract mixin class _$HabitTodayCopyWith<$Res> implements $HabitTodayCopyWith<$Res> {
  factory _$HabitTodayCopyWith(_HabitToday value, $Res Function(_HabitToday) _then) = __$HabitTodayCopyWithImpl;
@override @useResult
$Res call({
 Habit habit, HabitLog? log, DayState state, bool due, HabitStreak streak
});


@override $HabitCopyWith<$Res> get habit;@override $HabitLogCopyWith<$Res>? get log;

}
/// @nodoc
class __$HabitTodayCopyWithImpl<$Res>
    implements _$HabitTodayCopyWith<$Res> {
  __$HabitTodayCopyWithImpl(this._self, this._then);

  final _HabitToday _self;
  final $Res Function(_HabitToday) _then;

/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? habit = null,Object? log = freezed,Object? state = null,Object? due = null,Object? streak = null,}) {
  return _then(_HabitToday(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,log: freezed == log ? _self.log : log // ignore: cast_nullable_to_non_nullable
as HabitLog?,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DayState,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as bool,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as HabitStreak,
  ));
}

/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}/// Create a copy of HabitToday
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitLogCopyWith<$Res>? get log {
    if (_self.log == null) {
    return null;
  }

  return $HabitLogCopyWith<$Res>(_self.log!, (value) {
    return _then(_self.copyWith(log: value));
  });
}
}

/// @nodoc
mixin _$TodaySummary {

/// Habits due today, not counting skips.
 int get due;/// Of those, done.
 int get done; int get perfectDays;/// Monday to Sunday of this week.
 List<DayDot> get week;
/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodaySummaryCopyWith<TodaySummary> get copyWith => _$TodaySummaryCopyWithImpl<TodaySummary>(this as TodaySummary, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TodaySummary;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodaySummary&&(identical(other.due, _this.due) || other.due == _this.due)&&(identical(other.done, _this.done) || other.done == _this.done)&&(identical(other.perfectDays, _this.perfectDays) || other.perfectDays == _this.perfectDays)&&const DeepCollectionEquality().equals(other.week, _this.week));
}


@override
int get hashCode {
  final _this = this as TodaySummary;
  return Object.hash(runtimeType,_this.due,_this.done,_this.perfectDays,const DeepCollectionEquality().hash(_this.week));
}

@override
String toString() {
  final _this = this as TodaySummary;
  return 'TodaySummary(due: ${_this.due}, done: ${_this.done}, perfectDays: ${_this.perfectDays}, week: ${_this.week})';
}


}

/// @nodoc
abstract mixin class $TodaySummaryCopyWith<$Res>  {
  factory $TodaySummaryCopyWith(TodaySummary value, $Res Function(TodaySummary) _then) = _$TodaySummaryCopyWithImpl;
@useResult
$Res call({
 int due, int done, int perfectDays, List<DayDot> week
});




}
/// @nodoc
class _$TodaySummaryCopyWithImpl<$Res>
    implements $TodaySummaryCopyWith<$Res> {
  _$TodaySummaryCopyWithImpl(this._self, this._then);

  final TodaySummary _self;
  final $Res Function(TodaySummary) _then;

/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? due = null,Object? done = null,Object? perfectDays = null,Object? week = null,}) {
  return _then(TodaySummary(
due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as int,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,perfectDays: null == perfectDays ? _self.perfectDays : perfectDays // ignore: cast_nullable_to_non_nullable
as int,week: null == week ? _self.week : week // ignore: cast_nullable_to_non_nullable
as List<DayDot>,
  ));
}

}


/// Adds pattern-matching-related methods to [TodaySummary].
extension TodaySummaryPatterns on TodaySummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodaySummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodaySummary value)  $default,){
final _that = this;
switch (_that) {
case _TodaySummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodaySummary value)?  $default,){
final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int due,  int done,  int perfectDays,  List<DayDot> week)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
return $default(_that.due,_that.done,_that.perfectDays,_that.week);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int due,  int done,  int perfectDays,  List<DayDot> week)  $default,) {final _that = this;
switch (_that) {
case _TodaySummary():
return $default(_that.due,_that.done,_that.perfectDays,_that.week);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int due,  int done,  int perfectDays,  List<DayDot> week)?  $default,) {final _that = this;
switch (_that) {
case _TodaySummary() when $default != null:
return $default(_that.due,_that.done,_that.perfectDays,_that.week);case _:
  return null;

}
}

}

/// @nodoc


class _TodaySummary extends TodaySummary {
  const _TodaySummary({required this.due, required this.done, required this.perfectDays, required  List<DayDot> week}): _week = week,super._();
  

/// Habits due today, not counting skips.
@override final  int due;
/// Of those, done.
@override final  int done;
@override final  int perfectDays;
/// Monday to Sunday of this week.
 final  List<DayDot> _week;
/// Monday to Sunday of this week.
@override List<DayDot> get week {
  if (_week is EqualUnmodifiableListView) return _week;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_week);
}


/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodaySummaryCopyWith<_TodaySummary> get copyWith => __$TodaySummaryCopyWithImpl<_TodaySummary>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodaySummary&&(identical(other.due, due) || other.due == due)&&(identical(other.done, done) || other.done == done)&&(identical(other.perfectDays, perfectDays) || other.perfectDays == perfectDays)&&const DeepCollectionEquality().equals(other.week, _week));
}


@override
int get hashCode {
    return Object.hash(runtimeType,due,done,perfectDays,const DeepCollectionEquality().hash(_week));
}

@override
String toString() {
    return 'TodaySummary(due: $due, done: $done, perfectDays: $perfectDays, week: $week)';
}


}

/// @nodoc
abstract mixin class _$TodaySummaryCopyWith<$Res> implements $TodaySummaryCopyWith<$Res> {
  factory _$TodaySummaryCopyWith(_TodaySummary value, $Res Function(_TodaySummary) _then) = __$TodaySummaryCopyWithImpl;
@override @useResult
$Res call({
 int due, int done, int perfectDays, List<DayDot> week
});




}
/// @nodoc
class __$TodaySummaryCopyWithImpl<$Res>
    implements _$TodaySummaryCopyWith<$Res> {
  __$TodaySummaryCopyWithImpl(this._self, this._then);

  final _TodaySummary _self;
  final $Res Function(_TodaySummary) _then;

/// Create a copy of TodaySummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? due = null,Object? done = null,Object? perfectDays = null,Object? week = null,}) {
  return _then(_TodaySummary(
due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as int,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,perfectDays: null == perfectDays ? _self.perfectDays : perfectDays // ignore: cast_nullable_to_non_nullable
as int,week: null == week ? _self._week : week // ignore: cast_nullable_to_non_nullable
as List<DayDot>,
  ));
}


}

/// @nodoc
mixin _$TodayOverview {

 CalendarDate get today; TodaySummary get summary;/// Due today: not done first, then done, then skipped.
 List<HabitToday> get due;/// The rest: not due today (another weekday, or the week's target met).
 List<HabitToday> get notDue;/// Routines, in the order of the day, with today's check-offs.
 List<RoutineProgress> get routines;/// Every goal, with its progress in its current window.
 List<GoalProgress> get goals;
/// Create a copy of TodayOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TodayOverviewCopyWith<TodayOverview> get copyWith => _$TodayOverviewCopyWithImpl<TodayOverview>(this as TodayOverview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as TodayOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TodayOverview&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.summary, _this.summary) || other.summary == _this.summary)&&const DeepCollectionEquality().equals(other.due, _this.due)&&const DeepCollectionEquality().equals(other.notDue, _this.notDue)&&const DeepCollectionEquality().equals(other.routines, _this.routines)&&const DeepCollectionEquality().equals(other.goals, _this.goals));
}


@override
int get hashCode {
  final _this = this as TodayOverview;
  return Object.hash(runtimeType,_this.today,_this.summary,const DeepCollectionEquality().hash(_this.due),const DeepCollectionEquality().hash(_this.notDue),const DeepCollectionEquality().hash(_this.routines),const DeepCollectionEquality().hash(_this.goals));
}

@override
String toString() {
  final _this = this as TodayOverview;
  return 'TodayOverview(today: ${_this.today}, summary: ${_this.summary}, due: ${_this.due}, notDue: ${_this.notDue}, routines: ${_this.routines}, goals: ${_this.goals})';
}


}

/// @nodoc
abstract mixin class $TodayOverviewCopyWith<$Res>  {
  factory $TodayOverviewCopyWith(TodayOverview value, $Res Function(TodayOverview) _then) = _$TodayOverviewCopyWithImpl;
@useResult
$Res call({
 CalendarDate today, TodaySummary summary, List<HabitToday> due, List<HabitToday> notDue, List<RoutineProgress> routines, List<GoalProgress> goals
});


$TodaySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class _$TodayOverviewCopyWithImpl<$Res>
    implements $TodayOverviewCopyWith<$Res> {
  _$TodayOverviewCopyWithImpl(this._self, this._then);

  final TodayOverview _self;
  final $Res Function(TodayOverview) _then;

/// Create a copy of TodayOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? today = null,Object? summary = null,Object? due = null,Object? notDue = null,Object? routines = null,Object? goals = null,}) {
  return _then(TodayOverview(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TodaySummary,due: null == due ? _self.due : due // ignore: cast_nullable_to_non_nullable
as List<HabitToday>,notDue: null == notDue ? _self.notDue : notDue // ignore: cast_nullable_to_non_nullable
as List<HabitToday>,routines: null == routines ? _self.routines : routines // ignore: cast_nullable_to_non_nullable
as List<RoutineProgress>,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalProgress>,
  ));
}
/// Create a copy of TodayOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodaySummaryCopyWith<$Res> get summary {
  
  return $TodaySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}


/// Adds pattern-matching-related methods to [TodayOverview].
extension TodayOverviewPatterns on TodayOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TodayOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TodayOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TodayOverview value)  $default,){
final _that = this;
switch (_that) {
case _TodayOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TodayOverview value)?  $default,){
final _that = this;
switch (_that) {
case _TodayOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarDate today,  TodaySummary summary,  List<HabitToday> due,  List<HabitToday> notDue,  List<RoutineProgress> routines,  List<GoalProgress> goals)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TodayOverview() when $default != null:
return $default(_that.today,_that.summary,_that.due,_that.notDue,_that.routines,_that.goals);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarDate today,  TodaySummary summary,  List<HabitToday> due,  List<HabitToday> notDue,  List<RoutineProgress> routines,  List<GoalProgress> goals)  $default,) {final _that = this;
switch (_that) {
case _TodayOverview():
return $default(_that.today,_that.summary,_that.due,_that.notDue,_that.routines,_that.goals);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarDate today,  TodaySummary summary,  List<HabitToday> due,  List<HabitToday> notDue,  List<RoutineProgress> routines,  List<GoalProgress> goals)?  $default,) {final _that = this;
switch (_that) {
case _TodayOverview() when $default != null:
return $default(_that.today,_that.summary,_that.due,_that.notDue,_that.routines,_that.goals);case _:
  return null;

}
}

}

/// @nodoc


class _TodayOverview extends TodayOverview {
  const _TodayOverview({required this.today, required this.summary, required  List<HabitToday> due, required  List<HabitToday> notDue,  List<RoutineProgress> routines = const <RoutineProgress>[],  List<GoalProgress> goals = const <GoalProgress>[]}): _due = due,_notDue = notDue,_routines = routines,_goals = goals,super._();
  

@override final  CalendarDate today;
@override final  TodaySummary summary;
/// Due today: not done first, then done, then skipped.
 final  List<HabitToday> _due;
/// Due today: not done first, then done, then skipped.
@override List<HabitToday> get due {
  if (_due is EqualUnmodifiableListView) return _due;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_due);
}

/// The rest: not due today (another weekday, or the week's target met).
 final  List<HabitToday> _notDue;
/// The rest: not due today (another weekday, or the week's target met).
@override List<HabitToday> get notDue {
  if (_notDue is EqualUnmodifiableListView) return _notDue;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_notDue);
}

/// Routines, in the order of the day, with today's check-offs.
 final  List<RoutineProgress> _routines;
/// Routines, in the order of the day, with today's check-offs.
@override@JsonKey() List<RoutineProgress> get routines {
  if (_routines is EqualUnmodifiableListView) return _routines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routines);
}

/// Every goal, with its progress in its current window.
 final  List<GoalProgress> _goals;
/// Every goal, with its progress in its current window.
@override@JsonKey() List<GoalProgress> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}


/// Create a copy of TodayOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayOverviewCopyWith<_TodayOverview> get copyWith => __$TodayOverviewCopyWithImpl<_TodayOverview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayOverview&&(identical(other.today, today) || other.today == today)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.due, _due)&&const DeepCollectionEquality().equals(other.notDue, _notDue)&&const DeepCollectionEquality().equals(other.routines, _routines)&&const DeepCollectionEquality().equals(other.goals, _goals));
}


@override
int get hashCode {
    return Object.hash(runtimeType,today,summary,const DeepCollectionEquality().hash(_due),const DeepCollectionEquality().hash(_notDue),const DeepCollectionEquality().hash(_routines),const DeepCollectionEquality().hash(_goals));
}

@override
String toString() {
    return 'TodayOverview(today: $today, summary: $summary, due: $due, notDue: $notDue, routines: $routines, goals: $goals)';
}


}

/// @nodoc
abstract mixin class _$TodayOverviewCopyWith<$Res> implements $TodayOverviewCopyWith<$Res> {
  factory _$TodayOverviewCopyWith(_TodayOverview value, $Res Function(_TodayOverview) _then) = __$TodayOverviewCopyWithImpl;
@override @useResult
$Res call({
 CalendarDate today, TodaySummary summary, List<HabitToday> due, List<HabitToday> notDue, List<RoutineProgress> routines, List<GoalProgress> goals
});


@override $TodaySummaryCopyWith<$Res> get summary;

}
/// @nodoc
class __$TodayOverviewCopyWithImpl<$Res>
    implements _$TodayOverviewCopyWith<$Res> {
  __$TodayOverviewCopyWithImpl(this._self, this._then);

  final _TodayOverview _self;
  final $Res Function(_TodayOverview) _then;

/// Create a copy of TodayOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? today = null,Object? summary = null,Object? due = null,Object? notDue = null,Object? routines = null,Object? goals = null,}) {
  return _then(_TodayOverview(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as TodaySummary,due: null == due ? _self._due : due // ignore: cast_nullable_to_non_nullable
as List<HabitToday>,notDue: null == notDue ? _self._notDue : notDue // ignore: cast_nullable_to_non_nullable
as List<HabitToday>,routines: null == routines ? _self._routines : routines // ignore: cast_nullable_to_non_nullable
as List<RoutineProgress>,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<GoalProgress>,
  ));
}

/// Create a copy of TodayOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TodaySummaryCopyWith<$Res> get summary {
  
  return $TodaySummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}
}

/// @nodoc
mixin _$HeatmapDay {

 CalendarDate get day; DayState get state;/// Whether tapping it may toggle it (backfill).
 bool get canSet;
/// Create a copy of HeatmapDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HeatmapDayCopyWith<HeatmapDay> get copyWith => _$HeatmapDayCopyWithImpl<HeatmapDay>(this as HeatmapDay, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HeatmapDay;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HeatmapDay&&(identical(other.day, _this.day) || other.day == _this.day)&&(identical(other.state, _this.state) || other.state == _this.state)&&(identical(other.canSet, _this.canSet) || other.canSet == _this.canSet));
}


@override
int get hashCode {
  final _this = this as HeatmapDay;
  return Object.hash(runtimeType,_this.day,_this.state,_this.canSet);
}

@override
String toString() {
  final _this = this as HeatmapDay;
  return 'HeatmapDay(day: ${_this.day}, state: ${_this.state}, canSet: ${_this.canSet})';
}


}

/// @nodoc
abstract mixin class $HeatmapDayCopyWith<$Res>  {
  factory $HeatmapDayCopyWith(HeatmapDay value, $Res Function(HeatmapDay) _then) = _$HeatmapDayCopyWithImpl;
@useResult
$Res call({
 CalendarDate day, DayState state, bool canSet
});




}
/// @nodoc
class _$HeatmapDayCopyWithImpl<$Res>
    implements $HeatmapDayCopyWith<$Res> {
  _$HeatmapDayCopyWithImpl(this._self, this._then);

  final HeatmapDay _self;
  final $Res Function(HeatmapDay) _then;

/// Create a copy of HeatmapDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? day = null,Object? state = null,Object? canSet = null,}) {
  return _then(HeatmapDay(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as CalendarDate,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DayState,canSet: null == canSet ? _self.canSet : canSet // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [HeatmapDay].
extension HeatmapDayPatterns on HeatmapDay {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HeatmapDay value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HeatmapDay() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HeatmapDay value)  $default,){
final _that = this;
switch (_that) {
case _HeatmapDay():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HeatmapDay value)?  $default,){
final _that = this;
switch (_that) {
case _HeatmapDay() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarDate day,  DayState state,  bool canSet)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HeatmapDay() when $default != null:
return $default(_that.day,_that.state,_that.canSet);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarDate day,  DayState state,  bool canSet)  $default,) {final _that = this;
switch (_that) {
case _HeatmapDay():
return $default(_that.day,_that.state,_that.canSet);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarDate day,  DayState state,  bool canSet)?  $default,) {final _that = this;
switch (_that) {
case _HeatmapDay() when $default != null:
return $default(_that.day,_that.state,_that.canSet);case _:
  return null;

}
}

}

/// @nodoc


class _HeatmapDay implements HeatmapDay {
  const _HeatmapDay({required this.day, required this.state, required this.canSet});
  

@override final  CalendarDate day;
@override final  DayState state;
/// Whether tapping it may toggle it (backfill).
@override final  bool canSet;

/// Create a copy of HeatmapDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HeatmapDayCopyWith<_HeatmapDay> get copyWith => __$HeatmapDayCopyWithImpl<_HeatmapDay>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HeatmapDay&&(identical(other.day, day) || other.day == day)&&(identical(other.state, state) || other.state == state)&&(identical(other.canSet, canSet) || other.canSet == canSet));
}


@override
int get hashCode {
    return Object.hash(runtimeType,day,state,canSet);
}

@override
String toString() {
    return 'HeatmapDay(day: $day, state: $state, canSet: $canSet)';
}


}

/// @nodoc
abstract mixin class _$HeatmapDayCopyWith<$Res> implements $HeatmapDayCopyWith<$Res> {
  factory _$HeatmapDayCopyWith(_HeatmapDay value, $Res Function(_HeatmapDay) _then) = __$HeatmapDayCopyWithImpl;
@override @useResult
$Res call({
 CalendarDate day, DayState state, bool canSet
});




}
/// @nodoc
class __$HeatmapDayCopyWithImpl<$Res>
    implements _$HeatmapDayCopyWith<$Res> {
  __$HeatmapDayCopyWithImpl(this._self, this._then);

  final _HeatmapDay _self;
  final $Res Function(_HeatmapDay) _then;

/// Create a copy of HeatmapDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? day = null,Object? state = null,Object? canSet = null,}) {
  return _then(_HeatmapDay(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as CalendarDate,state: null == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as DayState,canSet: null == canSet ? _self.canSet : canSet // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$WeekBar {

 CalendarDate get weekStart; int get done; int get target;
/// Create a copy of WeekBar
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeekBarCopyWith<WeekBar> get copyWith => _$WeekBarCopyWithImpl<WeekBar>(this as WeekBar, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WeekBar;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeekBar&&(identical(other.weekStart, _this.weekStart) || other.weekStart == _this.weekStart)&&(identical(other.done, _this.done) || other.done == _this.done)&&(identical(other.target, _this.target) || other.target == _this.target));
}


@override
int get hashCode {
  final _this = this as WeekBar;
  return Object.hash(runtimeType,_this.weekStart,_this.done,_this.target);
}

@override
String toString() {
  final _this = this as WeekBar;
  return 'WeekBar(weekStart: ${_this.weekStart}, done: ${_this.done}, target: ${_this.target})';
}


}

/// @nodoc
abstract mixin class $WeekBarCopyWith<$Res>  {
  factory $WeekBarCopyWith(WeekBar value, $Res Function(WeekBar) _then) = _$WeekBarCopyWithImpl;
@useResult
$Res call({
 CalendarDate weekStart, int done, int target
});




}
/// @nodoc
class _$WeekBarCopyWithImpl<$Res>
    implements $WeekBarCopyWith<$Res> {
  _$WeekBarCopyWithImpl(this._self, this._then);

  final WeekBar _self;
  final $Res Function(WeekBar) _then;

/// Create a copy of WeekBar
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? weekStart = null,Object? done = null,Object? target = null,}) {
  return _then(WeekBar(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as CalendarDate,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WeekBar].
extension WeekBarPatterns on WeekBar {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeekBar value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeekBar() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeekBar value)  $default,){
final _that = this;
switch (_that) {
case _WeekBar():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeekBar value)?  $default,){
final _that = this;
switch (_that) {
case _WeekBar() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarDate weekStart,  int done,  int target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeekBar() when $default != null:
return $default(_that.weekStart,_that.done,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarDate weekStart,  int done,  int target)  $default,) {final _that = this;
switch (_that) {
case _WeekBar():
return $default(_that.weekStart,_that.done,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarDate weekStart,  int done,  int target)?  $default,) {final _that = this;
switch (_that) {
case _WeekBar() when $default != null:
return $default(_that.weekStart,_that.done,_that.target);case _:
  return null;

}
}

}

/// @nodoc


class _WeekBar implements WeekBar {
  const _WeekBar({required this.weekStart, required this.done, required this.target});
  

@override final  CalendarDate weekStart;
@override final  int done;
@override final  int target;

/// Create a copy of WeekBar
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeekBarCopyWith<_WeekBar> get copyWith => __$WeekBarCopyWithImpl<_WeekBar>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeekBar&&(identical(other.weekStart, weekStart) || other.weekStart == weekStart)&&(identical(other.done, done) || other.done == done)&&(identical(other.target, target) || other.target == target));
}


@override
int get hashCode {
    return Object.hash(runtimeType,weekStart,done,target);
}

@override
String toString() {
    return 'WeekBar(weekStart: $weekStart, done: $done, target: $target)';
}


}

/// @nodoc
abstract mixin class _$WeekBarCopyWith<$Res> implements $WeekBarCopyWith<$Res> {
  factory _$WeekBarCopyWith(_WeekBar value, $Res Function(_WeekBar) _then) = __$WeekBarCopyWithImpl;
@override @useResult
$Res call({
 CalendarDate weekStart, int done, int target
});




}
/// @nodoc
class __$WeekBarCopyWithImpl<$Res>
    implements _$WeekBarCopyWith<$Res> {
  __$WeekBarCopyWithImpl(this._self, this._then);

  final _WeekBar _self;
  final $Res Function(_WeekBar) _then;

/// Create a copy of WeekBar
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? weekStart = null,Object? done = null,Object? target = null,}) {
  return _then(_WeekBar(
weekStart: null == weekStart ? _self.weekStart : weekStart // ignore: cast_nullable_to_non_nullable
as CalendarDate,done: null == done ? _self.done : done // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$HabitDetail {

 Habit get habit; CalendarDate get today; HabitStreak get streak;/// Since the habit started.
 CompletionRate get rate; int get totalCompletions;/// Whole weeks, Monday to Sunday, oldest first; the last holds today.
 List<HeatmapDay> get heatmap;/// The last eight weeks, oldest first.
 List<WeekBar> get weeks;
/// Create a copy of HabitDetail
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitDetailCopyWith<HabitDetail> get copyWith => _$HabitDetailCopyWithImpl<HabitDetail>(this as HabitDetail, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitDetail;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitDetail&&(identical(other.habit, _this.habit) || other.habit == _this.habit)&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.streak, _this.streak) || other.streak == _this.streak)&&(identical(other.rate, _this.rate) || other.rate == _this.rate)&&(identical(other.totalCompletions, _this.totalCompletions) || other.totalCompletions == _this.totalCompletions)&&const DeepCollectionEquality().equals(other.heatmap, _this.heatmap)&&const DeepCollectionEquality().equals(other.weeks, _this.weeks));
}


@override
int get hashCode {
  final _this = this as HabitDetail;
  return Object.hash(runtimeType,_this.habit,_this.today,_this.streak,_this.rate,_this.totalCompletions,const DeepCollectionEquality().hash(_this.heatmap),const DeepCollectionEquality().hash(_this.weeks));
}

@override
String toString() {
  final _this = this as HabitDetail;
  return 'HabitDetail(habit: ${_this.habit}, today: ${_this.today}, streak: ${_this.streak}, rate: ${_this.rate}, totalCompletions: ${_this.totalCompletions}, heatmap: ${_this.heatmap}, weeks: ${_this.weeks})';
}


}

/// @nodoc
abstract mixin class $HabitDetailCopyWith<$Res>  {
  factory $HabitDetailCopyWith(HabitDetail value, $Res Function(HabitDetail) _then) = _$HabitDetailCopyWithImpl;
@useResult
$Res call({
 Habit habit, CalendarDate today, HabitStreak streak, CompletionRate rate, int totalCompletions, List<HeatmapDay> heatmap, List<WeekBar> weeks
});


$HabitCopyWith<$Res> get habit;

}
/// @nodoc
class _$HabitDetailCopyWithImpl<$Res>
    implements $HabitDetailCopyWith<$Res> {
  _$HabitDetailCopyWithImpl(this._self, this._then);

  final HabitDetail _self;
  final $Res Function(HabitDetail) _then;

/// Create a copy of HabitDetail
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? habit = null,Object? today = null,Object? streak = null,Object? rate = null,Object? totalCompletions = null,Object? heatmap = null,Object? weeks = null,}) {
  return _then(HabitDetail(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as HabitStreak,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as CompletionRate,totalCompletions: null == totalCompletions ? _self.totalCompletions : totalCompletions // ignore: cast_nullable_to_non_nullable
as int,heatmap: null == heatmap ? _self.heatmap : heatmap // ignore: cast_nullable_to_non_nullable
as List<HeatmapDay>,weeks: null == weeks ? _self.weeks : weeks // ignore: cast_nullable_to_non_nullable
as List<WeekBar>,
  ));
}
/// Create a copy of HabitDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}


/// Adds pattern-matching-related methods to [HabitDetail].
extension HabitDetailPatterns on HabitDetail {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitDetail value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitDetail() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitDetail value)  $default,){
final _that = this;
switch (_that) {
case _HabitDetail():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitDetail value)?  $default,){
final _that = this;
switch (_that) {
case _HabitDetail() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Habit habit,  CalendarDate today,  HabitStreak streak,  CompletionRate rate,  int totalCompletions,  List<HeatmapDay> heatmap,  List<WeekBar> weeks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitDetail() when $default != null:
return $default(_that.habit,_that.today,_that.streak,_that.rate,_that.totalCompletions,_that.heatmap,_that.weeks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Habit habit,  CalendarDate today,  HabitStreak streak,  CompletionRate rate,  int totalCompletions,  List<HeatmapDay> heatmap,  List<WeekBar> weeks)  $default,) {final _that = this;
switch (_that) {
case _HabitDetail():
return $default(_that.habit,_that.today,_that.streak,_that.rate,_that.totalCompletions,_that.heatmap,_that.weeks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Habit habit,  CalendarDate today,  HabitStreak streak,  CompletionRate rate,  int totalCompletions,  List<HeatmapDay> heatmap,  List<WeekBar> weeks)?  $default,) {final _that = this;
switch (_that) {
case _HabitDetail() when $default != null:
return $default(_that.habit,_that.today,_that.streak,_that.rate,_that.totalCompletions,_that.heatmap,_that.weeks);case _:
  return null;

}
}

}

/// @nodoc


class _HabitDetail implements HabitDetail {
  const _HabitDetail({required this.habit, required this.today, required this.streak, required this.rate, required this.totalCompletions, required  List<HeatmapDay> heatmap, required  List<WeekBar> weeks}): _heatmap = heatmap,_weeks = weeks;
  

@override final  Habit habit;
@override final  CalendarDate today;
@override final  HabitStreak streak;
/// Since the habit started.
@override final  CompletionRate rate;
@override final  int totalCompletions;
/// Whole weeks, Monday to Sunday, oldest first; the last holds today.
 final  List<HeatmapDay> _heatmap;
/// Whole weeks, Monday to Sunday, oldest first; the last holds today.
@override List<HeatmapDay> get heatmap {
  if (_heatmap is EqualUnmodifiableListView) return _heatmap;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_heatmap);
}

/// The last eight weeks, oldest first.
 final  List<WeekBar> _weeks;
/// The last eight weeks, oldest first.
@override List<WeekBar> get weeks {
  if (_weeks is EqualUnmodifiableListView) return _weeks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeks);
}


/// Create a copy of HabitDetail
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitDetailCopyWith<_HabitDetail> get copyWith => __$HabitDetailCopyWithImpl<_HabitDetail>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitDetail&&(identical(other.habit, habit) || other.habit == habit)&&(identical(other.today, today) || other.today == today)&&(identical(other.streak, streak) || other.streak == streak)&&(identical(other.rate, rate) || other.rate == rate)&&(identical(other.totalCompletions, totalCompletions) || other.totalCompletions == totalCompletions)&&const DeepCollectionEquality().equals(other.heatmap, _heatmap)&&const DeepCollectionEquality().equals(other.weeks, _weeks));
}


@override
int get hashCode {
    return Object.hash(runtimeType,habit,today,streak,rate,totalCompletions,const DeepCollectionEquality().hash(_heatmap),const DeepCollectionEquality().hash(_weeks));
}

@override
String toString() {
    return 'HabitDetail(habit: $habit, today: $today, streak: $streak, rate: $rate, totalCompletions: $totalCompletions, heatmap: $heatmap, weeks: $weeks)';
}


}

/// @nodoc
abstract mixin class _$HabitDetailCopyWith<$Res> implements $HabitDetailCopyWith<$Res> {
  factory _$HabitDetailCopyWith(_HabitDetail value, $Res Function(_HabitDetail) _then) = __$HabitDetailCopyWithImpl;
@override @useResult
$Res call({
 Habit habit, CalendarDate today, HabitStreak streak, CompletionRate rate, int totalCompletions, List<HeatmapDay> heatmap, List<WeekBar> weeks
});


@override $HabitCopyWith<$Res> get habit;

}
/// @nodoc
class __$HabitDetailCopyWithImpl<$Res>
    implements _$HabitDetailCopyWith<$Res> {
  __$HabitDetailCopyWithImpl(this._self, this._then);

  final _HabitDetail _self;
  final $Res Function(_HabitDetail) _then;

/// Create a copy of HabitDetail
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? habit = null,Object? today = null,Object? streak = null,Object? rate = null,Object? totalCompletions = null,Object? heatmap = null,Object? weeks = null,}) {
  return _then(_HabitDetail(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as HabitStreak,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as CompletionRate,totalCompletions: null == totalCompletions ? _self.totalCompletions : totalCompletions // ignore: cast_nullable_to_non_nullable
as int,heatmap: null == heatmap ? _self._heatmap : heatmap // ignore: cast_nullable_to_non_nullable
as List<HeatmapDay>,weeks: null == weeks ? _self._weeks : weeks // ignore: cast_nullable_to_non_nullable
as List<WeekBar>,
  ));
}

/// Create a copy of HabitDetail
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}

// dart format on
