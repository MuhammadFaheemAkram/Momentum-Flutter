// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'analytics.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PeriodCount {

 CalendarDate get start; int get count;
/// Create a copy of PeriodCount
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PeriodCountCopyWith<PeriodCount> get copyWith => _$PeriodCountCopyWithImpl<PeriodCount>(this as PeriodCount, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as PeriodCount;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PeriodCount&&(identical(other.start, _this.start) || other.start == _this.start)&&(identical(other.count, _this.count) || other.count == _this.count));
}


@override
int get hashCode {
  final _this = this as PeriodCount;
  return Object.hash(runtimeType,_this.start,_this.count);
}

@override
String toString() {
  final _this = this as PeriodCount;
  return 'PeriodCount(start: ${_this.start}, count: ${_this.count})';
}


}

/// @nodoc
abstract mixin class $PeriodCountCopyWith<$Res>  {
  factory $PeriodCountCopyWith(PeriodCount value, $Res Function(PeriodCount) _then) = _$PeriodCountCopyWithImpl;
@useResult
$Res call({
 CalendarDate start, int count
});




}
/// @nodoc
class _$PeriodCountCopyWithImpl<$Res>
    implements $PeriodCountCopyWith<$Res> {
  _$PeriodCountCopyWithImpl(this._self, this._then);

  final PeriodCount _self;
  final $Res Function(PeriodCount) _then;

/// Create a copy of PeriodCount
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? start = null,Object? count = null,}) {
  return _then(PeriodCount(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as CalendarDate,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PeriodCount].
extension PeriodCountPatterns on PeriodCount {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PeriodCount value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PeriodCount() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PeriodCount value)  $default,){
final _that = this;
switch (_that) {
case _PeriodCount():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PeriodCount value)?  $default,){
final _that = this;
switch (_that) {
case _PeriodCount() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarDate start,  int count)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PeriodCount() when $default != null:
return $default(_that.start,_that.count);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarDate start,  int count)  $default,) {final _that = this;
switch (_that) {
case _PeriodCount():
return $default(_that.start,_that.count);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarDate start,  int count)?  $default,) {final _that = this;
switch (_that) {
case _PeriodCount() when $default != null:
return $default(_that.start,_that.count);case _:
  return null;

}
}

}

/// @nodoc


class _PeriodCount implements PeriodCount {
  const _PeriodCount({required this.start, required this.count});
  

@override final  CalendarDate start;
@override final  int count;

/// Create a copy of PeriodCount
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PeriodCountCopyWith<_PeriodCount> get copyWith => __$PeriodCountCopyWithImpl<_PeriodCount>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _PeriodCount&&(identical(other.start, start) || other.start == start)&&(identical(other.count, count) || other.count == count));
}


@override
int get hashCode {
    return Object.hash(runtimeType,start,count);
}

@override
String toString() {
    return 'PeriodCount(start: $start, count: $count)';
}


}

