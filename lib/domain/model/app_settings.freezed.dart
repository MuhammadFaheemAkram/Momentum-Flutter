// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'app_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AppSettings {

/// Whether the user has left Welcome (with the demo, or empty).
 bool get onboarded; AppThemeMode get themeMode;/// Colors from the wallpaper (Android 12+). On by default, as Material
/// You apps are; ignored where the device has none.
 bool get dynamicColor;/// The master switch. Reads "on" only while the system allows
/// notifications: turning it on asks for permission, and a permission
/// revoked later turns it off at the next sync (correctness rule 8).
 bool get notificationsEnabled;/// "2 habits left today", at [nudgeTime], while any due habit is open.
 bool get nudgeEnabled; TimeOfDayValue get nudgeTime;/// "4 of 5 done today", at [summaryTime].
 bool get summaryEnabled; TimeOfDayValue get summaryTime;/// The time a new habit's reminder starts at.
 TimeOfDayValue get defaultReminder;/// A backup once a day, from the background tasks.
 bool get autoBackup;/// When the service last confirmed a backup (its receipt's time).
 DateTime? get lastBackupAt;
/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppSettingsCopyWith<AppSettings> get copyWith => _$AppSettingsCopyWithImpl<AppSettings>(this as AppSettings, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as AppSettings;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppSettings&&(identical(other.onboarded, _this.onboarded) || other.onboarded == _this.onboarded)&&(identical(other.themeMode, _this.themeMode) || other.themeMode == _this.themeMode)&&(identical(other.dynamicColor, _this.dynamicColor) || other.dynamicColor == _this.dynamicColor)&&(identical(other.notificationsEnabled, _this.notificationsEnabled) || other.notificationsEnabled == _this.notificationsEnabled)&&(identical(other.nudgeEnabled, _this.nudgeEnabled) || other.nudgeEnabled == _this.nudgeEnabled)&&(identical(other.nudgeTime, _this.nudgeTime) || other.nudgeTime == _this.nudgeTime)&&(identical(other.summaryEnabled, _this.summaryEnabled) || other.summaryEnabled == _this.summaryEnabled)&&(identical(other.summaryTime, _this.summaryTime) || other.summaryTime == _this.summaryTime)&&(identical(other.defaultReminder, _this.defaultReminder) || other.defaultReminder == _this.defaultReminder)&&(identical(other.autoBackup, _this.autoBackup) || other.autoBackup == _this.autoBackup)&&(identical(other.lastBackupAt, _this.lastBackupAt) || other.lastBackupAt == _this.lastBackupAt));
}


@override
int get hashCode {
  final _this = this as AppSettings;
  return Object.hash(runtimeType,_this.onboarded,_this.themeMode,_this.dynamicColor,_this.notificationsEnabled,_this.nudgeEnabled,_this.nudgeTime,_this.summaryEnabled,_this.summaryTime,_this.defaultReminder,_this.autoBackup,_this.lastBackupAt);
}

@override
String toString() {
  final _this = this as AppSettings;
  return 'AppSettings(onboarded: ${_this.onboarded}, themeMode: ${_this.themeMode}, dynamicColor: ${_this.dynamicColor}, notificationsEnabled: ${_this.notificationsEnabled}, nudgeEnabled: ${_this.nudgeEnabled}, nudgeTime: ${_this.nudgeTime}, summaryEnabled: ${_this.summaryEnabled}, summaryTime: ${_this.summaryTime}, defaultReminder: ${_this.defaultReminder}, autoBackup: ${_this.autoBackup}, lastBackupAt: ${_this.lastBackupAt})';
}


}

