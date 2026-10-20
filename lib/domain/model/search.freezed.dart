// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SearchResults {

 List<Habit> get habits; List<Routine> get routines; List<Goal> get goals; List<AchievementId> get achievements;
/// Create a copy of SearchResults
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SearchResultsCopyWith<SearchResults> get copyWith => _$SearchResultsCopyWithImpl<SearchResults>(this as SearchResults, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as SearchResults;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SearchResults&&const DeepCollectionEquality().equals(other.habits, _this.habits)&&const DeepCollectionEquality().equals(other.routines, _this.routines)&&const DeepCollectionEquality().equals(other.goals, _this.goals)&&const DeepCollectionEquality().equals(other.achievements, _this.achievements));
}


@override
int get hashCode {
  final _this = this as SearchResults;
  return Object.hash(runtimeType,const DeepCollectionEquality().hash(_this.habits),const DeepCollectionEquality().hash(_this.routines),const DeepCollectionEquality().hash(_this.goals),const DeepCollectionEquality().hash(_this.achievements));
}

@override
String toString() {
  final _this = this as SearchResults;
  return 'SearchResults(habits: ${_this.habits}, routines: ${_this.routines}, goals: ${_this.goals}, achievements: ${_this.achievements})';
}


}

/// @nodoc
abstract mixin class $SearchResultsCopyWith<$Res>  {
  factory $SearchResultsCopyWith(SearchResults value, $Res Function(SearchResults) _then) = _$SearchResultsCopyWithImpl;
@useResult
$Res call({
 List<Habit> habits, List<Routine> routines, List<Goal> goals, List<AchievementId> achievements
});




}
/// @nodoc
class _$SearchResultsCopyWithImpl<$Res>
    implements $SearchResultsCopyWith<$Res> {
  _$SearchResultsCopyWithImpl(this._self, this._then);

  final SearchResults _self;
  final $Res Function(SearchResults) _then;

/// Create a copy of SearchResults
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? habits = null,Object? routines = null,Object? goals = null,Object? achievements = null,}) {
  return _then(SearchResults(
habits: null == habits ? _self.habits : habits // ignore: cast_nullable_to_non_nullable
as List<Habit>,routines: null == routines ? _self.routines : routines // ignore: cast_nullable_to_non_nullable
as List<Routine>,goals: null == goals ? _self.goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,achievements: null == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<AchievementId>,
  ));
}

}


/// Adds pattern-matching-related methods to [SearchResults].
extension SearchResultsPatterns on SearchResults {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SearchResults value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SearchResults() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SearchResults value)  $default,){
final _that = this;
switch (_that) {
case _SearchResults():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SearchResults value)?  $default,){
final _that = this;
switch (_that) {
case _SearchResults() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Habit> habits,  List<Routine> routines,  List<Goal> goals,  List<AchievementId> achievements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SearchResults() when $default != null:
return $default(_that.habits,_that.routines,_that.goals,_that.achievements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Habit> habits,  List<Routine> routines,  List<Goal> goals,  List<AchievementId> achievements)  $default,) {final _that = this;
switch (_that) {
case _SearchResults():
return $default(_that.habits,_that.routines,_that.goals,_that.achievements);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Habit> habits,  List<Routine> routines,  List<Goal> goals,  List<AchievementId> achievements)?  $default,) {final _that = this;
switch (_that) {
case _SearchResults() when $default != null:
return $default(_that.habits,_that.routines,_that.goals,_that.achievements);case _:
  return null;

}
}

}

/// @nodoc


class _SearchResults extends SearchResults {
  const _SearchResults({ List<Habit> habits = const <Habit>[],  List<Routine> routines = const <Routine>[],  List<Goal> goals = const <Goal>[],  List<AchievementId> achievements = const <AchievementId>[]}): _habits = habits,_routines = routines,_goals = goals,_achievements = achievements,super._();
  

 final  List<Habit> _habits;
@override@JsonKey() List<Habit> get habits {
  if (_habits is EqualUnmodifiableListView) return _habits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_habits);
}

 final  List<Routine> _routines;
@override@JsonKey() List<Routine> get routines {
  if (_routines is EqualUnmodifiableListView) return _routines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_routines);
}

 final  List<Goal> _goals;
@override@JsonKey() List<Goal> get goals {
  if (_goals is EqualUnmodifiableListView) return _goals;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_goals);
}

 final  List<AchievementId> _achievements;
@override@JsonKey() List<AchievementId> get achievements {
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_achievements);
}


/// Create a copy of SearchResults
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SearchResultsCopyWith<_SearchResults> get copyWith => __$SearchResultsCopyWithImpl<_SearchResults>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _SearchResults&&const DeepCollectionEquality().equals(other.habits, _habits)&&const DeepCollectionEquality().equals(other.routines, _routines)&&const DeepCollectionEquality().equals(other.goals, _goals)&&const DeepCollectionEquality().equals(other.achievements, _achievements));
}


@override
int get hashCode {
    return Object.hash(runtimeType,const DeepCollectionEquality().hash(_habits),const DeepCollectionEquality().hash(_routines),const DeepCollectionEquality().hash(_goals),const DeepCollectionEquality().hash(_achievements));
}

@override
String toString() {
    return 'SearchResults(habits: $habits, routines: $routines, goals: $goals, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class _$SearchResultsCopyWith<$Res> implements $SearchResultsCopyWith<$Res> {
  factory _$SearchResultsCopyWith(_SearchResults value, $Res Function(_SearchResults) _then) = __$SearchResultsCopyWithImpl;
@override @useResult
$Res call({
 List<Habit> habits, List<Routine> routines, List<Goal> goals, List<AchievementId> achievements
});




}
/// @nodoc
class __$SearchResultsCopyWithImpl<$Res>
    implements _$SearchResultsCopyWith<$Res> {
  __$SearchResultsCopyWithImpl(this._self, this._then);

  final _SearchResults _self;
  final $Res Function(_SearchResults) _then;

/// Create a copy of SearchResults
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? habits = null,Object? routines = null,Object? goals = null,Object? achievements = null,}) {
  return _then(_SearchResults(
habits: null == habits ? _self._habits : habits // ignore: cast_nullable_to_non_nullable
as List<Habit>,routines: null == routines ? _self._routines : routines // ignore: cast_nullable_to_non_nullable
as List<Routine>,goals: null == goals ? _self._goals : goals // ignore: cast_nullable_to_non_nullable
as List<Goal>,achievements: null == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<AchievementId>,
  ));
}


}

// dart format on
