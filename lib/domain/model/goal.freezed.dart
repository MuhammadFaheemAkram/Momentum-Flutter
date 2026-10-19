// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'goal.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$GoalScope {





@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalScope);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GoalScope()';
}


}

/// @nodoc
class $GoalScopeCopyWith<$Res>  {
$GoalScopeCopyWith(GoalScope _, $Res Function(GoalScope) __);
}


/// Adds pattern-matching-related methods to [GoalScope].
extension GoalScopePatterns on GoalScope {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( AllHabits value)?  allHabits,TResult Function( OneHabit value)?  habit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case AllHabits() when allHabits != null:
return allHabits(_that);case OneHabit() when habit != null:
return habit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( AllHabits value)  allHabits,required TResult Function( OneHabit value)  habit,}){
final _that = this;
switch (_that) {
case AllHabits():
return allHabits(_that);case OneHabit():
return habit(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( AllHabits value)?  allHabits,TResult? Function( OneHabit value)?  habit,}){
final _that = this;
switch (_that) {
case AllHabits() when allHabits != null:
return allHabits(_that);case OneHabit() when habit != null:
return habit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  allHabits,TResult Function( String habitId)?  habit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case AllHabits() when allHabits != null:
return allHabits();case OneHabit() when habit != null:
return habit(_that.habitId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  allHabits,required TResult Function( String habitId)  habit,}) {final _that = this;
switch (_that) {
case AllHabits():
return allHabits();case OneHabit():
return habit(_that.habitId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  allHabits,TResult? Function( String habitId)?  habit,}) {final _that = this;
switch (_that) {
case AllHabits() when allHabits != null:
return allHabits();case OneHabit() when habit != null:
return habit(_that.habitId);case _:
  return null;

}
}

}

/// @nodoc


class AllHabits implements GoalScope {
  const AllHabits();
  






@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is AllHabits);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
    return 'GoalScope.allHabits()';
}


}




/// @nodoc


class OneHabit implements GoalScope {
  const OneHabit(this.habitId);
  

 final  String habitId;

/// Create a copy of GoalScope
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OneHabitCopyWith<OneHabit> get copyWith => _$OneHabitCopyWithImpl<OneHabit>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is OneHabit&&(identical(other.habitId, habitId) || other.habitId == habitId));
}


@override
int get hashCode {
    return Object.hash(runtimeType,habitId);
}

@override
String toString() {
    return 'GoalScope.habit(habitId: $habitId)';
}


}

/// @nodoc
abstract mixin class $OneHabitCopyWith<$Res> implements $GoalScopeCopyWith<$Res> {
  factory $OneHabitCopyWith(OneHabit value, $Res Function(OneHabit) _then) = _$OneHabitCopyWithImpl;
@useResult
$Res call({
 String habitId
});




}
/// @nodoc
class _$OneHabitCopyWithImpl<$Res>
    implements $OneHabitCopyWith<$Res> {
  _$OneHabitCopyWithImpl(this._self, this._then);

  final OneHabit _self;
  final $Res Function(OneHabit) _then;

/// Create a copy of GoalScope
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? habitId = null,}) {
  return _then(OneHabit(
null == habitId ? _self.habitId : habitId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$Goal {

 String get id; String get title; GoalScope get scope; GoalPeriod get period;/// 1–200.
 int get target; CalendarDate get createdOn; DateTime get createdAt;
/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalCopyWith<Goal> get copyWith => _$GoalCopyWithImpl<Goal>(this as Goal, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Goal;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Goal&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.scope, _this.scope) || other.scope == _this.scope)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.createdOn, _this.createdOn) || other.createdOn == _this.createdOn)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt));
}


@override
int get hashCode {
  final _this = this as Goal;
  return Object.hash(runtimeType,_this.id,_this.title,_this.scope,_this.period,_this.target,_this.createdOn,_this.createdAt);
}

@override
String toString() {
  final _this = this as Goal;
  return 'Goal(id: ${_this.id}, title: ${_this.title}, scope: ${_this.scope}, period: ${_this.period}, target: ${_this.target}, createdOn: ${_this.createdOn}, createdAt: ${_this.createdAt})';
}


}