/// @nodoc
abstract mixin class _$PeriodCountCopyWith<$Res> implements $PeriodCountCopyWith<$Res> {
  factory _$PeriodCountCopyWith(_PeriodCount value, $Res Function(_PeriodCount) _then) = __$PeriodCountCopyWithImpl;
@override @useResult
$Res call({
 CalendarDate start, int count
});




}
/// @nodoc
class __$PeriodCountCopyWithImpl<$Res>
    implements _$PeriodCountCopyWith<$Res> {
  __$PeriodCountCopyWithImpl(this._self, this._then);

  final _PeriodCount _self;
  final $Res Function(_PeriodCount) _then;

/// Create a copy of PeriodCount
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? start = null,Object? count = null,}) {
  return _then(_PeriodCount(
start: null == start ? _self.start : start // ignore: cast_nullable_to_non_nullable
as CalendarDate,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$HabitStreakEntry {

 Habit get habit; HabitStreak get streak;
/// Create a copy of HabitStreakEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitStreakEntryCopyWith<HabitStreakEntry> get copyWith => _$HabitStreakEntryCopyWithImpl<HabitStreakEntry>(this as HabitStreakEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitStreakEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitStreakEntry&&(identical(other.habit, _this.habit) || other.habit == _this.habit)&&(identical(other.streak, _this.streak) || other.streak == _this.streak));
}


@override
int get hashCode {
  final _this = this as HabitStreakEntry;
  return Object.hash(runtimeType,_this.habit,_this.streak);
}

@override
String toString() {
  final _this = this as HabitStreakEntry;
  return 'HabitStreakEntry(habit: ${_this.habit}, streak: ${_this.streak})';
}


}

/// @nodoc
abstract mixin class $HabitStreakEntryCopyWith<$Res>  {
  factory $HabitStreakEntryCopyWith(HabitStreakEntry value, $Res Function(HabitStreakEntry) _then) = _$HabitStreakEntryCopyWithImpl;
@useResult
$Res call({
 Habit habit, HabitStreak streak
});


$HabitCopyWith<$Res> get habit;

}
/// @nodoc
class _$HabitStreakEntryCopyWithImpl<$Res>
    implements $HabitStreakEntryCopyWith<$Res> {
  _$HabitStreakEntryCopyWithImpl(this._self, this._then);

  final HabitStreakEntry _self;
  final $Res Function(HabitStreakEntry) _then;

/// Create a copy of HabitStreakEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? habit = null,Object? streak = null,}) {
  return _then(HabitStreakEntry(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as HabitStreak,
  ));
}
/// Create a copy of HabitStreakEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}


/// Adds pattern-matching-related methods to [HabitStreakEntry].
extension HabitStreakEntryPatterns on HabitStreakEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitStreakEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitStreakEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitStreakEntry value)  $default,){
final _that = this;
switch (_that) {
case _HabitStreakEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitStreakEntry value)?  $default,){
final _that = this;
switch (_that) {
case _HabitStreakEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Habit habit,  HabitStreak streak)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitStreakEntry() when $default != null:
return $default(_that.habit,_that.streak);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Habit habit,  HabitStreak streak)  $default,) {final _that = this;
switch (_that) {
case _HabitStreakEntry():
return $default(_that.habit,_that.streak);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Habit habit,  HabitStreak streak)?  $default,) {final _that = this;
switch (_that) {
case _HabitStreakEntry() when $default != null:
return $default(_that.habit,_that.streak);case _:
  return null;

}
}

}

/// @nodoc


class _HabitStreakEntry implements HabitStreakEntry {
  const _HabitStreakEntry({required this.habit, required this.streak});
  

@override final  Habit habit;
@override final  HabitStreak streak;

/// Create a copy of HabitStreakEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitStreakEntryCopyWith<_HabitStreakEntry> get copyWith => __$HabitStreakEntryCopyWithImpl<_HabitStreakEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitStreakEntry&&(identical(other.habit, habit) || other.habit == habit)&&(identical(other.streak, streak) || other.streak == streak));
}


@override
int get hashCode {
    return Object.hash(runtimeType,habit,streak);
}

@override
String toString() {
    return 'HabitStreakEntry(habit: $habit, streak: $streak)';
}


}

/// @nodoc
abstract mixin class _$HabitStreakEntryCopyWith<$Res> implements $HabitStreakEntryCopyWith<$Res> {
  factory _$HabitStreakEntryCopyWith(_HabitStreakEntry value, $Res Function(_HabitStreakEntry) _then) = __$HabitStreakEntryCopyWithImpl;
@override @useResult
$Res call({
 Habit habit, HabitStreak streak
});


@override $HabitCopyWith<$Res> get habit;

}
/// @nodoc
class __$HabitStreakEntryCopyWithImpl<$Res>
    implements _$HabitStreakEntryCopyWith<$Res> {
  __$HabitStreakEntryCopyWithImpl(this._self, this._then);

  final _HabitStreakEntry _self;
  final $Res Function(_HabitStreakEntry) _then;

/// Create a copy of HabitStreakEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? habit = null,Object? streak = null,}) {
  return _then(_HabitStreakEntry(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,streak: null == streak ? _self.streak : streak // ignore: cast_nullable_to_non_nullable
as HabitStreak,
  ));
}

/// Create a copy of HabitStreakEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}

