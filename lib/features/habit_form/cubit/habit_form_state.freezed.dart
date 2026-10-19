// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'habit_form_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HabitFormValues {

 String get title; String get description; HabitCategory get category; HabitColor get color; HabitIcon get icon; ScheduleKind get kind; Set<int> get weekdays; int get timesPerWeek; int get dailyTarget; CalendarDate get startDate; TimeOfDayValue? get reminder;
/// Create a copy of HabitFormValues
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitFormValuesCopyWith<HabitFormValues> get copyWith => _$HabitFormValuesCopyWithImpl<HabitFormValues>(this as HabitFormValues, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitFormValues;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitFormValues&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.description, _this.description) || other.description == _this.description)&&(identical(other.category, _this.category) || other.category == _this.category)&&(identical(other.color, _this.color) || other.color == _this.color)&&(identical(other.icon, _this.icon) || other.icon == _this.icon)&&(identical(other.kind, _this.kind) || other.kind == _this.kind)&&const DeepCollectionEquality().equals(other.weekdays, _this.weekdays)&&(identical(other.timesPerWeek, _this.timesPerWeek) || other.timesPerWeek == _this.timesPerWeek)&&(identical(other.dailyTarget, _this.dailyTarget) || other.dailyTarget == _this.dailyTarget)&&(identical(other.startDate, _this.startDate) || other.startDate == _this.startDate)&&(identical(other.reminder, _this.reminder) || other.reminder == _this.reminder));
}


@override
int get hashCode {
  final _this = this as HabitFormValues;
  return Object.hash(runtimeType,_this.title,_this.description,_this.category,_this.color,_this.icon,_this.kind,const DeepCollectionEquality().hash(_this.weekdays),_this.timesPerWeek,_this.dailyTarget,_this.startDate,_this.reminder);
}

@override
String toString() {
  final _this = this as HabitFormValues;
  return 'HabitFormValues(title: ${_this.title}, description: ${_this.description}, category: ${_this.category}, color: ${_this.color}, icon: ${_this.icon}, kind: ${_this.kind}, weekdays: ${_this.weekdays}, timesPerWeek: ${_this.timesPerWeek}, dailyTarget: ${_this.dailyTarget}, startDate: ${_this.startDate}, reminder: ${_this.reminder})';
}


}

/// @nodoc
abstract mixin class $HabitFormValuesCopyWith<$Res>  {
  factory $HabitFormValuesCopyWith(HabitFormValues value, $Res Function(HabitFormValues) _then) = _$HabitFormValuesCopyWithImpl;
@useResult
$Res call({
 String title, String description, HabitCategory category, HabitColor color, HabitIcon icon, ScheduleKind kind, Set<int> weekdays, int timesPerWeek, int dailyTarget, CalendarDate startDate, TimeOfDayValue? reminder
});




}
/// @nodoc
class _$HabitFormValuesCopyWithImpl<$Res>
    implements $HabitFormValuesCopyWith<$Res> {
  _$HabitFormValuesCopyWithImpl(this._self, this._then);

  final HabitFormValues _self;
  final $Res Function(HabitFormValues) _then;

/// Create a copy of HabitFormValues
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? description = null,Object? category = null,Object? color = null,Object? icon = null,Object? kind = null,Object? weekdays = null,Object? timesPerWeek = null,Object? dailyTarget = null,Object? startDate = null,Object? reminder = freezed,}) {
  return _then(HabitFormValues(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as HabitColor,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as HabitIcon,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ScheduleKind,weekdays: null == weekdays ? _self.weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as Set<int>,timesPerWeek: null == timesPerWeek ? _self.timesPerWeek : timesPerWeek // ignore: cast_nullable_to_non_nullable
as int,dailyTarget: null == dailyTarget ? _self.dailyTarget : dailyTarget // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as CalendarDate,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue?,
  ));
}

}


/// Adds pattern-matching-related methods to [HabitFormValues].
extension HabitFormValuesPatterns on HabitFormValues {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitFormValues value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitFormValues() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitFormValues value)  $default,){
final _that = this;
switch (_that) {
case _HabitFormValues():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitFormValues value)?  $default,){
final _that = this;
switch (_that) {
case _HabitFormValues() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  ScheduleKind kind,  Set<int> weekdays,  int timesPerWeek,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitFormValues() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.color,_that.icon,_that.kind,_that.weekdays,_that.timesPerWeek,_that.dailyTarget,_that.startDate,_that.reminder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  ScheduleKind kind,  Set<int> weekdays,  int timesPerWeek,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder)  $default,) {final _that = this;
switch (_that) {
case _HabitFormValues():
return $default(_that.title,_that.description,_that.category,_that.color,_that.icon,_that.kind,_that.weekdays,_that.timesPerWeek,_that.dailyTarget,_that.startDate,_that.reminder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String description,  HabitCategory category,  HabitColor color,  HabitIcon icon,  ScheduleKind kind,  Set<int> weekdays,  int timesPerWeek,  int dailyTarget,  CalendarDate startDate,  TimeOfDayValue? reminder)?  $default,) {final _that = this;
switch (_that) {
case _HabitFormValues() when $default != null:
return $default(_that.title,_that.description,_that.category,_that.color,_that.icon,_that.kind,_that.weekdays,_that.timesPerWeek,_that.dailyTarget,_that.startDate,_that.reminder);case _:
  return null;

}
}

}

