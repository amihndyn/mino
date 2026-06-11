// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent()';
}


}

/// @nodoc
class $DashboardEventCopyWith<$Res>  {
$DashboardEventCopyWith(DashboardEvent _, $Res Function(DashboardEvent) __);
}


/// Adds pattern-matching-related methods to [DashboardEvent].
extension DashboardEventPatterns on DashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchDashboardData value)?  fetchDashboardData,TResult Function( _ToggleHabit value)?  toggleHabit,TResult Function( _DeleteHabit value)?  deleteHabit,TResult Function( _AddHabit value)?  addHabit,TResult Function( _EditHabit value)?  editHabit,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchDashboardData() when fetchDashboardData != null:
return fetchDashboardData(_that);case _ToggleHabit() when toggleHabit != null:
return toggleHabit(_that);case _DeleteHabit() when deleteHabit != null:
return deleteHabit(_that);case _AddHabit() when addHabit != null:
return addHabit(_that);case _EditHabit() when editHabit != null:
return editHabit(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchDashboardData value)  fetchDashboardData,required TResult Function( _ToggleHabit value)  toggleHabit,required TResult Function( _DeleteHabit value)  deleteHabit,required TResult Function( _AddHabit value)  addHabit,required TResult Function( _EditHabit value)  editHabit,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchDashboardData():
return fetchDashboardData(_that);case _ToggleHabit():
return toggleHabit(_that);case _DeleteHabit():
return deleteHabit(_that);case _AddHabit():
return addHabit(_that);case _EditHabit():
return editHabit(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchDashboardData value)?  fetchDashboardData,TResult? Function( _ToggleHabit value)?  toggleHabit,TResult? Function( _DeleteHabit value)?  deleteHabit,TResult? Function( _AddHabit value)?  addHabit,TResult? Function( _EditHabit value)?  editHabit,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchDashboardData() when fetchDashboardData != null:
return fetchDashboardData(_that);case _ToggleHabit() when toggleHabit != null:
return toggleHabit(_that);case _DeleteHabit() when deleteHabit != null:
return deleteHabit(_that);case _AddHabit() when addHabit != null:
return addHabit(_that);case _EditHabit() when editHabit != null:
return editHabit(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function( int? month)?  fetchDashboardData,TResult Function( int userHabitId,  bool currentStatus)?  toggleHabit,TResult Function( int userHabitId)?  deleteHabit,TResult Function( String name)?  addHabit,TResult Function( int userHabitId,  String newName)?  editHabit,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchDashboardData() when fetchDashboardData != null:
return fetchDashboardData(_that.month);case _ToggleHabit() when toggleHabit != null:
return toggleHabit(_that.userHabitId,_that.currentStatus);case _DeleteHabit() when deleteHabit != null:
return deleteHabit(_that.userHabitId);case _AddHabit() when addHabit != null:
return addHabit(_that.name);case _EditHabit() when editHabit != null:
return editHabit(_that.userHabitId,_that.newName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function( int? month)  fetchDashboardData,required TResult Function( int userHabitId,  bool currentStatus)  toggleHabit,required TResult Function( int userHabitId)  deleteHabit,required TResult Function( String name)  addHabit,required TResult Function( int userHabitId,  String newName)  editHabit,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchDashboardData():
return fetchDashboardData(_that.month);case _ToggleHabit():
return toggleHabit(_that.userHabitId,_that.currentStatus);case _DeleteHabit():
return deleteHabit(_that.userHabitId);case _AddHabit():
return addHabit(_that.name);case _EditHabit():
return editHabit(_that.userHabitId,_that.newName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function( int? month)?  fetchDashboardData,TResult? Function( int userHabitId,  bool currentStatus)?  toggleHabit,TResult? Function( int userHabitId)?  deleteHabit,TResult? Function( String name)?  addHabit,TResult? Function( int userHabitId,  String newName)?  editHabit,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchDashboardData() when fetchDashboardData != null:
return fetchDashboardData(_that.month);case _ToggleHabit() when toggleHabit != null:
return toggleHabit(_that.userHabitId,_that.currentStatus);case _DeleteHabit() when deleteHabit != null:
return deleteHabit(_that.userHabitId);case _AddHabit() when addHabit != null:
return addHabit(_that.name);case _EditHabit() when editHabit != null:
return editHabit(_that.userHabitId,_that.newName);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements DashboardEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.started()';
}


}




/// @nodoc


class _FetchDashboardData implements DashboardEvent {
  const _FetchDashboardData({this.month});
  

 final  int? month;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FetchDashboardDataCopyWith<_FetchDashboardData> get copyWith => __$FetchDashboardDataCopyWithImpl<_FetchDashboardData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchDashboardData&&(identical(other.month, month) || other.month == month));
}


