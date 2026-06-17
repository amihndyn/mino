// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'focus_timer_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$FocusTimerEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FocusTimerEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FocusTimerEvent()';
}


}

/// @nodoc
class $FocusTimerEventCopyWith<$Res>  {
$FocusTimerEventCopyWith(FocusTimerEvent _, $Res Function(FocusTimerEvent) __);
}


/// Adds pattern-matching-related methods to [FocusTimerEvent].
extension FocusTimerEventPatterns on FocusTimerEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _StartFocus value)?  startFocus,TResult Function( _CompleteFocus value)?  completeFocus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StartFocus() when startFocus != null:
return startFocus(_that);case _CompleteFocus() when completeFocus != null:
return completeFocus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _StartFocus value)  startFocus,required TResult Function( _CompleteFocus value)  completeFocus,}){
final _that = this;
switch (_that) {
case _StartFocus():
return startFocus(_that);case _CompleteFocus():
return completeFocus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _StartFocus value)?  startFocus,TResult? Function( _CompleteFocus value)?  completeFocus,}){
final _that = this;
switch (_that) {
case _StartFocus() when startFocus != null:
return startFocus(_that);case _CompleteFocus() when completeFocus != null:
return completeFocus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int? userHabitId,  int? userChallengeId)?  startFocus,TResult Function( int timerId,  int durationMinutes)?  completeFocus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StartFocus() when startFocus != null:
return startFocus(_that.userHabitId,_that.userChallengeId);case _CompleteFocus() when completeFocus != null:
return completeFocus(_that.timerId,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int? userHabitId,  int? userChallengeId)  startFocus,required TResult Function( int timerId,  int durationMinutes)  completeFocus,}) {final _that = this;
switch (_that) {
case _StartFocus():
return startFocus(_that.userHabitId,_that.userChallengeId);case _CompleteFocus():
return completeFocus(_that.timerId,_that.durationMinutes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int? userHabitId,  int? userChallengeId)?  startFocus,TResult? Function( int timerId,  int durationMinutes)?  completeFocus,}) {final _that = this;
switch (_that) {
case _StartFocus() when startFocus != null:
return startFocus(_that.userHabitId,_that.userChallengeId);case _CompleteFocus() when completeFocus != null:
return completeFocus(_that.timerId,_that.durationMinutes);case _:
  return null;

}
}

}

/// @nodoc


class _StartFocus implements FocusTimerEvent {
  const _StartFocus({this.userHabitId, this.userChallengeId});
  

 final  int? userHabitId;
 final  int? userChallengeId;

/// Create a copy of FocusTimerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartFocusCopyWith<_StartFocus> get copyWith => __$StartFocusCopyWithImpl<_StartFocus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StartFocus&&(identical(other.userHabitId, userHabitId) || other.userHabitId == userHabitId)&&(identical(other.userChallengeId, userChallengeId) || other.userChallengeId == userChallengeId));
}


@override
int get hashCode => Object.hash(runtimeType,userHabitId,userChallengeId);

@override
String toString() {
  return 'FocusTimerEvent.startFocus(userHabitId: $userHabitId, userChallengeId: $userChallengeId)';
}


}

