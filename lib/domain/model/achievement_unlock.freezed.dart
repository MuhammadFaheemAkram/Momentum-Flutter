// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_unlock.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AchievementUnlock {

 String get achievementId; CalendarDate get unlockedOn; DateTime get unlockedAt;
/// Create a copy of AchievementUnlock
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementUnlockCopyWith<AchievementUnlock> get copyWith => _$AchievementUnlockCopyWithImpl<AchievementUnlock>(this as AchievementUnlock, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AchievementUnlock;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementUnlock&&(identical(other.achievementId, _this.achievementId) || other.achievementId == _this.achievementId)&&(identical(other.unlockedOn, _this.unlockedOn) || other.unlockedOn == _this.unlockedOn)&&(identical(other.unlockedAt, _this.unlockedAt) || other.unlockedAt == _this.unlockedAt));
}


@override
int get hashCode {
  final _this = this as AchievementUnlock;
  return Object.hash(runtimeType,_this.achievementId,_this.unlockedOn,_this.unlockedAt);
}

@override
String toString() {
  final _this = this as AchievementUnlock;
  return 'AchievementUnlock(achievementId: ${_this.achievementId}, unlockedOn: ${_this.unlockedOn}, unlockedAt: ${_this.unlockedAt})';
}


}

/// @nodoc
abstract mixin class $AchievementUnlockCopyWith<$Res>  {
  factory $AchievementUnlockCopyWith(AchievementUnlock value, $Res Function(AchievementUnlock) _then) = _$AchievementUnlockCopyWithImpl;
@useResult
$Res call({
 String achievementId, CalendarDate unlockedOn, DateTime unlockedAt
});




}
/// @nodoc
class _$AchievementUnlockCopyWithImpl<$Res>
    implements $AchievementUnlockCopyWith<$Res> {
  _$AchievementUnlockCopyWithImpl(this._self, this._then);

  final AchievementUnlock _self;
  final $Res Function(AchievementUnlock) _then;

/// Create a copy of AchievementUnlock
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? achievementId = null,Object? unlockedOn = null,Object? unlockedAt = null,}) {
  return _then(AchievementUnlock(
achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,unlockedOn: null == unlockedOn ? _self.unlockedOn : unlockedOn // ignore: cast_nullable_to_non_nullable
as CalendarDate,unlockedAt: null == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementUnlock].
extension AchievementUnlockPatterns on AchievementUnlock {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementUnlock value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementUnlock() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementUnlock value)  $default,){
final _that = this;
switch (_that) {
case _AchievementUnlock():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementUnlock value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementUnlock() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String achievementId,  CalendarDate unlockedOn,  DateTime unlockedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementUnlock() when $default != null:
return $default(_that.achievementId,_that.unlockedOn,_that.unlockedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String achievementId,  CalendarDate unlockedOn,  DateTime unlockedAt)  $default,) {final _that = this;
switch (_that) {
case _AchievementUnlock():
return $default(_that.achievementId,_that.unlockedOn,_that.unlockedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String achievementId,  CalendarDate unlockedOn,  DateTime unlockedAt)?  $default,) {final _that = this;
switch (_that) {
case _AchievementUnlock() when $default != null:
return $default(_that.achievementId,_that.unlockedOn,_that.unlockedAt);case _:
  return null;

}
}

}

/// @nodoc


class _AchievementUnlock implements AchievementUnlock {
  const _AchievementUnlock({required this.achievementId, required this.unlockedOn, required this.unlockedAt});
  

@override final  String achievementId;
@override final  CalendarDate unlockedOn;
@override final  DateTime unlockedAt;

/// Create a copy of AchievementUnlock
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementUnlockCopyWith<_AchievementUnlock> get copyWith => __$AchievementUnlockCopyWithImpl<_AchievementUnlock>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementUnlock&&(identical(other.achievementId, achievementId) || other.achievementId == achievementId)&&(identical(other.unlockedOn, unlockedOn) || other.unlockedOn == unlockedOn)&&(identical(other.unlockedAt, unlockedAt) || other.unlockedAt == unlockedAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,achievementId,unlockedOn,unlockedAt);
}

@override
String toString() {
    return 'AchievementUnlock(achievementId: $achievementId, unlockedOn: $unlockedOn, unlockedAt: $unlockedAt)';
}


}

/// @nodoc
abstract mixin class _$AchievementUnlockCopyWith<$Res> implements $AchievementUnlockCopyWith<$Res> {
  factory _$AchievementUnlockCopyWith(_AchievementUnlock value, $Res Function(_AchievementUnlock) _then) = __$AchievementUnlockCopyWithImpl;
@override @useResult
$Res call({
 String achievementId, CalendarDate unlockedOn, DateTime unlockedAt
});




}
/// @nodoc
class __$AchievementUnlockCopyWithImpl<$Res>
    implements _$AchievementUnlockCopyWith<$Res> {
  __$AchievementUnlockCopyWithImpl(this._self, this._then);

  final _AchievementUnlock _self;
  final $Res Function(_AchievementUnlock) _then;

/// Create a copy of AchievementUnlock
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? achievementId = null,Object? unlockedOn = null,Object? unlockedAt = null,}) {
  return _then(_AchievementUnlock(
achievementId: null == achievementId ? _self.achievementId : achievementId // ignore: cast_nullable_to_non_nullable
as String,unlockedOn: null == unlockedOn ? _self.unlockedOn : unlockedOn // ignore: cast_nullable_to_non_nullable
as CalendarDate,unlockedAt: null == unlockedAt ? _self.unlockedAt : unlockedAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