/// @nodoc


class _HabitFormValues extends HabitFormValues {
  const _HabitFormValues({this.title = '', this.description = '', this.category = HabitCategory.health, this.color = HabitColor.green, this.icon = HabitIcon.heart, this.kind = ScheduleKind.daily,  Set<int> weekdays = const {1, 2, 3, 4, 5}, this.timesPerWeek = 3, this.dailyTarget = 1, required this.startDate, this.reminder}): _weekdays = weekdays,super._();
  

@override@JsonKey() final  String title;
@override@JsonKey() final  String description;
@override@JsonKey() final  HabitCategory category;
@override@JsonKey() final  HabitColor color;
@override@JsonKey() final  HabitIcon icon;
@override@JsonKey() final  ScheduleKind kind;
 final  Set<int> _weekdays;
@override@JsonKey() Set<int> get weekdays {
  if (_weekdays is EqualUnmodifiableSetView) return _weekdays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_weekdays);
}

@override@JsonKey() final  int timesPerWeek;
@override@JsonKey() final  int dailyTarget;
@override final  CalendarDate startDate;
@override final  TimeOfDayValue? reminder;

/// Create a copy of HabitFormValues
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitFormValuesCopyWith<_HabitFormValues> get copyWith => __$HabitFormValuesCopyWithImpl<_HabitFormValues>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitFormValues&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.category, category) || other.category == category)&&(identical(other.color, color) || other.color == color)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.kind, kind) || other.kind == kind)&&const DeepCollectionEquality().equals(other.weekdays, _weekdays)&&(identical(other.timesPerWeek, timesPerWeek) || other.timesPerWeek == timesPerWeek)&&(identical(other.dailyTarget, dailyTarget) || other.dailyTarget == dailyTarget)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.reminder, reminder) || other.reminder == reminder));
}


@override
int get hashCode {
    return Object.hash(runtimeType,title,description,category,color,icon,kind,const DeepCollectionEquality().hash(_weekdays),timesPerWeek,dailyTarget,startDate,reminder);
}

@override
String toString() {
    return 'HabitFormValues(title: $title, description: $description, category: $category, color: $color, icon: $icon, kind: $kind, weekdays: $weekdays, timesPerWeek: $timesPerWeek, dailyTarget: $dailyTarget, startDate: $startDate, reminder: $reminder)';
}


}

/// @nodoc
abstract mixin class _$HabitFormValuesCopyWith<$Res> implements $HabitFormValuesCopyWith<$Res> {
  factory _$HabitFormValuesCopyWith(_HabitFormValues value, $Res Function(_HabitFormValues) _then) = __$HabitFormValuesCopyWithImpl;
@override @useResult
$Res call({
 String title, String description, HabitCategory category, HabitColor color, HabitIcon icon, ScheduleKind kind, Set<int> weekdays, int timesPerWeek, int dailyTarget, CalendarDate startDate, TimeOfDayValue? reminder
});




}
/// @nodoc
class __$HabitFormValuesCopyWithImpl<$Res>
    implements _$HabitFormValuesCopyWith<$Res> {
  __$HabitFormValuesCopyWithImpl(this._self, this._then);

  final _HabitFormValues _self;
  final $Res Function(_HabitFormValues) _then;

/// Create a copy of HabitFormValues
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? description = null,Object? category = null,Object? color = null,Object? icon = null,Object? kind = null,Object? weekdays = null,Object? timesPerWeek = null,Object? dailyTarget = null,Object? startDate = null,Object? reminder = freezed,}) {
  return _then(_HabitFormValues(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as HabitCategory,color: null == color ? _self.color : color // ignore: cast_nullable_to_non_nullable
as HabitColor,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as HabitIcon,kind: null == kind ? _self.kind : kind // ignore: cast_nullable_to_non_nullable
as ScheduleKind,weekdays: null == weekdays ? _self._weekdays : weekdays // ignore: cast_nullable_to_non_nullable
as Set<int>,timesPerWeek: null == timesPerWeek ? _self.timesPerWeek : timesPerWeek // ignore: cast_nullable_to_non_nullable
as int,dailyTarget: null == dailyTarget ? _self.dailyTarget : dailyTarget // ignore: cast_nullable_to_non_nullable
as int,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as CalendarDate,reminder: freezed == reminder ? _self.reminder : reminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue?,
  ));
}


}

