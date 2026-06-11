// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reflection_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReflectionEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReflectionEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReflectionEvent()';
}


}

/// @nodoc
class $ReflectionEventCopyWith<$Res>  {
$ReflectionEventCopyWith(ReflectionEvent _, $Res Function(ReflectionEvent) __);
}


/// Adds pattern-matching-related methods to [ReflectionEvent].
extension ReflectionEventPatterns on ReflectionEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _GetReflections value)?  getReflections,TResult Function( _GetTodayReflection value)?  getTodayReflection,TResult Function( _SaveReflection value)?  saveReflection,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _GetReflections() when getReflections != null:
return getReflections(_that);case _GetTodayReflection() when getTodayReflection != null:
return getTodayReflection(_that);case _SaveReflection() when saveReflection != null:
return saveReflection(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _GetReflections value)  getReflections,required TResult Function( _GetTodayReflection value)  getTodayReflection,required TResult Function( _SaveReflection value)  saveReflection,}){
final _that = this;
switch (_that) {
case _GetReflections():
return getReflections(_that);case _GetTodayReflection():
return getTodayReflection(_that);case _SaveReflection():
return saveReflection(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _GetReflections value)?  getReflections,TResult? Function( _GetTodayReflection value)?  getTodayReflection,TResult? Function( _SaveReflection value)?  saveReflection,}){
final _that = this;
switch (_that) {
case _GetReflections() when getReflections != null:
return getReflections(_that);case _GetTodayReflection() when getTodayReflection != null:
return getTodayReflection(_that);case _SaveReflection() when saveReflection != null:
return saveReflection(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  getReflections,TResult Function()?  getTodayReflection,TResult Function( ReflectionRequestModel request)?  saveReflection,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _GetReflections() when getReflections != null:
return getReflections();case _GetTodayReflection() when getTodayReflection != null:
return getTodayReflection();case _SaveReflection() when saveReflection != null:
return saveReflection(_that.request);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  getReflections,required TResult Function()  getTodayReflection,required TResult Function( ReflectionRequestModel request)  saveReflection,}) {final _that = this;
switch (_that) {
case _GetReflections():
return getReflections();case _GetTodayReflection():
return getTodayReflection();case _SaveReflection():
return saveReflection(_that.request);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  getReflections,TResult? Function()?  getTodayReflection,TResult? Function( ReflectionRequestModel request)?  saveReflection,}) {final _that = this;
switch (_that) {
case _GetReflections() when getReflections != null:
return getReflections();case _GetTodayReflection() when getTodayReflection != null:
return getTodayReflection();case _SaveReflection() when saveReflection != null:
return saveReflection(_that.request);case _:
  return null;

}
}

}

/// @nodoc


class _GetReflections implements ReflectionEvent {
  const _GetReflections();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetReflections);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReflectionEvent.getReflections()';
}


}




/// @nodoc


class _GetTodayReflection implements ReflectionEvent {
  const _GetTodayReflection();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GetTodayReflection);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReflectionEvent.getTodayReflection()';
}


}




/// @nodoc


class _SaveReflection implements ReflectionEvent {
  const _SaveReflection(this.request);
  

 final  ReflectionRequestModel request;

/// Create a copy of ReflectionEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveReflectionCopyWith<_SaveReflection> get copyWith => __$SaveReflectionCopyWithImpl<_SaveReflection>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveReflection&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'ReflectionEvent.saveReflection(request: $request)';
}


}

/// @nodoc
abstract mixin class _$SaveReflectionCopyWith<$Res> implements $ReflectionEventCopyWith<$Res> {
  factory _$SaveReflectionCopyWith(_SaveReflection value, $Res Function(_SaveReflection) _then) = __$SaveReflectionCopyWithImpl;
@useResult
$Res call({
 ReflectionRequestModel request
});




}
/// @nodoc
class __$SaveReflectionCopyWithImpl<$Res>
    implements _$SaveReflectionCopyWith<$Res> {
  __$SaveReflectionCopyWithImpl(this._self, this._then);

  final _SaveReflection _self;
  final $Res Function(_SaveReflection) _then;

/// Create a copy of ReflectionEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(_SaveReflection(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as ReflectionRequestModel,
  ));
}


}

/// @nodoc
mixin _$ReflectionState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReflectionState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReflectionState()';
}


}

/// @nodoc
class $ReflectionStateCopyWith<$Res>  {
$ReflectionStateCopyWith(ReflectionState _, $Res Function(ReflectionState) __);
}


/// Adds pattern-matching-related methods to [ReflectionState].
extension ReflectionStatePatterns on ReflectionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Loaded value)?  loaded,TResult Function( _TodayLoaded value)?  todayLoaded,TResult Function( _SaveSuccess value)?  saveSuccess,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _TodayLoaded() when todayLoaded != null:
return todayLoaded(_that);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Loaded value)  loaded,required TResult Function( _TodayLoaded value)  todayLoaded,required TResult Function( _SaveSuccess value)  saveSuccess,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Loaded():
return loaded(_that);case _TodayLoaded():
return todayLoaded(_that);case _SaveSuccess():
return saveSuccess(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Loaded value)?  loaded,TResult? Function( _TodayLoaded value)?  todayLoaded,TResult? Function( _SaveSuccess value)?  saveSuccess,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Loaded() when loaded != null:
return loaded(_that);case _TodayLoaded() when todayLoaded != null:
return todayLoaded(_that);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<Reflection> reflections)?  loaded,TResult Function( Reflection? reflection)?  todayLoaded,TResult Function( Reflection reflection)?  saveSuccess,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.reflections);case _TodayLoaded() when todayLoaded != null:
return todayLoaded(_that.reflection);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that.reflection);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<Reflection> reflections)  loaded,required TResult Function( Reflection? reflection)  todayLoaded,required TResult Function( Reflection reflection)  saveSuccess,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Loaded():
return loaded(_that.reflections);case _TodayLoaded():
return todayLoaded(_that.reflection);case _SaveSuccess():
return saveSuccess(_that.reflection);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<Reflection> reflections)?  loaded,TResult? Function( Reflection? reflection)?  todayLoaded,TResult? Function( Reflection reflection)?  saveSuccess,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Loaded() when loaded != null:
return loaded(_that.reflections);case _TodayLoaded() when todayLoaded != null:
return todayLoaded(_that.reflection);case _SaveSuccess() when saveSuccess != null:
return saveSuccess(_that.reflection);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements ReflectionState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReflectionState.initial()';
}


}




