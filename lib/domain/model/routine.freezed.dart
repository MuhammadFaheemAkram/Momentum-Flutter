// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'routine.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Routine {

 String get id; String get title; RoutineTime get time;/// In the user's order: the list's order *is* the order.
 List<RoutineItem> get items; DateTime get createdAt;/// The position among the routines.
 int get sortOrder;
/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineCopyWith<Routine> get copyWith => _$RoutineCopyWithImpl<Routine>(this as Routine, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as Routine;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Routine&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title)&&(identical(other.time, _this.time) || other.time == _this.time)&&const DeepCollectionEquality().equals(other.items, _this.items)&&(identical(other.createdAt, _this.createdAt) || other.createdAt == _this.createdAt)&&(identical(other.sortOrder, _this.sortOrder) || other.sortOrder == _this.sortOrder));
}


@override
int get hashCode {
  final _this = this as Routine;
  return Object.hash(runtimeType,_this.id,_this.title,_this.time,const DeepCollectionEquality().hash(_this.items),_this.createdAt,_this.sortOrder);
}

@override
String toString() {
  final _this = this as Routine;
  return 'Routine(id: ${_this.id}, title: ${_this.title}, time: ${_this.time}, items: ${_this.items}, createdAt: ${_this.createdAt}, sortOrder: ${_this.sortOrder})';
}


}

/// @nodoc
abstract mixin class $RoutineCopyWith<$Res>  {
  factory $RoutineCopyWith(Routine value, $Res Function(Routine) _then) = _$RoutineCopyWithImpl;
@useResult
$Res call({
 String id, String title, RoutineTime time, List<RoutineItem> items, DateTime createdAt, int sortOrder
});




}
/// @nodoc
class _$RoutineCopyWithImpl<$Res>
    implements $RoutineCopyWith<$Res> {
  _$RoutineCopyWithImpl(this._self, this._then);

  final Routine _self;
  final $Res Function(Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? time = null,Object? items = null,Object? createdAt = null,Object? sortOrder = null,}) {
  return _then(Routine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as RoutineTime,items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<RoutineItem>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [Routine].
extension RoutinePatterns on Routine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Routine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Routine value)  $default,){
final _that = this;
switch (_that) {
case _Routine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Routine value)?  $default,){
final _that = this;
switch (_that) {
case _Routine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  RoutineTime time,  List<RoutineItem> items,  DateTime createdAt,  int sortOrder)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.title,_that.time,_that.items,_that.createdAt,_that.sortOrder);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  RoutineTime time,  List<RoutineItem> items,  DateTime createdAt,  int sortOrder)  $default,) {final _that = this;
switch (_that) {
case _Routine():
return $default(_that.id,_that.title,_that.time,_that.items,_that.createdAt,_that.sortOrder);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  RoutineTime time,  List<RoutineItem> items,  DateTime createdAt,  int sortOrder)?  $default,) {final _that = this;
switch (_that) {
case _Routine() when $default != null:
return $default(_that.id,_that.title,_that.time,_that.items,_that.createdAt,_that.sortOrder);case _:
  return null;

}
}

}

/// @nodoc


class _Routine implements Routine {
  const _Routine({required this.id, required this.title, this.time = RoutineTime.anytime, required  List<RoutineItem> items, required this.createdAt, required this.sortOrder}): _items = items;
  

@override final  String id;
@override final  String title;
@override@JsonKey() final  RoutineTime time;
/// In the user's order: the list's order *is* the order.
 final  List<RoutineItem> _items;
/// In the user's order: the list's order *is* the order.
@override List<RoutineItem> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

@override final  DateTime createdAt;
/// The position among the routines.
@override final  int sortOrder;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineCopyWith<_Routine> get copyWith => __$RoutineCopyWithImpl<_Routine>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _Routine&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.time, time) || other.time == time)&&const DeepCollectionEquality().equals(other.items, _items)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.sortOrder, sortOrder) || other.sortOrder == sortOrder));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title,time,const DeepCollectionEquality().hash(_items),createdAt,sortOrder);
}