/// @nodoc
mixin _$HabitFormState {

 HabitFormStatus get status;/// What the habit was when opened (the defaults for a new one).
 HabitFormValues? get original; HabitFormValues? get values;/// Errors show under the fields only after a first Save.
 bool get showErrors; bool get saving; HabitFormExit? get exit; String? get errorMessage; int get errorSerial;
/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HabitFormStateCopyWith<HabitFormState> get copyWith => _$HabitFormStateCopyWithImpl<HabitFormState>(this as HabitFormState, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as HabitFormState;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HabitFormState&&(identical(other.status, _this.status) || other.status == _this.status)&&(identical(other.original, _this.original) || other.original == _this.original)&&(identical(other.values, _this.values) || other.values == _this.values)&&(identical(other.showErrors, _this.showErrors) || other.showErrors == _this.showErrors)&&(identical(other.saving, _this.saving) || other.saving == _this.saving)&&(identical(other.exit, _this.exit) || other.exit == _this.exit)&&(identical(other.errorMessage, _this.errorMessage) || other.errorMessage == _this.errorMessage)&&(identical(other.errorSerial, _this.errorSerial) || other.errorSerial == _this.errorSerial));
}


@override
int get hashCode {
  final _this = this as HabitFormState;
  return Object.hash(runtimeType,_this.status,_this.original,_this.values,_this.showErrors,_this.saving,_this.exit,_this.errorMessage,_this.errorSerial);
}

@override
String toString() {
  final _this = this as HabitFormState;
  return 'HabitFormState(status: ${_this.status}, original: ${_this.original}, values: ${_this.values}, showErrors: ${_this.showErrors}, saving: ${_this.saving}, exit: ${_this.exit}, errorMessage: ${_this.errorMessage}, errorSerial: ${_this.errorSerial})';
}


}

/// @nodoc
abstract mixin class $HabitFormStateCopyWith<$Res>  {
  factory $HabitFormStateCopyWith(HabitFormState value, $Res Function(HabitFormState) _then) = _$HabitFormStateCopyWithImpl;
@useResult
$Res call({
 HabitFormStatus status, HabitFormValues? original, HabitFormValues? values, bool showErrors, bool saving, HabitFormExit? exit, String? errorMessage, int errorSerial
});


$HabitFormValuesCopyWith<$Res>? get original;$HabitFormValuesCopyWith<$Res>? get values;

}
/// @nodoc
class _$HabitFormStateCopyWithImpl<$Res>
    implements $HabitFormStateCopyWith<$Res> {
  _$HabitFormStateCopyWithImpl(this._self, this._then);

  final HabitFormState _self;
  final $Res Function(HabitFormState) _then;

/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? original = freezed,Object? values = freezed,Object? showErrors = null,Object? saving = null,Object? exit = freezed,Object? errorMessage = freezed,Object? errorSerial = null,}) {
  return _then(HabitFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HabitFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as HabitFormValues?,values: freezed == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as HabitFormValues?,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,exit: freezed == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as HabitFormExit?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorSerial: null == errorSerial ? _self.errorSerial : errorSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitFormValuesCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $HabitFormValuesCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitFormValuesCopyWith<$Res>? get values {
    if (_self.values == null) {
    return null;
  }

  return $HabitFormValuesCopyWith<$Res>(_self.values!, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}


/// Adds pattern-matching-related methods to [HabitFormState].
extension HabitFormStatePatterns on HabitFormState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HabitFormState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HabitFormState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HabitFormState value)  $default,){
final _that = this;
switch (_that) {
case _HabitFormState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HabitFormState value)?  $default,){
final _that = this;
switch (_that) {
case _HabitFormState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HabitFormStatus status,  HabitFormValues? original,  HabitFormValues? values,  bool showErrors,  bool saving,  HabitFormExit? exit,  String? errorMessage,  int errorSerial)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HabitFormState() when $default != null:
return $default(_that.status,_that.original,_that.values,_that.showErrors,_that.saving,_that.exit,_that.errorMessage,_that.errorSerial);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HabitFormStatus status,  HabitFormValues? original,  HabitFormValues? values,  bool showErrors,  bool saving,  HabitFormExit? exit,  String? errorMessage,  int errorSerial)  $default,) {final _that = this;
switch (_that) {
case _HabitFormState():
return $default(_that.status,_that.original,_that.values,_that.showErrors,_that.saving,_that.exit,_that.errorMessage,_that.errorSerial);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HabitFormStatus status,  HabitFormValues? original,  HabitFormValues? values,  bool showErrors,  bool saving,  HabitFormExit? exit,  String? errorMessage,  int errorSerial)?  $default,) {final _that = this;
switch (_that) {
case _HabitFormState() when $default != null:
return $default(_that.status,_that.original,_that.values,_that.showErrors,_that.saving,_that.exit,_that.errorMessage,_that.errorSerial);case _:
  return null;

}
}

}