/// @nodoc
mixin _$HabitRateEntry {

 Habit get habit; CompletionRate get rate;
/// Create a copy of HabitRateEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitRateEntryCopyWith<HabitRateEntry> get copyWith => _$HabitRateEntryCopyWithImpl<HabitRateEntry>(this as HabitRateEntry, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitRateEntry;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitRateEntry&&(identical(other.habit, _this.habit) || other.habit == _this.habit)&&(identical(other.rate, _this.rate) || other.rate == _this.rate));
}


@override
int get hashCode {
  final _this = this as HabitRateEntry;
  return Object.hash(runtimeType,_this.habit,_this.rate);
}

@override
String toString() {
  final _this = this as HabitRateEntry;
  return 'HabitRateEntry(habit: ${_this.habit}, rate: ${_this.rate})';
}


}

/// @nodoc
abstract mixin class $HabitRateEntryCopyWith<$Res>  {
  factory $HabitRateEntryCopyWith(HabitRateEntry value, $Res Function(HabitRateEntry) _then) = _$HabitRateEntryCopyWithImpl;
@useResult
$Res call({
 Habit habit, CompletionRate rate
});


$HabitCopyWith<$Res> get habit;

}
/// @nodoc
class _$HabitRateEntryCopyWithImpl<$Res>
    implements $HabitRateEntryCopyWith<$Res> {
  _$HabitRateEntryCopyWithImpl(this._self, this._then);

  final HabitRateEntry _self;
  final $Res Function(HabitRateEntry) _then;

/// Create a copy of HabitRateEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? habit = null,Object? rate = null,}) {
  return _then(HabitRateEntry(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as CompletionRate,
  ));
}
/// Create a copy of HabitRateEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}


/// Adds pattern-matching-related methods to [HabitRateEntry].
extension HabitRateEntryPatterns on HabitRateEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitRateEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitRateEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitRateEntry value)  $default,){
final _that = this;
switch (_that) {
case _HabitRateEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitRateEntry value)?  $default,){
final _that = this;
switch (_that) {
case _HabitRateEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Habit habit,  CompletionRate rate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitRateEntry() when $default != null:
return $default(_that.habit,_that.rate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Habit habit,  CompletionRate rate)  $default,) {final _that = this;
switch (_that) {
case _HabitRateEntry():
return $default(_that.habit,_that.rate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Habit habit,  CompletionRate rate)?  $default,) {final _that = this;
switch (_that) {
case _HabitRateEntry() when $default != null:
return $default(_that.habit,_that.rate);case _:
  return null;

}
}

}

/// @nodoc


class _HabitRateEntry implements HabitRateEntry {
  const _HabitRateEntry({required this.habit, required this.rate});
  

@override final  Habit habit;
@override final  CompletionRate rate;

/// Create a copy of HabitRateEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitRateEntryCopyWith<_HabitRateEntry> get copyWith => __$HabitRateEntryCopyWithImpl<_HabitRateEntry>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitRateEntry&&(identical(other.habit, habit) || other.habit == habit)&&(identical(other.rate, rate) || other.rate == rate));
}


@override
int get hashCode {
    return Object.hash(runtimeType,habit,rate);
}

@override
String toString() {
    return 'HabitRateEntry(habit: $habit, rate: $rate)';
}


}

/// @nodoc
abstract mixin class _$HabitRateEntryCopyWith<$Res> implements $HabitRateEntryCopyWith<$Res> {
  factory _$HabitRateEntryCopyWith(_HabitRateEntry value, $Res Function(_HabitRateEntry) _then) = __$HabitRateEntryCopyWithImpl;
@override @useResult
$Res call({
 Habit habit, CompletionRate rate
});


@override $HabitCopyWith<$Res> get habit;

}
/// @nodoc
class __$HabitRateEntryCopyWithImpl<$Res>
    implements _$HabitRateEntryCopyWith<$Res> {
  __$HabitRateEntryCopyWithImpl(this._self, this._then);

  final _HabitRateEntry _self;
  final $Res Function(_HabitRateEntry) _then;

/// Create a copy of HabitRateEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? habit = null,Object? rate = null,}) {
  return _then(_HabitRateEntry(
habit: null == habit ? _self.habit : habit // ignore: cast_nullable_to_non_nullable
as Habit,rate: null == rate ? _self.rate : rate // ignore: cast_nullable_to_non_nullable
as CompletionRate,
  ));
}