/// @nodoc
abstract mixin class _$StartFocusCopyWith<$Res> implements $FocusTimerEventCopyWith<$Res> {
  factory _$StartFocusCopyWith(_StartFocus value, $Res Function(_StartFocus) _then) = __$StartFocusCopyWithImpl;
@useResult
$Res call({
 int? userHabitId, int? userChallengeId
});




}
/// @nodoc
class __$StartFocusCopyWithImpl<$Res>
    implements _$StartFocusCopyWith<$Res> {
  __$StartFocusCopyWithImpl(this._self, this._then);

  final _StartFocus _self;
  final $Res Function(_StartFocus) _then;

/// Create a copy of FocusTimerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userHabitId = freezed,Object? userChallengeId = freezed,}) {
  return _then(_StartFocus(
userHabitId: freezed == userHabitId ? _self.userHabitId : userHabitId // ignore: cast_nullable_to_non_nullable
as int?,userChallengeId: freezed == userChallengeId ? _self.userChallengeId : userChallengeId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

/// @nodoc


class _CompleteFocus implements FocusTimerEvent {
  const _CompleteFocus({required this.timerId, required this.durationMinutes});
  

 final  int timerId;
 final  int durationMinutes;

/// Create a copy of FocusTimerEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompleteFocusCopyWith<_CompleteFocus> get copyWith => __$CompleteFocusCopyWithImpl<_CompleteFocus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompleteFocus&&(identical(other.timerId, timerId) || other.timerId == timerId)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes));
}


@override
int get hashCode => Object.hash(runtimeType,timerId,durationMinutes);

@override
String toString() {
  return 'FocusTimerEvent.completeFocus(timerId: $timerId, durationMinutes: $durationMinutes)';
}


}

/// @nodoc
abstract mixin class _$CompleteFocusCopyWith<$Res> implements $FocusTimerEventCopyWith<$Res> {
  factory _$CompleteFocusCopyWith(_CompleteFocus value, $Res Function(_CompleteFocus) _then) = __$CompleteFocusCopyWithImpl;
@useResult
$Res call({
 int timerId, int durationMinutes
});




}
/// @nodoc
class __$CompleteFocusCopyWithImpl<$Res>
    implements _$CompleteFocusCopyWith<$Res> {
  __$CompleteFocusCopyWithImpl(this._self, this._then);

  final _CompleteFocus _self;
  final $Res Function(_CompleteFocus) _then;

/// Create a copy of FocusTimerEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timerId = null,Object? durationMinutes = null,}) {
  return _then(_CompleteFocus(
timerId: null == timerId ? _self.timerId : timerId // ignore: cast_nullable_to_non_nullable
as int,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$FocusTimerState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FocusTimerState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FocusTimerState()';
}


}

/// @nodoc
class $FocusTimerStateCopyWith<$Res>  {
$FocusTimerStateCopyWith(FocusTimerState _, $Res Function(FocusTimerState) __);
}


/// Adds pattern-matching-related methods to [FocusTimerState].
extension FocusTimerStatePatterns on FocusTimerState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Started value)?  started,TResult Function( _Completed value)?  completed,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Started() when started != null:
return started(_that);case _Completed() when completed != null:
return completed(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Started value)  started,required TResult Function( _Completed value)  completed,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Started():
return started(_that);case _Completed():
return completed(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Started value)?  started,TResult? Function( _Completed value)?  completed,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Started() when started != null:
return started(_that);case _Completed() when completed != null:
return completed(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( int timerId)?  started,TResult Function()?  completed,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Started() when started != null:
return started(_that.timerId);case _Completed() when completed != null:
return completed();case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( int timerId)  started,required TResult Function()  completed,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Started():
return started(_that.timerId);case _Completed():
return completed();case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( int timerId)?  started,TResult? Function()?  completed,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Started() when started != null:
return started(_that.timerId);case _Completed() when completed != null:
return completed();case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements FocusTimerState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FocusTimerState.initial()';
}


}




/// @nodoc


class _Loading implements FocusTimerState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FocusTimerState.loading()';
}


}




/// @nodoc


class _Started implements FocusTimerState {
  const _Started(this.timerId);
  

 final  int timerId;

/// Create a copy of FocusTimerState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StartedCopyWith<_Started> get copyWith => __$StartedCopyWithImpl<_Started>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started&&(identical(other.timerId, timerId) || other.timerId == timerId));
}


@override
int get hashCode => Object.hash(runtimeType,timerId);

@override
String toString() {
  return 'FocusTimerState.started(timerId: $timerId)';
}


}

/// @nodoc
abstract mixin class _$StartedCopyWith<$Res> implements $FocusTimerStateCopyWith<$Res> {
  factory _$StartedCopyWith(_Started value, $Res Function(_Started) _then) = __$StartedCopyWithImpl;
@useResult
$Res call({
 int timerId
});




}
/// @nodoc
class __$StartedCopyWithImpl<$Res>
    implements _$StartedCopyWith<$Res> {
  __$StartedCopyWithImpl(this._self, this._then);

  final _Started _self;
  final $Res Function(_Started) _then;

/// Create a copy of FocusTimerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? timerId = null,}) {
  return _then(_Started(
null == timerId ? _self.timerId : timerId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _Completed implements FocusTimerState {
  const _Completed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Completed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'FocusTimerState.completed()';
}


}




/// @nodoc


class _Error implements FocusTimerState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of FocusTimerState
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
  return 'FocusTimerState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $FocusTimerStateCopyWith<$Res> {
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

/// Create a copy of FocusTimerState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