/// @nodoc
abstract mixin class $GoalCopyWith<$Res>  {
  factory $GoalCopyWith(Goal value, $Res Function(Goal) _then) = _$GoalCopyWithImpl;
@useResult
$Res call({
 String id, String title, GoalScope scope, GoalPeriod period, int target, CalendarDate createdOn, DateTime createdAt
});


$GoalScopeCopyWith<$Res> get scope;

}
/// @nodoc
class _$GoalCopyWithImpl<$Res>
    implements $GoalCopyWith<$Res> {
  _$GoalCopyWithImpl(this._self, this._then);

  final Goal _self;
  final $Res Function(Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? scope = null,Object? period = null,Object? target = null,Object? createdOn = null,Object? createdAt = null,}) {
  return _then(Goal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as GoalScope,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,createdOn: null == createdOn ? _self.createdOn : createdOn // ignore: cast_nullable_to_non_nullable
as CalendarDate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}
/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalScopeCopyWith<$Res> get scope {
  
  return $GoalScopeCopyWith<$Res>(_self.scope, (value) {
    return _then(_self.copyWith(scope: value));
  });
}
}


/// Adds pattern-matching-related methods to [Goal].
extension GoalPatterns on Goal {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Goal value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Goal value)  $default,){
final _that = this;
switch (_that) {
case _Goal():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Goal value)?  $default,){
final _that = this;
switch (_that) {
case _Goal() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  GoalScope scope,  GoalPeriod period,  int target,  CalendarDate createdOn,  DateTime createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.title,_that.scope,_that.period,_that.target,_that.createdOn,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  GoalScope scope,  GoalPeriod period,  int target,  CalendarDate createdOn,  DateTime createdAt)  $default,) {final _that = this;
switch (_that) {
case _Goal():
return $default(_that.id,_that.title,_that.scope,_that.period,_that.target,_that.createdOn,_that.createdAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  GoalScope scope,  GoalPeriod period,  int target,  CalendarDate createdOn,  DateTime createdAt)?  $default,) {final _that = this;
switch (_that) {
case _Goal() when $default != null:
return $default(_that.id,_that.title,_that.scope,_that.period,_that.target,_that.createdOn,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _Goal implements Goal {
  const _Goal({required this.id, required this.title, required this.scope, required this.period, required this.target, required this.createdOn, required this.createdAt});
  

@override final  String id;
@override final  String title;
@override final  GoalScope scope;
@override final  GoalPeriod period;
/// 1–200.
@override final  int target;
@override final  CalendarDate createdOn;
@override final  DateTime createdAt;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalCopyWith<_Goal> get copyWith => __$GoalCopyWithImpl<_Goal>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Goal&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target)&&(identical(other.createdOn, createdOn) || other.createdOn == createdOn)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,scope,period,target,createdOn,createdAt);
}

@override
String toString() {
    return 'Goal(id: $id, title: $title, scope: $scope, period: $period, target: $target, createdOn: $createdOn, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$GoalCopyWith<$Res> implements $GoalCopyWith<$Res> {
  factory _$GoalCopyWith(_Goal value, $Res Function(_Goal) _then) = __$GoalCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, GoalScope scope, GoalPeriod period, int target, CalendarDate createdOn, DateTime createdAt
});


@override $GoalScopeCopyWith<$Res> get scope;

}
/// @nodoc
class __$GoalCopyWithImpl<$Res>
    implements _$GoalCopyWith<$Res> {
  __$GoalCopyWithImpl(this._self, this._then);

  final _Goal _self;
  final $Res Function(_Goal) _then;

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? scope = null,Object? period = null,Object? target = null,Object? createdOn = null,Object? createdAt = null,}) {
  return _then(_Goal(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as GoalScope,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,createdOn: null == createdOn ? _self.createdOn : createdOn // ignore: cast_nullable_to_non_nullable
as CalendarDate,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

/// Create a copy of Goal
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalScopeCopyWith<$Res> get scope {
  
  return $GoalScopeCopyWith<$Res>(_self.scope, (value) {
    return _then(_self.copyWith(scope: value));
  });
}
}

/// @nodoc
mixin _$GoalDraft {

 String get title; GoalScope get scope; GoalPeriod get period; int get target;
/// Create a copy of GoalDraft
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalDraftCopyWith<GoalDraft> get copyWith => _$GoalDraftCopyWithImpl<GoalDraft>(this as GoalDraft, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoalDraft;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalDraft&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.scope, _this.scope) || other.scope == _this.scope)&&(identical(other.period, _this.period) || other.period == _this.period)&&(identical(other.target, _this.target) || other.target == _this.target));
}


@override
int get hashCode {
  final _this = this as GoalDraft;
  return Object.hash(runtimeType,_this.title,_this.scope,_this.period,_this.target);
}

@override
String toString() {
  final _this = this as GoalDraft;
  return 'GoalDraft(title: ${_this.title}, scope: ${_this.scope}, period: ${_this.period}, target: ${_this.target})';
}


}