/// Create a copy of HabitRateEntry
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitCopyWith<$Res> get habit {
  
  return $HabitCopyWith<$Res>(_self.habit, (value) {
    return _then(_self.copyWith(habit: value));
  });
}
}

/// @nodoc
mixin _$CategoryShare {

 HabitCategory get category; int get count; int get total;
/// Create a copy of CategoryShare
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CategoryShareCopyWith<CategoryShare> get copyWith => _$CategoryShareCopyWithImpl<CategoryShare>(this as CategoryShare, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as CategoryShare;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CategoryShare&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.count, _this.count) || other.count == _this.count)&&(identical(other.total, _this.total) || other.total == _this.total));
}


@override
int get hashCode {
  final _this = this as CategoryShare;
  return Object.hash(runtimeType,_this.category,_this.count,_this.total);
}

@override
String toString() {
  final _this = this as CategoryShare;
  return 'CategoryShare(category: ${_this.category}, count: ${_this.count}, total: ${_this.total})';
}


}

/// @nodoc
abstract mixin class $CategoryShareCopyWith<$Res>  {
  factory $CategoryShareCopyWith(CategoryShare value, $Res Function(CategoryShare) _then) = _$CategoryShareCopyWithImpl;
@useResult
$Res call({
 HabitCategory category, int count, int total
});




}
/// @nodoc
class _$CategoryShareCopyWithImpl<$Res>
    implements $CategoryShareCopyWith<$Res> {
  _$CategoryShareCopyWithImpl(this._self, this._then);

  final CategoryShare _self;
  final $Res Function(CategoryShare) _then;

/// Create a copy of CategoryShare
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? count = null,Object? total = null,}) {
  return _then(CategoryShare(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [CategoryShare].
extension CategorySharePatterns on CategoryShare {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CategoryShare value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CategoryShare() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CategoryShare value)  $default,){
final _that = this;
switch (_that) {
case _CategoryShare():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CategoryShare value)?  $default,){
final _that = this;
switch (_that) {
case _CategoryShare() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HabitCategory category,  int count,  int total)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CategoryShare() when $default != null:
return $default(_that.category,_that.count,_that.total);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HabitCategory category,  int count,  int total)  $default,) {final _that = this;
switch (_that) {
case _CategoryShare():
return $default(_that.category,_that.count,_that.total);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HabitCategory category,  int count,  int total)?  $default,) {final _that = this;
switch (_that) {
case _CategoryShare() when $default != null:
return $default(_that.category,_that.count,_that.total);case _:
  return null;

}
}

}

/// @nodoc


class _CategoryShare extends CategoryShare {
  const _CategoryShare({required this.category, required this.count, required this.total}): super._();
  

@override final  HabitCategory category;
@override final  int count;
@override final  int total;

/// Create a copy of CategoryShare
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CategoryShareCopyWith<_CategoryShare> get copyWith => __$CategoryShareCopyWithImpl<_CategoryShare>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _CategoryShare&&(identical(other.category, category) || other.category == category)&&(identical(other.count, count) || other.count == count)&&(identical(other.total, total) || other.total == total));
}


@override
int get hashCode {
    return Object.hash(runtimeType,category,count,total);
}

@override
String toString() {
    return 'CategoryShare(category: $category, count: $count, total: $total)';
}


}