/// @nodoc


class _Loading implements ReflectionState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ReflectionState.loading()';
}


}




/// @nodoc


class _Loaded implements ReflectionState {
  const _Loaded(final  List<Reflection> reflections): _reflections = reflections;
  

 final  List<Reflection> _reflections;
 List<Reflection> get reflections {
  if (_reflections is EqualUnmodifiableListView) return _reflections;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reflections);
}


/// Create a copy of ReflectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoadedCopyWith<_Loaded> get copyWith => __$LoadedCopyWithImpl<_Loaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loaded&&const DeepCollectionEquality().equals(other._reflections, _reflections));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reflections));

@override
String toString() {
  return 'ReflectionState.loaded(reflections: $reflections)';
}


}

/// @nodoc
abstract mixin class _$LoadedCopyWith<$Res> implements $ReflectionStateCopyWith<$Res> {
  factory _$LoadedCopyWith(_Loaded value, $Res Function(_Loaded) _then) = __$LoadedCopyWithImpl;
@useResult
$Res call({
 List<Reflection> reflections
});




}
/// @nodoc
class __$LoadedCopyWithImpl<$Res>
    implements _$LoadedCopyWith<$Res> {
  __$LoadedCopyWithImpl(this._self, this._then);

  final _Loaded _self;
  final $Res Function(_Loaded) _then;

/// Create a copy of ReflectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reflections = null,}) {
  return _then(_Loaded(
null == reflections ? _self._reflections : reflections // ignore: cast_nullable_to_non_nullable
as List<Reflection>,
  ));
}


}

/// @nodoc


class _TodayLoaded implements ReflectionState {
  const _TodayLoaded(this.reflection);
  

 final  Reflection? reflection;

/// Create a copy of ReflectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TodayLoadedCopyWith<_TodayLoaded> get copyWith => __$TodayLoadedCopyWithImpl<_TodayLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TodayLoaded&&(identical(other.reflection, reflection) || other.reflection == reflection));
}


@override
int get hashCode => Object.hash(runtimeType,reflection);

@override
String toString() {
  return 'ReflectionState.todayLoaded(reflection: $reflection)';
}


}

/// @nodoc
abstract mixin class _$TodayLoadedCopyWith<$Res> implements $ReflectionStateCopyWith<$Res> {
  factory _$TodayLoadedCopyWith(_TodayLoaded value, $Res Function(_TodayLoaded) _then) = __$TodayLoadedCopyWithImpl;
@useResult
$Res call({
 Reflection? reflection
});




}
/// @nodoc
class __$TodayLoadedCopyWithImpl<$Res>
    implements _$TodayLoadedCopyWith<$Res> {
  __$TodayLoadedCopyWithImpl(this._self, this._then);

  final _TodayLoaded _self;
  final $Res Function(_TodayLoaded) _then;

/// Create a copy of ReflectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reflection = freezed,}) {
  return _then(_TodayLoaded(
freezed == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as Reflection?,
  ));
}


}

/// @nodoc


class _SaveSuccess implements ReflectionState {
  const _SaveSuccess(this.reflection);
  

 final  Reflection reflection;

/// Create a copy of ReflectionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SaveSuccessCopyWith<_SaveSuccess> get copyWith => __$SaveSuccessCopyWithImpl<_SaveSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SaveSuccess&&(identical(other.reflection, reflection) || other.reflection == reflection));
}


@override
int get hashCode => Object.hash(runtimeType,reflection);

@override
String toString() {
  return 'ReflectionState.saveSuccess(reflection: $reflection)';
}


}

/// @nodoc
abstract mixin class _$SaveSuccessCopyWith<$Res> implements $ReflectionStateCopyWith<$Res> {
  factory _$SaveSuccessCopyWith(_SaveSuccess value, $Res Function(_SaveSuccess) _then) = __$SaveSuccessCopyWithImpl;
@useResult
$Res call({
 Reflection reflection
});




}
/// @nodoc
class __$SaveSuccessCopyWithImpl<$Res>
    implements _$SaveSuccessCopyWith<$Res> {
  __$SaveSuccessCopyWithImpl(this._self, this._then);

  final _SaveSuccess _self;
  final $Res Function(_SaveSuccess) _then;

/// Create a copy of ReflectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? reflection = null,}) {
  return _then(_SaveSuccess(
null == reflection ? _self.reflection : reflection // ignore: cast_nullable_to_non_nullable
as Reflection,
  ));
}


}

/// @nodoc


class _Error implements ReflectionState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of ReflectionState
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
  return 'ReflectionState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $ReflectionStateCopyWith<$Res> {
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

/// Create a copy of ReflectionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