@override
String toString() {
    return 'Routine(id: $id, title: $title, time: $time, items: $items, createdAt: $createdAt, sortOrder: $sortOrder)';
}


}

/// @nodoc
abstract mixin class _$RoutineCopyWith<$Res> implements $RoutineCopyWith<$Res> {
  factory _$RoutineCopyWith(_Routine value, $Res Function(_Routine) _then) = __$RoutineCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, RoutineTime time, List<RoutineItem> items, DateTime createdAt, int sortOrder
});




}
/// @nodoc
class __$RoutineCopyWithImpl<$Res>
    implements _$RoutineCopyWith<$Res> {
  __$RoutineCopyWithImpl(this._self, this._then);

  final _Routine _self;
  final $Res Function(_Routine) _then;

/// Create a copy of Routine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? time = null,Object? items = null,Object? createdAt = null,Object? sortOrder = null,}) {
  return _then(_Routine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,time: null == time ? _self.time : time // ignore: cast_nullable_to_non_nullable
as RoutineTime,items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<RoutineItem>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,sortOrder: null == sortOrder ? _self.sortOrder : sortOrder // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$RoutineItem {

 String get id; String get title;
/// Create a copy of RoutineItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineItemCopyWith<RoutineItem> get copyWith => _$RoutineItemCopyWithImpl<RoutineItem>(this as RoutineItem, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineItem;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineItem&&(identical(other.id, _this.id) || other.id == _this.id)&&(identical(other.title, _this.title) || other.title == _this.title));
}


@override
int get hashCode {
  final _this = this as RoutineItem;
  return Object.hash(runtimeType,_this.id,_this.title);
}

@override
String toString() {
  final _this = this as RoutineItem;
  return 'RoutineItem(id: ${_this.id}, title: ${_this.title})';
}


}

/// @nodoc
abstract mixin class $RoutineItemCopyWith<$Res>  {
  factory $RoutineItemCopyWith(RoutineItem value, $Res Function(RoutineItem) _then) = _$RoutineItemCopyWithImpl;
@useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class _$RoutineItemCopyWithImpl<$Res>
    implements $RoutineItemCopyWith<$Res> {
  _$RoutineItemCopyWithImpl(this._self, this._then);

  final RoutineItem _self;
  final $Res Function(RoutineItem) _then;

/// Create a copy of RoutineItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,}) {
  return _then(RoutineItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineItem].
extension RoutineItemPatterns on RoutineItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineItem value)  $default,){
final _that = this;
switch (_that) {
case _RoutineItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineItem value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineItem() when $default != null:
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title)  $default,) {final _that = this;
switch (_that) {
case _RoutineItem():
return $default(_that.id,_that.title);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title)?  $default,) {final _that = this;
switch (_that) {
case _RoutineItem() when $default != null:
return $default(_that.id,_that.title);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineItem implements RoutineItem {
  const _RoutineItem({required this.id, required this.title});
  

@override final  String id;
@override final  String title;

/// Create a copy of RoutineItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineItemCopyWith<_RoutineItem> get copyWith => __$RoutineItemCopyWithImpl<_RoutineItem>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title));
}


@override
int get hashCode {
    return Object.hash(runtimeType,id,title);
}

@override
String toString() {
    return 'RoutineItem(id: $id, title: $title)';
}


}

/// @nodoc
abstract mixin class _$RoutineItemCopyWith<$Res> implements $RoutineItemCopyWith<$Res> {
  factory _$RoutineItemCopyWith(_RoutineItem value, $Res Function(_RoutineItem) _then) = __$RoutineItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title
});




}
/// @nodoc
class __$RoutineItemCopyWithImpl<$Res>
    implements _$RoutineItemCopyWith<$Res> {
  __$RoutineItemCopyWithImpl(this._self, this._then);

  final _RoutineItem _self;
  final $Res Function(_RoutineItem) _then;

/// Create a copy of RoutineItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,}) {
  return _then(_RoutineItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$RoutineCheck {

 String get itemId; CalendarDate get day;
/// Create a copy of RoutineCheck
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RoutineCheckCopyWith<RoutineCheck> get copyWith => _$RoutineCheckCopyWithImpl<RoutineCheck>(this as RoutineCheck, _$identity);



@override
bool operator ==(Object other) {
  final _this = this as RoutineCheck;
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RoutineCheck&&(identical(other.itemId, _this.itemId) || other.itemId == _this.itemId)&&(identical(other.day, _this.day) || other.day == _this.day));
}


@override
int get hashCode {
  final _this = this as RoutineCheck;
  return Object.hash(runtimeType,_this.itemId,_this.day);
}

@override
String toString() {
  final _this = this as RoutineCheck;
  return 'RoutineCheck(itemId: ${_this.itemId}, day: ${_this.day})';
}


}

/// @nodoc
abstract mixin class $RoutineCheckCopyWith<$Res>  {
  factory $RoutineCheckCopyWith(RoutineCheck value, $Res Function(RoutineCheck) _then) = _$RoutineCheckCopyWithImpl;
@useResult
$Res call({
 String itemId, CalendarDate day
});




}
/// @nodoc
class _$RoutineCheckCopyWithImpl<$Res>
    implements $RoutineCheckCopyWith<$Res> {
  _$RoutineCheckCopyWithImpl(this._self, this._then);

  final RoutineCheck _self;
  final $Res Function(RoutineCheck) _then;

/// Create a copy of RoutineCheck
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? itemId = null,Object? day = null,}) {
  return _then(RoutineCheck(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as CalendarDate,
  ));
}

}