/// @nodoc
abstract mixin class _$CategoryShareCopyWith<$Res> implements $CategoryShareCopyWith<$Res> {
  factory _$CategoryShareCopyWith(_CategoryShare value, $Res Function(_CategoryShare) _then) = __$CategoryShareCopyWithImpl;
@override @useResult
$Res call({
 HabitCategory category, int count, int total
});




}
/// @nodoc
class __$CategoryShareCopyWithImpl<$Res>
    implements _$CategoryShareCopyWith<$Res> {
  __$CategoryShareCopyWithImpl(this._self, this._then);

  final _CategoryShare _self;
  final $Res Function(_CategoryShare) _then;

/// Create a copy of CategoryShare
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? count = null,Object? total = null,}) {
  return _then(_CategoryShare(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$AnalyticsOverview {

 CalendarDate get today;/// The last 30 days.
 CompletionRate get rate30;/// 0–100, or null with too little history.
 int? get consistencyScore;/// The active habit with the longest current streak.
 HabitStreakEntry? get bestStreak; int get totalCompletions; int get perfectDaysThisMonth;/// The last 8 ISO weeks, oldest first.
 List<PeriodCount> get weekly;/// The last 6 months, oldest first.
 List<PeriodCount> get monthly;/// Each habit's longest run, longest first.
 List<HabitStreakEntry> get longestStreaks;/// The best completion rate since its start (with enough history).
 HabitRateEntry? get mostSuccessful;/// All-time done days by category, most first.
 List<CategoryShare> get categories;
/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AnalyticsOverviewCopyWith<AnalyticsOverview> get copyWith => _$AnalyticsOverviewCopyWithImpl<AnalyticsOverview>(this as AnalyticsOverview, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AnalyticsOverview;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AnalyticsOverview&&(identical(other.today, _this.today) || other.today == _this.today)&&(identical(other.rate30, _this.rate30) || other.rate30 == _this.rate30)&&(identical(other.consistencyScore, _this.consistencyScore) || other.consistencyScore == _this.consistencyScore)&&(identical(other.bestStreak, _this.bestStreak) || other.bestStreak == _this.bestStreak)&&(identical(other.totalCompletions, _this.totalCompletions) || other.totalCompletions == _this.totalCompletions)&&(identical(other.perfectDaysThisMonth, _this.perfectDaysThisMonth) || other.perfectDaysThisMonth == _this.perfectDaysThisMonth)&&const DeepCollectionEquality().equals(other.weekly, _this.weekly)&&const DeepCollectionEquality().equals(other.monthly, _this.monthly)&&const DeepCollectionEquality().equals(other.longestStreaks, _this.longestStreaks)&&(identical(other.mostSuccessful, _this.mostSuccessful) || other.mostSuccessful == _this.mostSuccessful)&&const DeepCollectionEquality().equals(other.categories, _this.categories));
}


@override
int get hashCode {
  final _this = this as AnalyticsOverview;
  return Object.hash(runtimeType,_this.today,_this.rate30,_this.consistencyScore,_this.bestStreak,_this.totalCompletions,_this.perfectDaysThisMonth,const DeepCollectionEquality().hash(_this.weekly),const DeepCollectionEquality().hash(_this.monthly),const DeepCollectionEquality().hash(_this.longestStreaks),_this.mostSuccessful,const DeepCollectionEquality().hash(_this.categories));
}

@override
String toString() {
  final _this = this as AnalyticsOverview;
  return 'AnalyticsOverview(today: ${_this.today}, rate30: ${_this.rate30}, consistencyScore: ${_this.consistencyScore}, bestStreak: ${_this.bestStreak}, totalCompletions: ${_this.totalCompletions}, perfectDaysThisMonth: ${_this.perfectDaysThisMonth}, weekly: ${_this.weekly}, monthly: ${_this.monthly}, longestStreaks: ${_this.longestStreaks}, mostSuccessful: ${_this.mostSuccessful}, categories: ${_this.categories})';
}


}

/// @nodoc
abstract mixin class $AnalyticsOverviewCopyWith<$Res>  {
  factory $AnalyticsOverviewCopyWith(AnalyticsOverview value, $Res Function(AnalyticsOverview) _then) = _$AnalyticsOverviewCopyWithImpl;
@useResult
$Res call({
 CalendarDate today, CompletionRate rate30, int? consistencyScore, HabitStreakEntry? bestStreak, int totalCompletions, int perfectDaysThisMonth, List<PeriodCount> weekly, List<PeriodCount> monthly, List<HabitStreakEntry> longestStreaks, HabitRateEntry? mostSuccessful, List<CategoryShare> categories
});


$HabitStreakEntryCopyWith<$Res>? get bestStreak;$HabitRateEntryCopyWith<$Res>? get mostSuccessful;

}
/// @nodoc
class _$AnalyticsOverviewCopyWithImpl<$Res>
    implements $AnalyticsOverviewCopyWith<$Res> {
  _$AnalyticsOverviewCopyWithImpl(this._self, this._then);

  final AnalyticsOverview _self;
  final $Res Function(AnalyticsOverview) _then;

/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? today = null,Object? rate30 = null,Object? consistencyScore = freezed,Object? bestStreak = freezed,Object? totalCompletions = null,Object? perfectDaysThisMonth = null,Object? weekly = null,Object? monthly = null,Object? longestStreaks = null,Object? mostSuccessful = freezed,Object? categories = null,}) {
  return _then(AnalyticsOverview(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,rate30: null == rate30 ? _self.rate30 : rate30 // ignore: cast_nullable_to_non_nullable
as CompletionRate,consistencyScore: freezed == consistencyScore ? _self.consistencyScore : consistencyScore // ignore: cast_nullable_to_non_nullable
as int?,bestStreak: freezed == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as HabitStreakEntry?,totalCompletions: null == totalCompletions ? _self.totalCompletions : totalCompletions // ignore: cast_nullable_to_non_nullable
as int,perfectDaysThisMonth: null == perfectDaysThisMonth ? _self.perfectDaysThisMonth : perfectDaysThisMonth // ignore: cast_nullable_to_non_nullable
as int,weekly: null == weekly ? _self.weekly : weekly // ignore: cast_nullable_to_non_nullable
as List<PeriodCount>,monthly: null == monthly ? _self.monthly : monthly // ignore: cast_nullable_to_non_nullable
as List<PeriodCount>,longestStreaks: null == longestStreaks ? _self.longestStreaks : longestStreaks // ignore: cast_nullable_to_non_nullable
as List<HabitStreakEntry>,mostSuccessful: freezed == mostSuccessful ? _self.mostSuccessful : mostSuccessful // ignore: cast_nullable_to_non_nullable
as HabitRateEntry?,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryShare>,
  ));
}
/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitStreakEntryCopyWith<$Res>? get bestStreak {
    if (_self.bestStreak == null) {
    return null;
  }

  return $HabitStreakEntryCopyWith<$Res>(_self.bestStreak!, (value) {
    return _then(_self.copyWith(bestStreak: value));
  });
}/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitRateEntryCopyWith<$Res>? get mostSuccessful {
    if (_self.mostSuccessful == null) {
    return null;
  }

  return $HabitRateEntryCopyWith<$Res>(_self.mostSuccessful!, (value) {
    return _then(_self.copyWith(mostSuccessful: value));
  });
}
}