@override
int get hashCode => Object.hash(runtimeType,month);

@override
String toString() {
  return 'DashboardEvent.fetchDashboardData(month: $month)';
}


}

/// @nodoc
abstract mixin class _$FetchDashboardDataCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$FetchDashboardDataCopyWith(_FetchDashboardData value, $Res Function(_FetchDashboardData) _then) = __$FetchDashboardDataCopyWithImpl;
@useResult
$Res call({
 int? month
});




}
/// @nodoc
class __$FetchDashboardDataCopyWithImpl<$Res>
    implements _$FetchDashboardDataCopyWith<$Res> {
  __$FetchDashboardDataCopyWithImpl(this._self, this._then);

  final _FetchDashboardData _self;
  final $Res Function(_FetchDashboardData) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? month = freezed,}) {
  return _then(_FetchDashboardData(
month: freezed == month ? _self.month : month // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _ToggleHabit implements DashboardEvent {
  const _ToggleHabit(this.userHabitId, this.currentStatus);
  

 final  int userHabitId;
 final  bool currentStatus;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToggleHabitCopyWith<_ToggleHabit> get copyWith => __$ToggleHabitCopyWithImpl<_ToggleHabit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToggleHabit&&(identical(other.userHabitId, userHabitId) || other.userHabitId == userHabitId)&&(identical(other.currentStatus, currentStatus) || other.currentStatus == currentStatus));
}


@override
int get hashCode => Object.hash(runtimeType,userHabitId,currentStatus);

@override
String toString() {
  return 'DashboardEvent.toggleHabit(userHabitId: $userHabitId, currentStatus: $currentStatus)';
}


}

/// @nodoc
abstract mixin class _$ToggleHabitCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$ToggleHabitCopyWith(_ToggleHabit value, $Res Function(_ToggleHabit) _then) = __$ToggleHabitCopyWithImpl;
@useResult
$Res call({
 int userHabitId, bool currentStatus
});




}
/// @nodoc
class __$ToggleHabitCopyWithImpl<$Res>
    implements _$ToggleHabitCopyWith<$Res> {
  __$ToggleHabitCopyWithImpl(this._self, this._then);

  final _ToggleHabit _self;
  final $Res Function(_ToggleHabit) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userHabitId = null,Object? currentStatus = null,}) {
  return _then(_ToggleHabit(
null == userHabitId ? _self.userHabitId : userHabitId // ignore: cast_nullable_to_non_nullable
as int,null == currentStatus ? _self.currentStatus : currentStatus // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class _DeleteHabit implements DashboardEvent {
  const _DeleteHabit(this.userHabitId);
  

 final  int userHabitId;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteHabitCopyWith<_DeleteHabit> get copyWith => __$DeleteHabitCopyWithImpl<_DeleteHabit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteHabit&&(identical(other.userHabitId, userHabitId) || other.userHabitId == userHabitId));
}


@override
int get hashCode => Object.hash(runtimeType,userHabitId);

@override
String toString() {
  return 'DashboardEvent.deleteHabit(userHabitId: $userHabitId)';
}


}