/// @nodoc
abstract mixin class $GoalDraftCopyWith<$Res>  {
  factory $GoalDraftCopyWith(GoalDraft value, $Res Function(GoalDraft) _then) = _$GoalDraftCopyWithImpl;
@useResult
$Res call({
 String title, GoalScope scope, GoalPeriod period, int target
});


$GoalScopeCopyWith<$Res> get scope;

}
/// @nodoc
class _$GoalDraftCopyWithImpl<$Res>
    implements $GoalDraftCopyWith<$Res> {
  _$GoalDraftCopyWithImpl(this._self, this._then);

  final GoalDraft _self;
  final $Res Function(GoalDraft) _then;

/// Create a copy of GoalDraft
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? scope = null,Object? period = null,Object? target = null,}) {
  return _then(GoalDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as GoalScope,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of GoalDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalScopeCopyWith<$Res> get scope {
  
  return $GoalScopeCopyWith<$Res>(_self.scope, (value) {
    return _then(_self.copyWith(scope: value));
  });
}
}


/// Adds pattern-matching-related methods to [GoalDraft].
extension GoalDraftPatterns on GoalDraft {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalDraft value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalDraft() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalDraft value)  $default,){
final _that = this;
switch (_that) {
case _GoalDraft():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalDraft value)?  $default,){
final _that = this;
switch (_that) {
case _GoalDraft() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  GoalScope scope,  GoalPeriod period,  int target)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalDraft() when $default != null:
return $default(_that.title,_that.scope,_that.period,_that.target);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  GoalScope scope,  GoalPeriod period,  int target)  $default,) {final _that = this;
switch (_that) {
case _GoalDraft():
return $default(_that.title,_that.scope,_that.period,_that.target);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  GoalScope scope,  GoalPeriod period,  int target)?  $default,) {final _that = this;
switch (_that) {
case _GoalDraft() when $default != null:
return $default(_that.title,_that.scope,_that.period,_that.target);case _:
  return null;

}
}

}

/// @nodoc


class _GoalDraft implements GoalDraft {
  const _GoalDraft({required this.title, required this.scope, required this.period, required this.target});
  

@override final  String title;
@override final  GoalScope scope;
@override final  GoalPeriod period;
@override final  int target;

/// Create a copy of GoalDraft
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalDraftCopyWith<_GoalDraft> get copyWith => __$GoalDraftCopyWithImpl<_GoalDraft>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalDraft&&(identical(other.title, title) || other.title == title)&&(identical(other.scope, scope) || other.scope == scope)&&(identical(other.period, period) || other.period == period)&&(identical(other.target, target) || other.target == target));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,scope,period,target);
}

@override
String toString() {
    return 'GoalDraft(title: $title, scope: $scope, period: $period, target: $target)';
}


}

/// @nodoc
abstract mixin class _$GoalDraftCopyWith<$Res> implements $GoalDraftCopyWith<$Res> {
  factory _$GoalDraftCopyWith(_GoalDraft value, $Res Function(_GoalDraft) _then) = __$GoalDraftCopyWithImpl;
@override @useResult
$Res call({
 String title, GoalScope scope, GoalPeriod period, int target
});


@override $GoalScopeCopyWith<$Res> get scope;

}
/// @nodoc
class __$GoalDraftCopyWithImpl<$Res>
    implements _$GoalDraftCopyWith<$Res> {
  __$GoalDraftCopyWithImpl(this._self, this._then);

  final _GoalDraft _self;
  final $Res Function(_GoalDraft) _then;

/// Create a copy of GoalDraft
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? scope = null,Object? period = null,Object? target = null,}) {
  return _then(_GoalDraft(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,scope: null == scope ? _self.scope : scope // ignore: cast_nullable_to_non_nullable
as GoalScope,period: null == period ? _self.period : period // ignore: cast_nullable_to_non_nullable
as GoalPeriod,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of GoalDraft
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalScopeCopyWith<$Res> get scope {
  
  return $GoalScopeCopyWith<$Res>(_self.scope, (value) {
    return _then(_self.copyWith(scope: value));
  });
}
}

/// @nodoc
mixin _$GoalWindow {

 CalendarDate get start; CalendarDate get end;
/// Create a copy of GoalWindow
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalWindowCopyWith<GoalWindow> get copyWith => _$GoalWindowCopyWithImpl<GoalWindow>(this as GoalWindow, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoalWindow;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalWindow&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.end, _this.end) || other.end == _this.end));
}


@override
int get hashCode {
  final _this = this as GoalWindow;
  return Object.hash(runtimeType,_this.start,_this.end);
}