/// Adds pattern-matching-related methods to [AnalyticsOverview].
extension AnalyticsOverviewPatterns on AnalyticsOverview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AnalyticsOverview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AnalyticsOverview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AnalyticsOverview value)  $default,){
final _that = this;
switch (_that) {
case _AnalyticsOverview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AnalyticsOverview value)?  $default,){
final _that = this;
switch (_that) {
case _AnalyticsOverview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( CalendarDate today,  CompletionRate rate30,  int? consistencyScore,  HabitStreakEntry? bestStreak,  int totalCompletions,  int perfectDaysThisMonth,  List<PeriodCount> weekly,  List<PeriodCount> monthly,  List<HabitStreakEntry> longestStreaks,  HabitRateEntry? mostSuccessful,  List<CategoryShare> categories)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AnalyticsOverview() when $default != null:
return $default(_that.today,_that.rate30,_that.consistencyScore,_that.bestStreak,_that.totalCompletions,_that.perfectDaysThisMonth,_that.weekly,_that.monthly,_that.longestStreaks,_that.mostSuccessful,_that.categories);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( CalendarDate today,  CompletionRate rate30,  int? consistencyScore,  HabitStreakEntry? bestStreak,  int totalCompletions,  int perfectDaysThisMonth,  List<PeriodCount> weekly,  List<PeriodCount> monthly,  List<HabitStreakEntry> longestStreaks,  HabitRateEntry? mostSuccessful,  List<CategoryShare> categories)  $default,) {final _that = this;
switch (_that) {
case _AnalyticsOverview():
return $default(_that.today,_that.rate30,_that.consistencyScore,_that.bestStreak,_that.totalCompletions,_that.perfectDaysThisMonth,_that.weekly,_that.monthly,_that.longestStreaks,_that.mostSuccessful,_that.categories);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( CalendarDate today,  CompletionRate rate30,  int? consistencyScore,  HabitStreakEntry? bestStreak,  int totalCompletions,  int perfectDaysThisMonth,  List<PeriodCount> weekly,  List<PeriodCount> monthly,  List<HabitStreakEntry> longestStreaks,  HabitRateEntry? mostSuccessful,  List<CategoryShare> categories)?  $default,) {final _that = this;
switch (_that) {
case _AnalyticsOverview() when $default != null:
return $default(_that.today,_that.rate30,_that.consistencyScore,_that.bestStreak,_that.totalCompletions,_that.perfectDaysThisMonth,_that.weekly,_that.monthly,_that.longestStreaks,_that.mostSuccessful,_that.categories);case _:
  return null;

}
}

}

/// @nodoc


class _AnalyticsOverview extends AnalyticsOverview {
  const _AnalyticsOverview({required this.today, required this.rate30, this.consistencyScore, this.bestStreak, required this.totalCompletions, required this.perfectDaysThisMonth, required  List<PeriodCount> weekly, required  List<PeriodCount> monthly, required  List<HabitStreakEntry> longestStreaks, this.mostSuccessful, required  List<CategoryShare> categories}): _weekly = weekly,_monthly = monthly,_longestStreaks = longestStreaks,_categories = categories,super._();
  

@override final  CalendarDate today;
/// The last 30 days.
@override final  CompletionRate rate30;
/// 0–100, or null with too little history.
@override final  int? consistencyScore;
/// The active habit with the longest current streak.
@override final  HabitStreakEntry? bestStreak;
@override final  int totalCompletions;
@override final  int perfectDaysThisMonth;
/// The last 8 ISO weeks, oldest first.
 final  List<PeriodCount> _weekly;
/// The last 8 ISO weeks, oldest first.
@override List<PeriodCount> get weekly {
  if (_weekly is EqualUnmodifiableListView) return _weekly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weekly);
}

/// The last 6 months, oldest first.
 final  List<PeriodCount> _monthly;
/// The last 6 months, oldest first.
@override List<PeriodCount> get monthly {
  if (_monthly is EqualUnmodifiableListView) return _monthly;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_monthly);
}

