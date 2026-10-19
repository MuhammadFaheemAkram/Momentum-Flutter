// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine_editor_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RoutineEditorState {

 RoutineEditorStatus get status;/// What the routine was when opened, to tell whether anything changed.
 RoutineDraft? get original; RoutineDraft? get draft;/// Errors show under the fields only after a first Save.
 bool get showErrors; bool get saving; RoutineEditorExit? get exit; String? get errorMessage; int get errorSerial;
/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineEditorStateCopyWith<RoutineEditorState> get copyWith => _$RoutineEditorStateCopyWithImpl<RoutineEditorState>(this as RoutineEditorState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineEditorState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineEditorState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.draft, _this.draft) || other.draft == _this.draft)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.exit, _this.exit) || other.exit == _this.exit)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.errorSerial, _this.errorSerial) || other.errorSerial == _this.errorSerial));
}


@override
int get hashCode {
  final _this = this as RoutineEditorState;
  return Object.hash(runtimeType,_this.status,_this.original,_this.draft,_this.showErrors,_this.saving,_this.exit,_this.errorMessage,_this.errorSerial);
}

@override
String toString() {
  final _this = this as RoutineEditorState;
  return 'RoutineEditorState(status: ${_this.status}, original: ${_this.original}, draft: ${_this.draft}, showErrors: ${_this.showErrors}, saving: ${_this.saving}, exit: ${_this.exit}, errorMessage: ${_this.errorMessage}, errorSerial: ${_this.errorSerial})';
}


}

/// @nodoc
abstract mixin class $RoutineEditorStateCopyWith<$Res>  {
  factory $RoutineEditorStateCopyWith(RoutineEditorState value, $Res Function(RoutineEditorState) _then) = _$RoutineEditorStateCopyWithImpl;
@useResult
$Res call({
 RoutineEditorStatus status, RoutineDraft? original, RoutineDraft? draft, bool showErrors, bool saving, RoutineEditorExit? exit, String? errorMessage, int errorSerial
});


$RoutineDraftCopyWith<$Res>? get original;$RoutineDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class _$RoutineEditorStateCopyWithImpl<$Res>
    implements $RoutineEditorStateCopyWith<$Res> {
  _$RoutineEditorStateCopyWithImpl(this._self, this._then);

  final RoutineEditorState _self;
  final $Res Function(RoutineEditorState) _then;

/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? draft = freezed,Object? showErrors = null,Object? saving = null,Object? exit = freezed,Object? errorMessage = freezed,Object? errorSerial = null,}) {
  return _then(RoutineEditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoutineEditorStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as RoutineDraft?,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as RoutineDraft?,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,exit: freezed == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as RoutineEditorExit?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorSerial: null == errorSerial ? _self.errorSerial : errorSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineDraftCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $RoutineDraftCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $RoutineDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}


/// Adds pattern-matching-related methods to [RoutineEditorState].
extension RoutineEditorStatePatterns on RoutineEditorState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineEditorState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineEditorState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineEditorState value)  $default,){
final _that = this;
switch (_that) {
case _RoutineEditorState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineEditorState value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineEditorState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RoutineEditorStatus status,  RoutineDraft? original,  RoutineDraft? draft,  bool showErrors,  bool saving,  RoutineEditorExit? exit,  String? errorMessage,  int errorSerial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineEditorState() when $default != null:
return $default(_that.status,_that.original,_that.draft,_that.showErrors,_that.saving,_that.exit,_that.errorMessage,_that.errorSerial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RoutineEditorStatus status,  RoutineDraft? original,  RoutineDraft? draft,  bool showErrors,  bool saving,  RoutineEditorExit? exit,  String? errorMessage,  int errorSerial)  $default,) {final _that = this;
switch (_that) {
case _RoutineEditorState():
return $default(_that.status,_that.original,_that.draft,_that.showErrors,_that.saving,_that.exit,_that.errorMessage,_that.errorSerial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RoutineEditorStatus status,  RoutineDraft? original,  RoutineDraft? draft,  bool showErrors,  bool saving,  RoutineEditorExit? exit,  String? errorMessage,  int errorSerial)?  $default,) {final _that = this;
switch (_that) {
case _RoutineEditorState() when $default != null:
return $default(_that.status,_that.original,_that.draft,_that.showErrors,_that.saving,_that.exit,_that.errorMessage,_that.errorSerial);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineEditorState extends RoutineEditorState {
  const _RoutineEditorState({this.status = RoutineEditorStatus.loading, this.original, this.draft, this.showErrors = false, this.saving = false, this.exit, this.errorMessage, this.errorSerial = 0}): super._();
  

@override@JsonKey() final  RoutineEditorStatus status;
/// What the routine was when opened, to tell whether anything changed.
@override final  RoutineDraft? original;
@override final  RoutineDraft? draft;
/// Errors show under the fields only after a first Save.
@override@JsonKey() final  bool showErrors;
@override@JsonKey() final  bool saving;
@override final  RoutineEditorExit? exit;
@override final  String? errorMessage;
@override@JsonKey() final  int errorSerial;

/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineEditorStateCopyWith<_RoutineEditorState> get copyWith => __$RoutineEditorStateCopyWithImpl<_RoutineEditorState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineEditorState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorSerial, errorSerial) || other.errorSerial == errorSerial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,original,draft,showErrors,saving,exit,errorMessage,errorSerial);
}

@override
String toString() {
    return 'RoutineEditorState(status: $status, original: $original, draft: $draft, showErrors: $showErrors, saving: $saving, exit: $exit, errorMessage: $errorMessage, errorSerial: $errorSerial)';
}


}

/// @nodoc
abstract mixin class _$RoutineEditorStateCopyWith<$Res> implements $RoutineEditorStateCopyWith<$Res> {
  factory _$RoutineEditorStateCopyWith(_RoutineEditorState value, $Res Function(_RoutineEditorState) _then) = __$RoutineEditorStateCopyWithImpl;
@override @useResult
$Res call({
 RoutineEditorStatus status, RoutineDraft? original, RoutineDraft? draft, bool showErrors, bool saving, RoutineEditorExit? exit, String? errorMessage, int errorSerial
});


@override $RoutineDraftCopyWith<$Res>? get original;@override $RoutineDraftCopyWith<$Res>? get draft;

}
/// @nodoc
class __$RoutineEditorStateCopyWithImpl<$Res>
    implements _$RoutineEditorStateCopyWith<$Res> {
  __$RoutineEditorStateCopyWithImpl(this._self, this._then);

  final _RoutineEditorState _self;
  final $Res Function(_RoutineEditorState) _then;

/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? draft = freezed,Object? showErrors = null,Object? saving = null,Object? exit = freezed,Object? errorMessage = freezed,Object? errorSerial = null,}) {
  return _then(_RoutineEditorState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RoutineEditorStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as RoutineDraft?,draft: freezed == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as RoutineDraft?,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,exit: freezed == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as RoutineEditorExit?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorSerial: null == errorSerial ? _self.errorSerial : errorSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineDraftCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $RoutineDraftCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of RoutineEditorState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RoutineDraftCopyWith<$Res>? get draft {
    if (_self.draft == null) {
    return null;
  }

  return $RoutineDraftCopyWith<$Res>(_self.draft!, (value) {
    return _then(_self.copyWith(draft: value));
  });
}
}

// dart format on
