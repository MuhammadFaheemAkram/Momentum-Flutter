// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AchievementProgress {

 int get current; int get target; AchievementMeasure get measure;
/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementProgressCopyWith<AchievementProgress> get copyWith => _$AchievementProgressCopyWithImpl<AchievementProgress>(this as AchievementProgress, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AchievementProgress;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementProgress&&(identical(other.current, _this.current) || other.current == _this.current)&&(identical(other.target, _this.target) || other.target == _this.target)&&(identical(other.measure, _this.measure) || other.measure == _this.measure));
}


@override
int get hashCode {
  final _this = this as AchievementProgress;
  return Object.hash(runtimeType,_this.current,_this.target,_this.measure);
}

@override
String toString() {
  final _this = this as AchievementProgress;
  return 'AchievementProgress(current: ${_this.current}, target: ${_this.target}, measure: ${_this.measure})';
}


}

/// @nodoc
abstract mixin class $AchievementProgressCopyWith<$Res>  {
  factory $AchievementProgressCopyWith(AchievementProgress value, $Res Function(AchievementProgress) _then) = _$AchievementProgressCopyWithImpl;
@useResult
$Res call({
 int current, int target, AchievementMeasure measure
});




}
/// @nodoc
class _$AchievementProgressCopyWithImpl<$Res>
    implements $AchievementProgressCopyWith<$Res> {
  _$AchievementProgressCopyWithImpl(this._self, this._then);

  final AchievementProgress _self;
  final $Res Function(AchievementProgress) _then;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? current = null,Object? target = null,Object? measure = null,}) {
  return _then(AchievementProgress(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,measure: null == measure ? _self.measure : measure // ignore: cast_nullable_to_non_nullable
as AchievementMeasure,
  ));
}

}


/// Adds pattern-matching-related methods to [AchievementProgress].
extension AchievementProgressPatterns on AchievementProgress {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementProgress value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementProgress value)  $default,){
final _that = this;
switch (_that) {
case _AchievementProgress():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementProgress value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int current,  int target,  AchievementMeasure measure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
return $default(_that.current,_that.target,_that.measure);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int current,  int target,  AchievementMeasure measure)  $default,) {final _that = this;
switch (_that) {
case _AchievementProgress():
return $default(_that.current,_that.target,_that.measure);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int current,  int target,  AchievementMeasure measure)?  $default,) {final _that = this;
switch (_that) {
case _AchievementProgress() when $default != null:
return $default(_that.current,_that.target,_that.measure);case _:
  return null;

}
}

}

/// @nodoc


class _AchievementProgress extends AchievementProgress {
  const _AchievementProgress({required this.current, required this.target, required this.measure}): super._();
  

@override final  int current;
@override final  int target;
@override final  AchievementMeasure measure;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementProgressCopyWith<_AchievementProgress> get copyWith => __$AchievementProgressCopyWithImpl<_AchievementProgress>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementProgress&&(identical(other.current, current) || other.current == current)&&(identical(other.target, target) || other.target == target)&&(identical(other.measure, measure) || other.measure == measure));
}


@override
int get hashCode {
    return Object.hash(runtimeType,current,target,measure);
}

@override
String toString() {
    return 'AchievementProgress(current: $current, target: $target, measure: $measure)';
}


}

/// @nodoc
abstract mixin class _$AchievementProgressCopyWith<$Res> implements $AchievementProgressCopyWith<$Res> {
  factory _$AchievementProgressCopyWith(_AchievementProgress value, $Res Function(_AchievementProgress) _then) = __$AchievementProgressCopyWithImpl;
@override @useResult
$Res call({
 int current, int target, AchievementMeasure measure
});




}
/// @nodoc
class __$AchievementProgressCopyWithImpl<$Res>
    implements _$AchievementProgressCopyWith<$Res> {
  __$AchievementProgressCopyWithImpl(this._self, this._then);

  final _AchievementProgress _self;
  final $Res Function(_AchievementProgress) _then;

/// Create a copy of AchievementProgress
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? current = null,Object? target = null,Object? measure = null,}) {
  return _then(_AchievementProgress(
current: null == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as int,target: null == target ? _self.target : target // ignore: cast_nullable_to_non_nullable
as int,measure: null == measure ? _self.measure : measure // ignore: cast_nullable_to_non_nullable
as AchievementMeasure,
  ));
}


}

/// @nodoc
mixin _$AchievementStatus {

 AchievementId get id; AchievementProgress get progress; AchievementUnlock? get unlock;
/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AchievementStatusCopyWith<AchievementStatus> get copyWith => _$AchievementStatusCopyWithImpl<AchievementStatus>(this as AchievementStatus, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AchievementStatus;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AchievementStatus&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.progress, _this.progress) || other.progress == _this.progress)&&(identical(other.unlock, _this.unlock) || other.unlock == _this.unlock));
}


@override
int get hashCode {
  final _this = this as AchievementStatus;
  return Object.hash(runtimeType,_this.id,_this.progress,_this.unlock);
}