@override
String toString() {
  final _this = this as GoalWindow;
  return 'GoalWindow(start: ${_this.start}, end: ${_this.end})';
}


}

/// @nodoc
abstract mixin class $GoalWindowCopyWith<$Res>  {
  factory $GoalWindowCopyWith(GoalWindow value, $Res Function(GoalWindow) _then) = _$GoalWindowCopyWithImpl;
@useResult
$Res call({
 CalendarDate start, CalendarDate end
});




}
/// @nodoc
class _$GoalWindowCopyWithImpl<$Res>
    implements $GoalWindowCopyWith<$Res> {
  _$GoalWindowCopyWithImpl(this._self, this._then);

  final GoalWindow _self;
  final $Res Function(GoalWindow) _then;

/// Create a copy of GoalWindow
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? end = null,}) {
  return _then(GoalWindow(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as CalendarDate,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as CalendarDate,
  ));
}

}


/// Adds pattern-matching-related methods to [GoalWindow].
extension GoalWindowPatterns on GoalWindow {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalWindow value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalWindow() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalWindow value)  $default,){
final _that = this;
switch (_that) {
case _GoalWindow():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalWindow value)?  $default,){
final _that = this;
switch (_that) {
case _GoalWindow() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarDate start,  CalendarDate end)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalWindow() when $default != null:
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarDate start,  CalendarDate end)  $default,) {final _that = this;
switch (_that) {
case _GoalWindow():
return $default(_that.start,_that.end);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarDate start,  CalendarDate end)?  $default,) {final _that = this;
switch (_that) {
case _GoalWindow() when $default != null:
return $default(_that.start,_that.end);case _:
  return null;

}
}

}

/// @nodoc


class _GoalWindow extends GoalWindow {
  const _GoalWindow({required this.start, required this.end}): super._();
  

@override final  CalendarDate start;
@override final  CalendarDate end;

/// Create a copy of GoalWindow
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalWindowCopyWith<_GoalWindow> get copyWith => __$GoalWindowCopyWithImpl<_GoalWindow>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalWindow&&(identical(other.start, start) || other.start == start)&&(identical(other.end, end) || other.end == end));
}


@override
int get hashCode {
    return Object.hash(runtimeType,start,end);
}

@override
String toString() {
    return 'GoalWindow(start: $start, end: $end)';
}


}

/// @nodoc
abstract mixin class _$GoalWindowCopyWith<$Res> implements $GoalWindowCopyWith<$Res> {
  factory _$GoalWindowCopyWith(_GoalWindow value, $Res Function(_GoalWindow) _then) = __$GoalWindowCopyWithImpl;
@override @useResult
$Res call({
 CalendarDate start, CalendarDate end
});




}
/// @nodoc
class __$GoalWindowCopyWithImpl<$Res>
    implements _$GoalWindowCopyWith<$Res> {
  __$GoalWindowCopyWithImpl(this._self, this._then);

  final _GoalWindow _self;
  final $Res Function(_GoalWindow) _then;

/// Create a copy of GoalWindow
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? end = null,}) {
  return _then(_GoalWindow(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as CalendarDate,end: null == end ? _self.end : end // ignore: cast_nullable_to_non_nullable
as CalendarDate,
  ));
}


}

/// @nodoc
mixin _$GoalProgress {

 Goal get goal; GoalWindow get window; int get current;/// The habit a one-habit goal counts (null for all habits).
 String? get habitTitle;
/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GoalProgressCopyWith<GoalProgress> get copyWith => _$GoalProgressCopyWithImpl<GoalProgress>(this as GoalProgress, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as GoalProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GoalProgress&&(identical(other.goal, _this.goal) || other.goal == _this.goal)&&(identical(other.window, _this.window) || other.window == _this.window)&&(identical(other.current, _this.current) || other.current == _this.current)&&(identical(other.habitTitle, _this.habitTitle) || other.habitTitle == _this.habitTitle));
}


@override
int get hashCode {
  final _this = this as GoalProgress;
  return Object.hash(runtimeType,_this.goal,_this.window,_this.current,_this.habitTitle);
}

@override
String toString() {
  final _this = this as GoalProgress;
  return 'GoalProgress(goal: ${_this.goal}, window: ${_this.window}, current: ${_this.current}, habitTitle: ${_this.habitTitle})';
}


}

