// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserData {

 List<Habit> get habits; List<HabitLog> get logs; List<Routine> get routines; List<RoutineCheck> get routineChecks; List<Goal> get goals; List<AchievementUnlock> get unlocks;
/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataCopyWith<UserData> get copyWith => _$UserDataCopyWithImpl<UserData>(this as UserData, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as UserData;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserData&&const DeepCollectionEquality().equals(other.habits, _this.habits)&&const DeepCollectionEquality().equals(other.logs, _this.logs)&&const DeepCollectionEquality().equals(other.routines, _this.routines)&&const DeepCollectionEquality().equals(other.routineChecks, _this.routineChecks)&&const DeepCollectionEquality().equals(other.goals, _this.goals)&&const DeepCollectionEquality().equals(other.unlocks, _this.unlocks));
}


@override
int get hashCode {
  final _this = this as UserData;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.habits),const DeepCollectionEquality().hash(_this.logs),const DeepCollectionEquality().hash(_this.routines),const DeepCollectionEquality().hash(_this.routineChecks),const DeepCollectionEquality().hash(_this.goals),const DeepCollectionEquality().hash(_this.unlocks));
}

@override
String toString() {
  final _this = this as UserData;
  return 'UserData(habits: ${_this.habits}, logs: ${_this.logs}, routines: ${_this.routines}, routineChecks: ${_this.routineChecks}, goals: ${_this.goals}, unlocks: ${_this.unlocks})';
}


}

/// @nodoc
abstract mixin class $UserDataCopyWith<$Res>  {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) _then) = _$UserDataCopyWithImpl;
@useResult
$Res call({
 List<Habit> habits, List<HabitLog> logs, List<Routine> routines, List<RoutineCheck> routineChecks, List<Goal> goals, List<AchievementUnlock> unlocks
});




}
/// @nodoc
class _$UserDataCopyWithImpl<$Res>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._self, this._then);

  final UserData _self;
  final $Res Function(UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? habits = null,Object? logs = null,Object? routines = null,Object? routineChecks = null,Object? goals = null,Object? unlocks = null,}) {
  return _then(UserData(
habits: null == habits ? _self.habits : habits // ignore: cast_nullable_to_non_nullable
as List<Habit>,logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as List<HabitLog>,routines: null == routines ? _self.routines : routines // ignore: cast_nullable_to_non_nullable
as List<Routine>,routineChecks: null == routineChecks ? _self.routineChecks : routineChecks // ignore: cast_nullable_to_non_nullable
as List<RoutineCheck>,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,unlocks: null == unlocks ? _self.unlocks : unlocks // ignore: cast_nullable_to_non_nullable
as List<AchievementUnlock>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserData].
extension UserDataPatterns on UserData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserData value)  $default,){
final _that = this;
switch (_that) {
case _UserData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserData value)?  $default,){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Habit> habits,  List<HabitLog> logs,  List<Routine> routines,  List<RoutineCheck> routineChecks,  List<Goal> goals,  List<AchievementUnlock> unlocks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.habits,_that.logs,_that.routines,_that.routineChecks,_that.goals,_that.unlocks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Habit> habits,  List<HabitLog> logs,  List<Routine> routines,  List<RoutineCheck> routineChecks,  List<Goal> goals,  List<AchievementUnlock> unlocks)  $default,) {final _that = this;
switch (_that) {
case _UserData():
return $default(_that.habits,_that.logs,_that.routines,_that.routineChecks,_that.goals,_that.unlocks);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Habit> habits,  List<HabitLog> logs,  List<Routine> routines,  List<RoutineCheck> routineChecks,  List<Goal> goals,  List<AchievementUnlock> unlocks)?  $default,) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.habits,_that.logs,_that.routines,_that.routineChecks,_that.goals,_that.unlocks);case _:
  return null;

}
}

}

/// @nodoc


class _UserData implements UserData {
  const _UserData({ List<Habit> habits = const <Habit>[],  List<HabitLog> logs = const <HabitLog>[],  List<Routine> routines = const <Routine>[],  List<RoutineCheck> routineChecks = const <RoutineCheck>[],  List<Goal> goals = const <Goal>[],  List<AchievementUnlock> unlocks = const <AchievementUnlock>[]}): _habits = habits,_logs = logs,_routines = routines,_routineChecks = routineChecks,_goals = goals,_unlocks = unlocks;
  

 final  List<Habit> _habits;
@override@JsonKey() List<Habit> get habits {
  if (_habits is EqualUnmodifiableListView) return _habits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_habits);
}

 final  List<HabitLog> _logs;
@override@JsonKey() List<HabitLog> get logs {
  if (_logs is EqualUnmodifiableListView) return _logs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_logs);
}

 final  List<Routine> _routines;
@override@JsonKey() List<Routine> get routines {
  if (_routines is EqualUnmodifiableListView) return _routines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routines);
}

 final  List<RoutineCheck> _routineChecks;
@override@JsonKey() List<RoutineCheck> get routineChecks {
  if (_routineChecks is EqualUnmodifiableListView) return _routineChecks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routineChecks);
}

 final  List<Goal> _goals;
@override@JsonKey() List<Goal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

 final  List<AchievementUnlock> _unlocks;
@override@JsonKey() List<AchievementUnlock> get unlocks {
  if (_unlocks is EqualUnmodifiableListView) return _unlocks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_unlocks);
}


/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataCopyWith<_UserData> get copyWith => __$UserDataCopyWithImpl<_UserData>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserData&&const DeepCollectionEquality().equals(other.habits, _habits)&&const DeepCollectionEquality().equals(other.logs, _logs)&&const DeepCollectionEquality().equals(other.routines, _routines)&&const DeepCollectionEquality().equals(other.routineChecks, _routineChecks)&&const DeepCollectionEquality().equals(other.goals, _goals)&&const DeepCollectionEquality().equals(other.unlocks, _unlocks));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_habits),const DeepCollectionEquality().hash(_logs),const DeepCollectionEquality().hash(_routines),const DeepCollectionEquality().hash(_routineChecks),const DeepCollectionEquality().hash(_goals),const DeepCollectionEquality().hash(_unlocks));
}

@override
String toString() {
    return 'UserData(habits: $habits, logs: $logs, routines: $routines, routineChecks: $routineChecks, goals: $goals, unlocks: $unlocks)';
}


}

/// @nodoc
abstract mixin class _$UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) _then) = __$UserDataCopyWithImpl;
@override @useResult
$Res call({
 List<Habit> habits, List<HabitLog> logs, List<Routine> routines, List<RoutineCheck> routineChecks, List<Goal> goals, List<AchievementUnlock> unlocks
});




}
/// @nodoc
class __$UserDataCopyWithImpl<$Res>
    implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(this._self, this._then);

  final _UserData _self;
  final $Res Function(_UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? habits = null,Object? logs = null,Object? routines = null,Object? routineChecks = null,Object? goals = null,Object? unlocks = null,}) {
  return _then(_UserData(
habits: null == habits ? _self._habits : habits // ignore: cast_nullable_to_non_nullable
as List<Habit>,logs: null == logs ? _self._logs : logs // ignore: cast_nullable_to_non_nullable
as List<HabitLog>,routines: null == routines ? _self._routines : routines // ignore: cast_nullable_to_non_nullable
as List<Routine>,routineChecks: null == routineChecks ? _self._routineChecks : routineChecks // ignore: cast_nullable_to_non_nullable
as List<RoutineCheck>,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,unlocks: null == unlocks ? _self._unlocks : unlocks // ignore: cast_nullable_to_non_nullable
as List<AchievementUnlock>,
  ));
}


}

// dart format on