@override
String toString() {
  final _this = this as AchievementStatus;
  return 'AchievementStatus(id: ${_this.id}, progress: ${_this.progress}, unlock: ${_this.unlock})';
}


}

/// @nodoc
abstract mixin class $AchievementStatusCopyWith<$Res>  {
  factory $AchievementStatusCopyWith(AchievementStatus value, $Res Function(AchievementStatus) _then) = _$AchievementStatusCopyWithImpl;
@useResult
$Res call({
 AchievementId id, AchievementProgress progress, AchievementUnlock? unlock
});


$AchievementProgressCopyWith<$Res> get progress;$AchievementUnlockCopyWith<$Res>? get unlock;

}
/// @nodoc
class _$AchievementStatusCopyWithImpl<$Res>
    implements $AchievementStatusCopyWith<$Res> {
  _$AchievementStatusCopyWithImpl(this._self, this._then);

  final AchievementStatus _self;
  final $Res Function(AchievementStatus) _then;

/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? progress = null,Object? unlock = freezed,}) {
  return _then(AchievementStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as AchievementId,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as AchievementProgress,unlock: freezed == unlock ? _self.unlock : unlock // ignore: cast_nullable_to_non_nullable
as AchievementUnlock?,
  ));
}
/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AchievementProgressCopyWith<$Res> get progress {
  
  return $AchievementProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AchievementUnlockCopyWith<$Res>? get unlock {
    if (_self.unlock == null) {
    return null;
  }

  return $AchievementUnlockCopyWith<$Res>(_self.unlock!, (value) {
    return _then(_self.copyWith(unlock: value));
  });
}
}


/// Adds pattern-matching-related methods to [AchievementStatus].
extension AchievementStatusPatterns on AchievementStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AchievementStatus value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AchievementStatus() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AchievementStatus value)  $default,){
final _that = this;
switch (_that) {
case _AchievementStatus():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AchievementStatus value)?  $default,){
final _that = this;
switch (_that) {
case _AchievementStatus() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( AchievementId id,  AchievementProgress progress,  AchievementUnlock? unlock)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AchievementStatus() when $default != null:
return $default(_that.id,_that.progress,_that.unlock);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( AchievementId id,  AchievementProgress progress,  AchievementUnlock? unlock)  $default,) {final _that = this;
switch (_that) {
case _AchievementStatus():
return $default(_that.id,_that.progress,_that.unlock);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( AchievementId id,  AchievementProgress progress,  AchievementUnlock? unlock)?  $default,) {final _that = this;
switch (_that) {
case _AchievementStatus() when $default != null:
return $default(_that.id,_that.progress,_that.unlock);case _:
  return null;

}
}

}

/// @nodoc


class _AchievementStatus extends AchievementStatus {
  const _AchievementStatus({required this.id, required this.progress, this.unlock}): super._();
  

@override final  AchievementId id;
@override final  AchievementProgress progress;
@override final  AchievementUnlock? unlock;

/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AchievementStatusCopyWith<_AchievementStatus> get copyWith => __$AchievementStatusCopyWithImpl<_AchievementStatus>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AchievementStatus&&(identical(other.id, id) || other.id == id)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.unlock, unlock) || other.unlock == unlock));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,progress,unlock);
}

@override
String toString() {
    return 'AchievementStatus(id: $id, progress: $progress, unlock: $unlock)';
}


}

/// @nodoc
abstract mixin class _$AchievementStatusCopyWith<$Res> implements $AchievementStatusCopyWith<$Res> {
  factory _$AchievementStatusCopyWith(_AchievementStatus value, $Res Function(_AchievementStatus) _then) = __$AchievementStatusCopyWithImpl;
@override @useResult
$Res call({
 AchievementId id, AchievementProgress progress, AchievementUnlock? unlock
});


@override $AchievementProgressCopyWith<$Res> get progress;@override $AchievementUnlockCopyWith<$Res>? get unlock;

}
/// @nodoc
class __$AchievementStatusCopyWithImpl<$Res>
    implements _$AchievementStatusCopyWith<$Res> {
  __$AchievementStatusCopyWithImpl(this._self, this._then);

  final _AchievementStatus _self;
  final $Res Function(_AchievementStatus) _then;

/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? progress = null,Object? unlock = freezed,}) {
  return _then(_AchievementStatus(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as AchievementId,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as AchievementProgress,unlock: freezed == unlock ? _self.unlock : unlock // ignore: cast_nullable_to_non_nullable
as AchievementUnlock?,
  ));
}

/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AchievementProgressCopyWith<$Res> get progress {
  
  return $AchievementProgressCopyWith<$Res>(_self.progress, (value) {
    return _then(_self.copyWith(progress: value));
  });
}/// Create a copy of AchievementStatus
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AchievementUnlockCopyWith<$Res>? get unlock {
    if (_self.unlock == null) {
    return null;
  }

  return $AchievementUnlockCopyWith<$Res>(_self.unlock!, (value) {
    return _then(_self.copyWith(unlock: value));
  });
}
}

// dart format on