/// @nodoc
abstract mixin class $GoalProgressCopyWith<$Res>  {
  factory $GoalProgressCopyWith(GoalProgress value, $Res Function(GoalProgress) _then) = _$GoalProgressCopyWithImpl;
@useResult
$Res call({
 Goal goal, GoalWindow window, int current, String? habitTitle
});


$GoalCopyWith<$Res> get goal;$GoalWindowCopyWith<$Res> get window;

}
/// @nodoc
class _$GoalProgressCopyWithImpl<$Res>
    implements $GoalProgressCopyWith<$Res> {
  _$GoalProgressCopyWithImpl(this._self, this._then);

  final GoalProgress _self;
  final $Res Function(GoalProgress) _then;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? goal = null,Object? window = null,Object? current = null,Object? habitTitle = freezed,}) {
  return _then(GoalProgress(
goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as Goal,window: null == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as GoalWindow,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,habitTitle: freezed == habitTitle ? _self.habitTitle : habitTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalCopyWith<$Res> get goal {
  
  return $GoalCopyWith<$Res>(_self.goal, (value) {
    return _then(_self.copyWith(goal: value));
  });
}/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalWindowCopyWith<$Res> get window {
  
  return $GoalWindowCopyWith<$Res>(_self.window, (value) {
    return _then(_self.copyWith(window: value));
  });
}
}


/// Adds pattern-matching-related methods to [GoalProgress].
extension GoalProgressPatterns on GoalProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _GoalProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _GoalProgress value)  $default,){
final _that = this;
switch (_that) {
case _GoalProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _GoalProgress value)?  $default,){
final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Goal goal,  GoalWindow window,  int current,  String? habitTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
return $default(_that.goal,_that.window,_that.current,_that.habitTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Goal goal,  GoalWindow window,  int current,  String? habitTitle)  $default,) {final _that = this;
switch (_that) {
case _GoalProgress():
return $default(_that.goal,_that.window,_that.current,_that.habitTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Goal goal,  GoalWindow window,  int current,  String? habitTitle)?  $default,) {final _that = this;
switch (_that) {
case _GoalProgress() when $default != null:
return $default(_that.goal,_that.window,_that.current,_that.habitTitle);case _:
  return null;

}
}

}

/// @nodoc


class _GoalProgress extends GoalProgress {
  const _GoalProgress({required this.goal, required this.window, required this.current, this.habitTitle}): super._();
  

@override final  Goal goal;
@override final  GoalWindow window;
@override final  int current;
/// The habit a one-habit goal counts (null for all habits).
@override final  String? habitTitle;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GoalProgressCopyWith<_GoalProgress> get copyWith => __$GoalProgressCopyWithImpl<_GoalProgress>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _GoalProgress&&(identical(other.goal, goal) || other.goal == goal)&&(identical(other.window, window) || other.window == window)&&(identical(other.current, current) || other.current == current)&&(identical(other.habitTitle, habitTitle) || other.habitTitle == habitTitle));
}


@override
int get hashCode {
    return Object.hash(runtimeType,goal,window,current,habitTitle);
}

@override
String toString() {
    return 'GoalProgress(goal: $goal, window: $window, current: $current, habitTitle: $habitTitle)';
}


}

/// @nodoc
abstract mixin class _$GoalProgressCopyWith<$Res> implements $GoalProgressCopyWith<$Res> {
  factory _$GoalProgressCopyWith(_GoalProgress value, $Res Function(_GoalProgress) _then) = __$GoalProgressCopyWithImpl;
@override @useResult
$Res call({
 Goal goal, GoalWindow window, int current, String? habitTitle
});


@override $GoalCopyWith<$Res> get goal;@override $GoalWindowCopyWith<$Res> get window;

}
/// @nodoc
class __$GoalProgressCopyWithImpl<$Res>
    implements _$GoalProgressCopyWith<$Res> {
  __$GoalProgressCopyWithImpl(this._self, this._then);

  final _GoalProgress _self;
  final $Res Function(_GoalProgress) _then;

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? goal = null,Object? window = null,Object? current = null,Object? habitTitle = freezed,}) {
  return _then(_GoalProgress(
goal: null == goal ? _self.goal : goal // ignore: cast_nullable_to_non_nullable
as Goal,window: null == window ? _self.window : window // ignore: cast_nullable_to_non_nullable
as GoalWindow,current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,habitTitle: freezed == habitTitle ? _self.habitTitle : habitTitle // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalCopyWith<$Res> get goal {
  
  return $GoalCopyWith<$Res>(_self.goal, (value) {
    return _then(_self.copyWith(goal: value));
  });
}/// Create a copy of GoalProgress
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$GoalWindowCopyWith<$Res> get window {
  
  return $GoalWindowCopyWith<$Res>(_self.window, (value) {
    return _then(_self.copyWith(window: value));
  });
}
}

// dart format on