/// @nodoc


class _HabitFormState extends HabitFormState {
  const _HabitFormState({this.status = HabitFormStatus.loading, this.original, this.values, this.showErrors = false, this.saving = false, this.exit, this.errorMessage, this.errorSerial = 0}): super._();
  

@override@JsonKey() final  HabitFormStatus status;
/// What the habit was when opened (the defaults for a new one).
@override final  HabitFormValues? original;
@override final  HabitFormValues? values;
/// Errors show under the fields only after a first Save.
@override@JsonKey() final  bool showErrors;
@override@JsonKey() final  bool saving;
@override final  HabitFormExit? exit;
@override final  String? errorMessage;
@override@JsonKey() final  int errorSerial;

/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HabitFormStateCopyWith<_HabitFormState> get copyWith => __$HabitFormStateCopyWithImpl<_HabitFormState>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _HabitFormState&&(identical(other.status, status) || other.status == status)&&(identical(other.original, original) || other.original == original)&&(identical(other.values, values) || other.values == values)&&(identical(other.showErrors, showErrors) || other.showErrors == showErrors)&&(identical(other.saving, saving) || other.saving == saving)&&(identical(other.exit, exit) || other.exit == exit)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.errorSerial, errorSerial) || other.errorSerial == errorSerial));
}


@override
int get hashCode {
    return Object.hash(runtimeType,status,original,values,showErrors,saving,exit,errorMessage,errorSerial);
}

@override
String toString() {
    return 'HabitFormState(status: $status, original: $original, values: $values, showErrors: $showErrors, saving: $saving, exit: $exit, errorMessage: $errorMessage, errorSerial: $errorSerial)';
}


}

/// @nodoc
abstract mixin class _$HabitFormStateCopyWith<$Res> implements $HabitFormStateCopyWith<$Res> {
  factory _$HabitFormStateCopyWith(_HabitFormState value, $Res Function(_HabitFormState) _then) = __$HabitFormStateCopyWithImpl;
@override @useResult
$Res call({
 HabitFormStatus status, HabitFormValues? original, HabitFormValues? values, bool showErrors, bool saving, HabitFormExit? exit, String? errorMessage, int errorSerial
});


@override $HabitFormValuesCopyWith<$Res>? get original;@override $HabitFormValuesCopyWith<$Res>? get values;

}
/// @nodoc
class __$HabitFormStateCopyWithImpl<$Res>
    implements _$HabitFormStateCopyWith<$Res> {
  __$HabitFormStateCopyWithImpl(this._self, this._then);

  final _HabitFormState _self;
  final $Res Function(_HabitFormState) _then;

/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? original = freezed,Object? values = freezed,Object? showErrors = null,Object? saving = null,Object? exit = freezed,Object? errorMessage = freezed,Object? errorSerial = null,}) {
  return _then(_HabitFormState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as HabitFormStatus,original: freezed == original ? _self.original : original // ignore: cast_nullable_to_non_nullable
as HabitFormValues?,values: freezed == values ? _self.values : values // ignore: cast_nullable_to_non_nullable
as HabitFormValues?,showErrors: null == showErrors ? _self.showErrors : showErrors // ignore: cast_nullable_to_non_nullable
as bool,saving: null == saving ? _self.saving : saving // ignore: cast_nullable_to_non_nullable
as bool,exit: freezed == exit ? _self.exit : exit // ignore: cast_nullable_to_non_nullable
as HabitFormExit?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,errorSerial: null == errorSerial ? _self.errorSerial : errorSerial // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitFormValuesCopyWith<$Res>? get original {
    if (_self.original == null) {
    return null;
  }

  return $HabitFormValuesCopyWith<$Res>(_self.original!, (value) {
    return _then(_self.copyWith(original: value));
  });
}/// Create a copy of HabitFormState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HabitFormValuesCopyWith<$Res>? get values {
    if (_self.values == null) {
    return null;
  }

  return $HabitFormValuesCopyWith<$Res>(_self.values!, (value) {
    return _then(_self.copyWith(values: value));
  });
}
}

// dart format on