/// Each habit's longest run, longest first.
 final  List<HabitStreakEntry> _longestStreaks;
/// Each habit's longest run, longest first.
@override List<HabitStreakEntry> get longestStreaks {
  if (_longestStreaks is EqualUnmodifiableListView) return _longestStreaks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_longestStreaks);
}

/// The best completion rate since its start (with enough history).
@override final  HabitRateEntry? mostSuccessful;
/// All-time done days by category, most first.
 final  List<CategoryShare> _categories;
/// All-time done days by category, most first.
@override List<CategoryShare> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}


/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AnalyticsOverviewCopyWith<_AnalyticsOverview> get copyWith => __$AnalyticsOverviewCopyWithImpl<_AnalyticsOverview>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AnalyticsOverview&&(identical(other.today, today) || other.today == today)&&(identical(other.rate30, rate30) || other.rate30 == rate30)&&(identical(other.consistencyScore, consistencyScore) || other.consistencyScore == consistencyScore)&&(identical(other.bestStreak, bestStreak) || other.bestStreak == bestStreak)&&(identical(other.totalCompletions, totalCompletions) || other.totalCompletions == totalCompletions)&&(identical(other.perfectDaysThisMonth, perfectDaysThisMonth) || other.perfectDaysThisMonth == perfectDaysThisMonth)&&const DeepCollectionEquality().equals(other.weekly, _weekly)&&const DeepCollectionEquality().equals(other.monthly, _monthly)&&const DeepCollectionEquality().equals(other.longestStreaks, _longestStreaks)&&(identical(other.mostSuccessful, mostSuccessful) || other.mostSuccessful == mostSuccessful)&&const DeepCollectionEquality().equals(other.categories, _categories));
}


@override
int get hashCode {
    return Object.hash(runtimeType,today,rate30,consistencyScore,bestStreak,totalCompletions,perfectDaysThisMonth,const DeepCollectionEquality().hash(_weekly),const DeepCollectionEquality().hash(_monthly),const DeepCollectionEquality().hash(_longestStreaks),mostSuccessful,const DeepCollectionEquality().hash(_categories));
}