/// @nodoc
abstract mixin class $AppSettingsCopyWith<$Res>  {
  factory $AppSettingsCopyWith(AppSettings value, $Res Function(AppSettings) _then) = _$AppSettingsCopyWithImpl;
@useResult
$Res call({
 bool onboarded, AppThemeMode themeMode, bool dynamicColor, bool notificationsEnabled, bool nudgeEnabled, TimeOfDayValue nudgeTime, bool summaryEnabled, TimeOfDayValue summaryTime, TimeOfDayValue defaultReminder, bool autoBackup, DateTime? lastBackupAt
});




}
/// @nodoc
class _$AppSettingsCopyWithImpl<$Res>
    implements $AppSettingsCopyWith<$Res> {
  _$AppSettingsCopyWithImpl(this._self, this._then);

  final AppSettings _self;
  final $Res Function(AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? onboarded = null,Object? themeMode = null,Object? dynamicColor = null,Object? notificationsEnabled = null,Object? nudgeEnabled = null,Object? nudgeTime = null,Object? summaryEnabled = null,Object? summaryTime = null,Object? defaultReminder = null,Object? autoBackup = null,Object? lastBackupAt = freezed,}) {
  return _then(AppSettings(
onboarded: null == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,dynamicColor: null == dynamicColor ? _self.dynamicColor : dynamicColor // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,nudgeEnabled: null == nudgeEnabled ? _self.nudgeEnabled : nudgeEnabled // ignore: cast_nullable_to_non_nullable
as bool,nudgeTime: null == nudgeTime ? _self.nudgeTime : nudgeTime // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue,summaryEnabled: null == summaryEnabled ? _self.summaryEnabled : summaryEnabled // ignore: cast_nullable_to_non_nullable
as bool,summaryTime: null == summaryTime ? _self.summaryTime : summaryTime // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue,defaultReminder: null == defaultReminder ? _self.defaultReminder : defaultReminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue,autoBackup: null == autoBackup ? _self.autoBackup : autoBackup // ignore: cast_nullable_to_non_nullable
as bool,lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AppSettings].
extension AppSettingsPatterns on AppSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppSettings value)  $default,){
final _that = this;
switch (_that) {
case _AppSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppSettings value)?  $default,){
final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool onboarded,  AppThemeMode themeMode,  bool dynamicColor,  bool notificationsEnabled,  bool nudgeEnabled,  TimeOfDayValue nudgeTime,  bool summaryEnabled,  TimeOfDayValue summaryTime,  TimeOfDayValue defaultReminder,  bool autoBackup,  DateTime? lastBackupAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.onboarded,_that.themeMode,_that.dynamicColor,_that.notificationsEnabled,_that.nudgeEnabled,_that.nudgeTime,_that.summaryEnabled,_that.summaryTime,_that.defaultReminder,_that.autoBackup,_that.lastBackupAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool onboarded,  AppThemeMode themeMode,  bool dynamicColor,  bool notificationsEnabled,  bool nudgeEnabled,  TimeOfDayValue nudgeTime,  bool summaryEnabled,  TimeOfDayValue summaryTime,  TimeOfDayValue defaultReminder,  bool autoBackup,  DateTime? lastBackupAt)  $default,) {final _that = this;
switch (_that) {
case _AppSettings():
return $default(_that.onboarded,_that.themeMode,_that.dynamicColor,_that.notificationsEnabled,_that.nudgeEnabled,_that.nudgeTime,_that.summaryEnabled,_that.summaryTime,_that.defaultReminder,_that.autoBackup,_that.lastBackupAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool onboarded,  AppThemeMode themeMode,  bool dynamicColor,  bool notificationsEnabled,  bool nudgeEnabled,  TimeOfDayValue nudgeTime,  bool summaryEnabled,  TimeOfDayValue summaryTime,  TimeOfDayValue defaultReminder,  bool autoBackup,  DateTime? lastBackupAt)?  $default,) {final _that = this;
switch (_that) {
case _AppSettings() when $default != null:
return $default(_that.onboarded,_that.themeMode,_that.dynamicColor,_that.notificationsEnabled,_that.nudgeEnabled,_that.nudgeTime,_that.summaryEnabled,_that.summaryTime,_that.defaultReminder,_that.autoBackup,_that.lastBackupAt);case _:
  return null;

}
}

}

/// @nodoc


class _AppSettings implements AppSettings {
  const _AppSettings({this.onboarded = false, this.themeMode = AppThemeMode.system, this.dynamicColor = true, this.notificationsEnabled = false, this.nudgeEnabled = true, this.nudgeTime = TimeOfDayValue.eightPm, this.summaryEnabled = true, this.summaryTime = TimeOfDayValue.nineThirtyPm, this.defaultReminder = TimeOfDayValue.nineAm, this.autoBackup = false, this.lastBackupAt});
  

/// Whether the user has left Welcome (with the demo, or empty).
@override@JsonKey() final  bool onboarded;
@override@JsonKey() final  AppThemeMode themeMode;
/// Colors from the wallpaper (Android 12+). On by default, as Material
/// You apps are; ignored where the device has none.
@override@JsonKey() final  bool dynamicColor;
/// The master switch. Reads "on" only while the system allows
/// notifications: turning it on asks for permission, and a permission
/// revoked later turns it off at the next sync (correctness rule 8).
@override@JsonKey() final  bool notificationsEnabled;
/// "2 habits left today", at [nudgeTime], while any due habit is open.
@override@JsonKey() final  bool nudgeEnabled;
@override@JsonKey() final  TimeOfDayValue nudgeTime;
/// "4 of 5 done today", at [summaryTime].
@override@JsonKey() final  bool summaryEnabled;
@override@JsonKey() final  TimeOfDayValue summaryTime;
/// The time a new habit's reminder starts at.
@override@JsonKey() final  TimeOfDayValue defaultReminder;
/// A backup once a day, from the background tasks.
@override@JsonKey() final  bool autoBackup;
/// When the service last confirmed a backup (its receipt's time).
@override final  DateTime? lastBackupAt;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppSettingsCopyWith<_AppSettings> get copyWith => __$AppSettingsCopyWithImpl<_AppSettings>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppSettings&&(identical(other.onboarded, onboarded) || other.onboarded == onboarded)&&(identical(other.themeMode, themeMode) || other.themeMode == themeMode)&&(identical(other.dynamicColor, dynamicColor) || other.dynamicColor == dynamicColor)&&(identical(other.notificationsEnabled, notificationsEnabled) || other.notificationsEnabled == notificationsEnabled)&&(identical(other.nudgeEnabled, nudgeEnabled) || other.nudgeEnabled == nudgeEnabled)&&(identical(other.nudgeTime, nudgeTime) || other.nudgeTime == nudgeTime)&&(identical(other.summaryEnabled, summaryEnabled) || other.summaryEnabled == summaryEnabled)&&(identical(other.summaryTime, summaryTime) || other.summaryTime == summaryTime)&&(identical(other.defaultReminder, defaultReminder) || other.defaultReminder == defaultReminder)&&(identical(other.autoBackup, autoBackup) || other.autoBackup == autoBackup)&&(identical(other.lastBackupAt, lastBackupAt) || other.lastBackupAt == lastBackupAt));
}


