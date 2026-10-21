// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backup.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$BackupReceipt {

 DateTime get receivedAt; int get habits; int get logs;
/// Create a copy of BackupReceipt
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BackupReceiptCopyWith<BackupReceipt> get copyWith => _$BackupReceiptCopyWithImpl<BackupReceipt>(this as BackupReceipt, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as BackupReceipt;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BackupReceipt&&(identical(other.receivedAt, _this.receivedAt) || other.receivedAt == _this.receivedAt)&&(identical(other.habits, _this.habits) || other.habits == _this.habits)&&(identical(other.logs, _this.logs) || other.logs == _this.logs));
}


@override
int get hashCode {
  final _this = this as BackupReceipt;
  return Object.hash(runtimeType,_this.receivedAt,_this.habits,_this.logs);
}

@override
String toString() {
  final _this = this as BackupReceipt;
  return 'BackupReceipt(receivedAt: ${_this.receivedAt}, habits: ${_this.habits}, logs: ${_this.logs})';
}


}

/// @nodoc
abstract mixin class $BackupReceiptCopyWith<$Res>  {
  factory $BackupReceiptCopyWith(BackupReceipt value, $Res Function(BackupReceipt) _then) = _$BackupReceiptCopyWithImpl;
@useResult
$Res call({
 DateTime receivedAt, int habits, int logs
});




}
/// @nodoc
class _$BackupReceiptCopyWithImpl<$Res>
    implements $BackupReceiptCopyWith<$Res> {
  _$BackupReceiptCopyWithImpl(this._self, this._then);

  final BackupReceipt _self;
  final $Res Function(BackupReceipt) _then;

/// Create a copy of BackupReceipt
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? receivedAt = null,Object? habits = null,Object? logs = null,}) {
  return _then(BackupReceipt(
receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,habits: null == habits ? _self.habits : habits // ignore: cast_nullable_to_non_nullable
as int,logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [BackupReceipt].
extension BackupReceiptPatterns on BackupReceipt {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BackupReceipt value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BackupReceipt() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BackupReceipt value)  $default,){
final _that = this;
switch (_that) {
case _BackupReceipt():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BackupReceipt value)?  $default,){
final _that = this;
switch (_that) {
case _BackupReceipt() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime receivedAt,  int habits,  int logs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BackupReceipt() when $default != null:
return $default(_that.receivedAt,_that.habits,_that.logs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime receivedAt,  int habits,  int logs)  $default,) {final _that = this;
switch (_that) {
case _BackupReceipt():
return $default(_that.receivedAt,_that.habits,_that.logs);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime receivedAt,  int habits,  int logs)?  $default,) {final _that = this;
switch (_that) {
case _BackupReceipt() when $default != null:
return $default(_that.receivedAt,_that.habits,_that.logs);case _:
  return null;

}
}

}

/// @nodoc


class _BackupReceipt implements BackupReceipt {
  const _BackupReceipt({required this.receivedAt, required this.habits, required this.logs});
  

@override final  DateTime receivedAt;
@override final  int habits;
@override final  int logs;

/// Create a copy of BackupReceipt
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BackupReceiptCopyWith<_BackupReceipt> get copyWith => __$BackupReceiptCopyWithImpl<_BackupReceipt>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _BackupReceipt&&(identical(other.receivedAt, receivedAt) || other.receivedAt == receivedAt)&&(identical(other.habits, habits) || other.habits == habits)&&(identical(other.logs, logs) || other.logs == logs));
}


@override
int get hashCode {
    return Object.hash(runtimeType,receivedAt,habits,logs);
}

@override
String toString() {
    return 'BackupReceipt(receivedAt: $receivedAt, habits: $habits, logs: $logs)';
}


}

/// @nodoc
abstract mixin class _$BackupReceiptCopyWith<$Res> implements $BackupReceiptCopyWith<$Res> {
  factory _$BackupReceiptCopyWith(_BackupReceipt value, $Res Function(_BackupReceipt) _then) = __$BackupReceiptCopyWithImpl;
@override @useResult
$Res call({
 DateTime receivedAt, int habits, int logs
});




}
/// @nodoc
class __$BackupReceiptCopyWithImpl<$Res>
    implements _$BackupReceiptCopyWith<$Res> {
  __$BackupReceiptCopyWithImpl(this._self, this._then);

  final _BackupReceipt _self;
  final $Res Function(_BackupReceipt) _then;

/// Create a copy of BackupReceipt
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? receivedAt = null,Object? habits = null,Object? logs = null,}) {
  return _then(_BackupReceipt(
receivedAt: null == receivedAt ? _self.receivedAt : receivedAt // ignore: cast_nullable_to_non_nullable
as DateTime,habits: null == habits ? _self.habits : habits // ignore: cast_nullable_to_non_nullable
as int,logs: null == logs ? _self.logs : logs // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
