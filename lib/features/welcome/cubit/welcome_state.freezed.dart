// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'welcome_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WelcomeState {

/// The start in progress, if any: both buttons wait for it.
 StartChoice? get starting;/// Why the demo couldn't be loaded; the demo button then reads "Try
/// again".
 String? get errorMessage;
/// Create a copy of WelcomeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WelcomeStateCopyWith<WelcomeState> get copyWith => _$WelcomeStateCopyWithImpl<WelcomeState>(this as WelcomeState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as WelcomeState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WelcomeState&&(identical(other.starting, _this.starting) || other.starting == _this.starting)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage));
}


@override
int get hashCode {
  final _this = this as WelcomeState;
  return Object.hash(runtimeType,_this.starting,_this.errorMessage);
}

@override
String toString() {
  final _this = this as WelcomeState;
  return 'WelcomeState(starting: ${_this.starting}, errorMessage: ${_this.errorMessage})';
}


}

/// @nodoc
abstract mixin class $WelcomeStateCopyWith<$Res>  {
  factory $WelcomeStateCopyWith(WelcomeState value, $Res Function(WelcomeState) _then) = _$WelcomeStateCopyWithImpl;
@useResult
$Res call({
 StartChoice? starting, String? errorMessage
});




}
/// @nodoc
class _$WelcomeStateCopyWithImpl<$Res>
    implements $WelcomeStateCopyWith<$Res> {
  _$WelcomeStateCopyWithImpl(this._self, this._then);

  final WelcomeState _self;
  final $Res Function(WelcomeState) _then;

/// Create a copy of WelcomeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? starting = freezed,Object? errorMessage = freezed,}) {
  return _then(WelcomeState(
starting: freezed == starting ? _self.starting : starting // ignore: cast_nullable_to_non_nullable
as StartChoice?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WelcomeState].
extension WelcomeStatePatterns on WelcomeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WelcomeState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WelcomeState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WelcomeState value)  $default,){
final _that = this;
switch (_that) {
case _WelcomeState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WelcomeState value)?  $default,){
final _that = this;
switch (_that) {
case _WelcomeState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( StartChoice? starting,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WelcomeState() when $default != null:
return $default(_that.starting,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( StartChoice? starting,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _WelcomeState():
return $default(_that.starting,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( StartChoice? starting,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _WelcomeState() when $default != null:
return $default(_that.starting,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _WelcomeState extends WelcomeState {
  const _WelcomeState({this.starting, this.errorMessage}): super._();
  

/// The start in progress, if any: both buttons wait for it.
@override final  StartChoice? starting;
/// Why the demo couldn't be loaded; the demo button then reads "Try
/// again".
@override final  String? errorMessage;

/// Create a copy of WelcomeState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WelcomeStateCopyWith<_WelcomeState> get copyWith => __$WelcomeStateCopyWithImpl<_WelcomeState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _WelcomeState&&(identical(other.starting, starting) || other.starting == starting)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode {
    return Object.hash(runtimeType,starting,errorMessage);
}

@override
String toString() {
    return 'WelcomeState(starting: $starting, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$WelcomeStateCopyWith<$Res> implements $WelcomeStateCopyWith<$Res> {
  factory _$WelcomeStateCopyWith(_WelcomeState value, $Res Function(_WelcomeState) _then) = __$WelcomeStateCopyWithImpl;
@override @useResult
$Res call({
 StartChoice? starting, String? errorMessage
});




}
/// @nodoc
class __$WelcomeStateCopyWithImpl<$Res>
    implements _$WelcomeStateCopyWith<$Res> {
  __$WelcomeStateCopyWithImpl(this._self, this._then);

  final _WelcomeState _self;
  final $Res Function(_WelcomeState) _then;

/// Create a copy of WelcomeState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? starting = freezed,Object? errorMessage = freezed,}) {
  return _then(_WelcomeState(
starting: freezed == starting ? _self.starting : starting // ignore: cast_nullable_to_non_nullable
as StartChoice?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