@override
int get hashCode {
    return Object.hash(runtimeType,onboarded,themeMode,dynamicColor,notificationsEnabled,nudgeEnabled,nudgeTime,summaryEnabled,summaryTime,defaultReminder,autoBackup,lastBackupAt);
}

@override
String toString() {
    return 'AppSettings(onboarded: $onboarded, themeMode: $themeMode, dynamicColor: $dynamicColor, notificationsEnabled: $notificationsEnabled, nudgeEnabled: $nudgeEnabled, nudgeTime: $nudgeTime, summaryEnabled: $summaryEnabled, summaryTime: $summaryTime, defaultReminder: $defaultReminder, autoBackup: $autoBackup, lastBackupAt: $lastBackupAt)';
}


}

/// @nodoc
abstract mixin class _$AppSettingsCopyWith<$Res> implements $AppSettingsCopyWith<$Res> {
  factory _$AppSettingsCopyWith(_AppSettings value, $Res Function(_AppSettings) _then) = __$AppSettingsCopyWithImpl;
@override @useResult
$Res call({
 bool onboarded, AppThemeMode themeMode, bool dynamicColor, bool notificationsEnabled, bool nudgeEnabled, TimeOfDayValue nudgeTime, bool summaryEnabled, TimeOfDayValue summaryTime, TimeOfDayValue defaultReminder, bool autoBackup, DateTime? lastBackupAt
});




}
/// @nodoc
class __$AppSettingsCopyWithImpl<$Res>
    implements _$AppSettingsCopyWith<$Res> {
  __$AppSettingsCopyWithImpl(this._self, this._then);

  final _AppSettings _self;
  final $Res Function(_AppSettings) _then;

/// Create a copy of AppSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? onboarded = null,Object? themeMode = null,Object? dynamicColor = null,Object? notificationsEnabled = null,Object? nudgeEnabled = null,Object? nudgeTime = null,Object? summaryEnabled = null,Object? summaryTime = null,Object? defaultReminder = null,Object? autoBackup = null,Object? lastBackupAt = freezed,}) {
  return _then(_AppSettings(
onboarded: null == onboarded ? _self.onboarded : onboarded // ignore: cast_nullable_to_non_nullable
as bool,themeMode: null == themeMode ? _self.themeMode : themeMode // ignore: cast_nullable_to_non_nullable
as AppThemeMode,dynamicColor: null == dynamicColor ? _self.dynamicColor : dynamicColor // ignore: cast_nullable_to_non_nullable
as bool,notificationsEnabled: null == notificationsEnabled ? _self.notificationsEnabled : notificationsEnabled // ignore: cast_nullable_to_non_nullable
as bool,nudgeEnabled: null == nudgeEnabled ? _self.nudgeEnabled : nudgeEnabled // ignore: cast_nullable_to_non_nullable
as bool,nudgeTime: null == nudgeTime ? _self.nudgeTime : nudgeTime // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue,summaryEnabled: null == summaryEnabled ? _self.summaryEnabled : summaryEnabled // ignore: cast_nullable_to_non_nullable
as bool,summaryTime: null == summaryTime ? _self.summaryTime : summaryTime // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue,defaultReminder: null == defaultReminder ? _self.defaultReminder : defaultReminder // ignore: cast_nullable_to_non_nullable
as TimeOfDayValue,autoBackup: null == autoBackup ? _self.autoBackup : autoBackup // ignore: cast_nullable_to_non_nullable
as bool,lastBackupAt: freezed == lastBackupAt ? _self.lastBackupAt : lastBackupAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