/// Adds pattern-matching-related methods to [RoutineCheck].
extension RoutineCheckPatterns on RoutineCheck {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RoutineCheck value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RoutineCheck() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RoutineCheck value)  $default,){
final _that = this;
switch (_that) {
case _RoutineCheck():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RoutineCheck value)?  $default,){
final _that = this;
switch (_that) {
case _RoutineCheck() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String itemId,  CalendarDate day)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RoutineCheck() when $default != null:
return $default(_that.itemId,_that.day);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String itemId,  CalendarDate day)  $default,) {final _that = this;
switch (_that) {
case _RoutineCheck():
return $default(_that.itemId,_that.day);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String itemId,  CalendarDate day)?  $default,) {final _that = this;
switch (_that) {
case _RoutineCheck() when $default != null:
return $default(_that.itemId,_that.day);case _:
  return null;

}
}

}

/// @nodoc


class _RoutineCheck implements RoutineCheck {
  const _RoutineCheck({required this.itemId, required this.day});
  

@override final  String itemId;
@override final  CalendarDate day;

/// Create a copy of RoutineCheck
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RoutineCheckCopyWith<_RoutineCheck> get copyWith => __$RoutineCheckCopyWithImpl<_RoutineCheck>(this, _$identity);



@override
bool operator ==(Object other) {
    return identical(this, other) || (other.runtimeType == runtimeType&&other is _RoutineCheck&&(identical(other.itemId, itemId) || other.itemId == itemId)&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode {
    return Object.hash(runtimeType,itemId,day);
}

@override
String toString() {
    return 'RoutineCheck(itemId: $itemId, day: $day)';
}


}

/// @nodoc
abstract mixin class _$RoutineCheckCopyWith<$Res> implements $RoutineCheckCopyWith<$Res> {
  factory _$RoutineCheckCopyWith(_RoutineCheck value, $Res Function(_RoutineCheck) _then) = __$RoutineCheckCopyWithImpl;
@override @useResult
$Res call({
 String itemId, CalendarDate day
});




}
/// @nodoc
class __$RoutineCheckCopyWithImpl<$Res>
    implements _$RoutineCheckCopyWith<$Res> {
  __$RoutineCheckCopyWithImpl(this._self, this._then);

  final _RoutineCheck _self;
  final $Res Function(_RoutineCheck) _then;

/// Create a copy of RoutineCheck
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? itemId = null,Object? day = null,}) {
  return _then(_RoutineCheck(
itemId: null == itemId ? _self.itemId : itemId // ignore: cast_nullable_to_non_nullable
as String,day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as CalendarDate,
  ));
}


}

// dart format on