/// @nodoc
abstract mixin class _$DeleteHabitCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$DeleteHabitCopyWith(_DeleteHabit value, $Res Function(_DeleteHabit) _then) = __$DeleteHabitCopyWithImpl;
@useResult
$Res call({
 int userHabitId
});




}
/// @nodoc
class __$DeleteHabitCopyWithImpl<$Res>
    implements _$DeleteHabitCopyWith<$Res> {
  __$DeleteHabitCopyWithImpl(this._self, this._then);

  final _DeleteHabit _self;
  final $Res Function(_DeleteHabit) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userHabitId = null,}) {
  return _then(_DeleteHabit(
null == userHabitId ? _self.userHabitId : userHabitId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _AddHabit implements DashboardEvent {
  const _AddHabit(this.name);
  

 final  String name;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddHabitCopyWith<_AddHabit> get copyWith => __$AddHabitCopyWithImpl<_AddHabit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddHabit&&(identical(other.name, name) || other.name == name));
}


@override
int get hashCode => Object.hash(runtimeType,name);

@override
String toString() {
  return 'DashboardEvent.addHabit(name: $name)';
}


}

/// @nodoc
abstract mixin class _$AddHabitCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$AddHabitCopyWith(_AddHabit value, $Res Function(_AddHabit) _then) = __$AddHabitCopyWithImpl;
@useResult
$Res call({
 String name
});




}
/// @nodoc
class __$AddHabitCopyWithImpl<$Res>
    implements _$AddHabitCopyWith<$Res> {
  __$AddHabitCopyWithImpl(this._self, this._then);

  final _AddHabit _self;
  final $Res Function(_AddHabit) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? name = null,}) {
  return _then(_AddHabit(
null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _EditHabit implements DashboardEvent {
  const _EditHabit(this.userHabitId, this.newName);
  

 final  int userHabitId;
 final  String newName;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EditHabitCopyWith<_EditHabit> get copyWith => __$EditHabitCopyWithImpl<_EditHabit>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EditHabit&&(identical(other.userHabitId, userHabitId) || other.userHabitId == userHabitId)&&(identical(other.newName, newName) || other.newName == newName));
}


@override
int get hashCode => Object.hash(runtimeType,userHabitId,newName);

@override
String toString() {
  return 'DashboardEvent.editHabit(userHabitId: $userHabitId, newName: $newName)';
}


}

/// @nodoc
abstract mixin class _$EditHabitCopyWith<$Res> implements $DashboardEventCopyWith<$Res> {
  factory _$EditHabitCopyWith(_EditHabit value, $Res Function(_EditHabit) _then) = __$EditHabitCopyWithImpl;
@useResult
$Res call({
 int userHabitId, String newName
});




}
/// @nodoc
class __$EditHabitCopyWithImpl<$Res>
    implements _$EditHabitCopyWith<$Res> {
  __$EditHabitCopyWithImpl(this._self, this._then);

  final _EditHabit _self;
  final $Res Function(_EditHabit) _then;

/// Create a copy of DashboardEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userHabitId = null,Object? newName = null,}) {
  return _then(_EditHabit(
null == userHabitId ? _self.userHabitId : userHabitId // ignore: cast_nullable_to_non_nullable
as int,null == newName ? _self.newName : newName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$DashboardState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState()';
}


}

/// @nodoc
class $DashboardStateCopyWith<$Res>  {
$DashboardStateCopyWith(DashboardState _, $Res Function(DashboardState) __);
}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _Error():
return error(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _Error() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( DashboardResponseModel response)?  success,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.response);case _Error() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( DashboardResponseModel response)  success,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.response);case _Error():
return error(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( DashboardResponseModel response)?  success,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.response);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements DashboardState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.initial()';
}


}




/// @nodoc


class _Loading implements DashboardState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardState.loading()';
}


}




/// @nodoc


class _Success implements DashboardState {
  const _Success(this.response);
  

 final  DashboardResponseModel response;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&(identical(other.response, response) || other.response == response));
}


@override
int get hashCode => Object.hash(runtimeType,response);

@override
String toString() {
  return 'DashboardState.success(response: $response)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 DashboardResponseModel response
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? response = null,}) {
  return _then(_Success(
null == response ? _self.response : response // ignore: cast_nullable_to_non_nullable
as DashboardResponseModel,
  ));
}


}

/// @nodoc


class _Error implements DashboardState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ErrorCopyWith<_Error> get copyWith => __$ErrorCopyWithImpl<_Error>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Error&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'DashboardState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$ErrorCopyWith(_Error value, $Res Function(_Error) _then) = __$ErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$ErrorCopyWithImpl<$Res>
    implements _$ErrorCopyWith<$Res> {
  __$ErrorCopyWithImpl(this._self, this._then);

  final _Error _self;
  final $Res Function(_Error) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