@override
String toString() {
    return 'AnalyticsOverview(today: $today, rate30: $rate30, consistencyScore: $consistencyScore, bestStreak: $bestStreak, totalCompletions: $totalCompletions, perfectDaysThisMonth: $perfectDaysThisMonth, weekly: $weekly, monthly: $monthly, longestStreaks: $longestStreaks, mostSuccessful: $mostSuccessful, categories: $categories)';
}


}

/// @nodoc
abstract mixin class _$AnalyticsOverviewCopyWith<$Res> implements $AnalyticsOverviewCopyWith<$Res> {
  factory _$AnalyticsOverviewCopyWith(_AnalyticsOverview value, $Res Function(_AnalyticsOverview) _then) = __$AnalyticsOverviewCopyWithImpl;
@override @useResult
$Res call({
 CalendarDate today, CompletionRate rate30, int? consistencyScore, HabitStreakEntry? bestStreak, int totalCompletions, int perfectDaysThisMonth, List<PeriodCount> weekly, List<PeriodCount> monthly, List<HabitStreakEntry> longestStreaks, HabitRateEntry? mostSuccessful, List<CategoryShare> categories
});


@override $HabitStreakEntryCopyWith<$Res>? get bestStreak;@override $HabitRateEntryCopyWith<$Res>? get mostSuccessful;

}
/// @nodoc
class __$AnalyticsOverviewCopyWithImpl<$Res>
    implements _$AnalyticsOverviewCopyWith<$Res> {
  __$AnalyticsOverviewCopyWithImpl(this._self, this._then);

  final _AnalyticsOverview _self;
  final $Res Function(_AnalyticsOverview) _then;

/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? today = null,Object? rate30 = null,Object? consistencyScore = freezed,Object? bestStreak = freezed,Object? totalCompletions = null,Object? perfectDaysThisMonth = null,Object? weekly = null,Object? monthly = null,Object? longestStreaks = null,Object? mostSuccessful = freezed,Object? categories = null,}) {
  return _then(_AnalyticsOverview(
today: null == today ? _self.today : today // ignore: cast_nullable_to_non_nullable
as CalendarDate,rate30: null == rate30 ? _self.rate30 : rate30 // ignore: cast_nullable_to_non_nullable
as CompletionRate,consistencyScore: freezed == consistencyScore ? _self.consistencyScore : consistencyScore // ignore: cast_nullable_to_non_nullable
as int?,bestStreak: freezed == bestStreak ? _self.bestStreak : bestStreak // ignore: cast_nullable_to_non_nullable
as HabitStreakEntry?,totalCompletions: null == totalCompletions ? _self.totalCompletions : totalCompletions // ignore: cast_nullable_to_non_nullable
as int,perfectDaysThisMonth: null == perfectDaysThisMonth ? _self.perfectDaysThisMonth : perfectDaysThisMonth // ignore: cast_nullable_to_non_nullable
as int,weekly: null == weekly ? _self._weekly : weekly // ignore: cast_nullable_to_non_nullable
as List<PeriodCount>,monthly: null == monthly ? _self._monthly : monthly // ignore: cast_nullable_to_non_nullable
as List<PeriodCount>,longestStreaks: null == longestStreaks ? _self._longestStreaks : longestStreaks // ignore: cast_nullable_to_non_nullable
as List<HabitStreakEntry>,mostSuccessful: freezed == mostSuccessful ? _self.mostSuccessful : mostSuccessful // ignore: cast_nullable_to_non_nullable
as HabitRateEntry?,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<CategoryShare>,
  ));
}

/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitStreakEntryCopyWith<$Res>? get bestStreak {
    if (_self.bestStreak == null) {
    return null;
  }

  return $HabitStreakEntryCopyWith<$Res>(_self.bestStreak!, (value) {
    return _then(_self.copyWith(bestStreak: value));
  });
}/// Create a copy of AnalyticsOverview
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitRateEntryCopyWith<$Res>? get mostSuccessful {
    if (_self.mostSuccessful == null) {
    return null;
  }

  return $HabitRateEntryCopyWith<$Res>(_self.mostSuccessful!, (value) {
    return _then(_self.copyWith(mostSuccessful: value));
  });
}
}

// dart format on
