// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_challenge_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$UserChallengeEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserChallengeEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserChallengeEvent()';
}


}

/// @nodoc
class $UserChallengeEventCopyWith<$Res>  {
$UserChallengeEventCopyWith(UserChallengeEvent _, $Res Function(UserChallengeEvent) __);
}


/// Adds pattern-matching-related methods to [UserChallengeEvent].
extension UserChallengeEventPatterns on UserChallengeEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Started value)?  started,TResult Function( _FetchUserChallenges value)?  fetchUserChallenges,TResult Function( _JoinChallenge value)?  joinChallenge,TResult Function( _CheckInChallenge value)?  checkInChallenge,TResult Function( _ReviveChallenge value)?  reviveChallenge,TResult Function( _DeleteChallenge value)?  deleteChallenge,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchUserChallenges() when fetchUserChallenges != null:
return fetchUserChallenges(_that);case _JoinChallenge() when joinChallenge != null:
return joinChallenge(_that);case _CheckInChallenge() when checkInChallenge != null:
return checkInChallenge(_that);case _ReviveChallenge() when reviveChallenge != null:
return reviveChallenge(_that);case _DeleteChallenge() when deleteChallenge != null:
return deleteChallenge(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Started value)  started,required TResult Function( _FetchUserChallenges value)  fetchUserChallenges,required TResult Function( _JoinChallenge value)  joinChallenge,required TResult Function( _CheckInChallenge value)  checkInChallenge,required TResult Function( _ReviveChallenge value)  reviveChallenge,required TResult Function( _DeleteChallenge value)  deleteChallenge,}){
final _that = this;
switch (_that) {
case _Started():
return started(_that);case _FetchUserChallenges():
return fetchUserChallenges(_that);case _JoinChallenge():
return joinChallenge(_that);case _CheckInChallenge():
return checkInChallenge(_that);case _ReviveChallenge():
return reviveChallenge(_that);case _DeleteChallenge():
return deleteChallenge(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Started value)?  started,TResult? Function( _FetchUserChallenges value)?  fetchUserChallenges,TResult? Function( _JoinChallenge value)?  joinChallenge,TResult? Function( _CheckInChallenge value)?  checkInChallenge,TResult? Function( _ReviveChallenge value)?  reviveChallenge,TResult? Function( _DeleteChallenge value)?  deleteChallenge,}){
final _that = this;
switch (_that) {
case _Started() when started != null:
return started(_that);case _FetchUserChallenges() when fetchUserChallenges != null:
return fetchUserChallenges(_that);case _JoinChallenge() when joinChallenge != null:
return joinChallenge(_that);case _CheckInChallenge() when checkInChallenge != null:
return checkInChallenge(_that);case _ReviveChallenge() when reviveChallenge != null:
return reviveChallenge(_that);case _DeleteChallenge() when deleteChallenge != null:
return deleteChallenge(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  fetchUserChallenges,TResult Function( int challengeId)?  joinChallenge,TResult Function( int id)?  checkInChallenge,TResult Function( int id)?  reviveChallenge,TResult Function( int id)?  deleteChallenge,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchUserChallenges() when fetchUserChallenges != null:
return fetchUserChallenges();case _JoinChallenge() when joinChallenge != null:
return joinChallenge(_that.challengeId);case _CheckInChallenge() when checkInChallenge != null:
return checkInChallenge(_that.id);case _ReviveChallenge() when reviveChallenge != null:
return reviveChallenge(_that.id);case _DeleteChallenge() when deleteChallenge != null:
return deleteChallenge(_that.id);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  fetchUserChallenges,required TResult Function( int challengeId)  joinChallenge,required TResult Function( int id)  checkInChallenge,required TResult Function( int id)  reviveChallenge,required TResult Function( int id)  deleteChallenge,}) {final _that = this;
switch (_that) {
case _Started():
return started();case _FetchUserChallenges():
return fetchUserChallenges();case _JoinChallenge():
return joinChallenge(_that.challengeId);case _CheckInChallenge():
return checkInChallenge(_that.id);case _ReviveChallenge():
return reviveChallenge(_that.id);case _DeleteChallenge():
return deleteChallenge(_that.id);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  fetchUserChallenges,TResult? Function( int challengeId)?  joinChallenge,TResult? Function( int id)?  checkInChallenge,TResult? Function( int id)?  reviveChallenge,TResult? Function( int id)?  deleteChallenge,}) {final _that = this;
switch (_that) {
case _Started() when started != null:
return started();case _FetchUserChallenges() when fetchUserChallenges != null:
return fetchUserChallenges();case _JoinChallenge() when joinChallenge != null:
return joinChallenge(_that.challengeId);case _CheckInChallenge() when checkInChallenge != null:
return checkInChallenge(_that.id);case _ReviveChallenge() when reviveChallenge != null:
return reviveChallenge(_that.id);case _DeleteChallenge() when deleteChallenge != null:
return deleteChallenge(_that.id);case _:
  return null;

}
}

}

/// @nodoc


class _Started implements UserChallengeEvent {
  const _Started();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Started);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserChallengeEvent.started()';
}


}




/// @nodoc


class _FetchUserChallenges implements UserChallengeEvent {
  const _FetchUserChallenges();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FetchUserChallenges);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserChallengeEvent.fetchUserChallenges()';
}


}




/// @nodoc


class _JoinChallenge implements UserChallengeEvent {
  const _JoinChallenge(this.challengeId);
  

 final  int challengeId;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JoinChallengeCopyWith<_JoinChallenge> get copyWith => __$JoinChallengeCopyWithImpl<_JoinChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JoinChallenge&&(identical(other.challengeId, challengeId) || other.challengeId == challengeId));
}


@override
int get hashCode => Object.hash(runtimeType,challengeId);

@override
String toString() {
  return 'UserChallengeEvent.joinChallenge(challengeId: $challengeId)';
}


}

/// @nodoc
abstract mixin class _$JoinChallengeCopyWith<$Res> implements $UserChallengeEventCopyWith<$Res> {
  factory _$JoinChallengeCopyWith(_JoinChallenge value, $Res Function(_JoinChallenge) _then) = __$JoinChallengeCopyWithImpl;
@useResult
$Res call({
 int challengeId
});




}
/// @nodoc
class __$JoinChallengeCopyWithImpl<$Res>
    implements _$JoinChallengeCopyWith<$Res> {
  __$JoinChallengeCopyWithImpl(this._self, this._then);

  final _JoinChallenge _self;
  final $Res Function(_JoinChallenge) _then;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? challengeId = null,}) {
  return _then(_JoinChallenge(
null == challengeId ? _self.challengeId : challengeId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _CheckInChallenge implements UserChallengeEvent {
  const _CheckInChallenge(this.id);
  

 final  int id;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckInChallengeCopyWith<_CheckInChallenge> get copyWith => __$CheckInChallengeCopyWithImpl<_CheckInChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckInChallenge&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'UserChallengeEvent.checkInChallenge(id: $id)';
}


}

/// @nodoc
abstract mixin class _$CheckInChallengeCopyWith<$Res> implements $UserChallengeEventCopyWith<$Res> {
  factory _$CheckInChallengeCopyWith(_CheckInChallenge value, $Res Function(_CheckInChallenge) _then) = __$CheckInChallengeCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$CheckInChallengeCopyWithImpl<$Res>
    implements _$CheckInChallengeCopyWith<$Res> {
  __$CheckInChallengeCopyWithImpl(this._self, this._then);

  final _CheckInChallenge _self;
  final $Res Function(_CheckInChallenge) _then;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_CheckInChallenge(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _ReviveChallenge implements UserChallengeEvent {
  const _ReviveChallenge(this.id);
  

 final  int id;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviveChallengeCopyWith<_ReviveChallenge> get copyWith => __$ReviveChallengeCopyWithImpl<_ReviveChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviveChallenge&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'UserChallengeEvent.reviveChallenge(id: $id)';
}


}

/// @nodoc
abstract mixin class _$ReviveChallengeCopyWith<$Res> implements $UserChallengeEventCopyWith<$Res> {
  factory _$ReviveChallengeCopyWith(_ReviveChallenge value, $Res Function(_ReviveChallenge) _then) = __$ReviveChallengeCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$ReviveChallengeCopyWithImpl<$Res>
    implements _$ReviveChallengeCopyWith<$Res> {
  __$ReviveChallengeCopyWithImpl(this._self, this._then);

  final _ReviveChallenge _self;
  final $Res Function(_ReviveChallenge) _then;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_ReviveChallenge(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class _DeleteChallenge implements UserChallengeEvent {
  const _DeleteChallenge(this.id);
  

 final  int id;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DeleteChallengeCopyWith<_DeleteChallenge> get copyWith => __$DeleteChallengeCopyWithImpl<_DeleteChallenge>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DeleteChallenge&&(identical(other.id, id) || other.id == id));
}


@override
int get hashCode => Object.hash(runtimeType,id);

@override
String toString() {
  return 'UserChallengeEvent.deleteChallenge(id: $id)';
}


}

/// @nodoc
abstract mixin class _$DeleteChallengeCopyWith<$Res> implements $UserChallengeEventCopyWith<$Res> {
  factory _$DeleteChallengeCopyWith(_DeleteChallenge value, $Res Function(_DeleteChallenge) _then) = __$DeleteChallengeCopyWithImpl;
@useResult
$Res call({
 int id
});




}
/// @nodoc
class __$DeleteChallengeCopyWithImpl<$Res>
    implements _$DeleteChallengeCopyWith<$Res> {
  __$DeleteChallengeCopyWithImpl(this._self, this._then);

  final _DeleteChallenge _self;
  final $Res Function(_DeleteChallenge) _then;

/// Create a copy of UserChallengeEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? id = null,}) {
  return _then(_DeleteChallenge(
null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$UserChallengeState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserChallengeState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserChallengeState()';
}


}

/// @nodoc
class $UserChallengeStateCopyWith<$Res>  {
$UserChallengeStateCopyWith(UserChallengeState _, $Res Function(UserChallengeState) __);
}


/// Adds pattern-matching-related methods to [UserChallengeState].
extension UserChallengeStatePatterns on UserChallengeState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _Initial value)?  initial,TResult Function( _Loading value)?  loading,TResult Function( _Success value)?  success,TResult Function( _NeedRevive value)?  needRevive,TResult Function( _Error value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _NeedRevive() when needRevive != null:
return needRevive(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _Initial value)  initial,required TResult Function( _Loading value)  loading,required TResult Function( _Success value)  success,required TResult Function( _NeedRevive value)  needRevive,required TResult Function( _Error value)  error,}){
final _that = this;
switch (_that) {
case _Initial():
return initial(_that);case _Loading():
return loading(_that);case _Success():
return success(_that);case _NeedRevive():
return needRevive(_that);case _Error():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _Initial value)?  initial,TResult? Function( _Loading value)?  loading,TResult? Function( _Success value)?  success,TResult? Function( _NeedRevive value)?  needRevive,TResult? Function( _Error value)?  error,}){
final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial(_that);case _Loading() when loading != null:
return loading(_that);case _Success() when success != null:
return success(_that);case _NeedRevive() when needRevive != null:
return needRevive(_that);case _Error() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( List<UserChallenge> challenges)?  success,TResult Function( int userChallengeId,  String message)?  needRevive,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.challenges);case _NeedRevive() when needRevive != null:
return needRevive(_that.userChallengeId,_that.message);case _Error() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( List<UserChallenge> challenges)  success,required TResult Function( int userChallengeId,  String message)  needRevive,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case _Initial():
return initial();case _Loading():
return loading();case _Success():
return success(_that.challenges);case _NeedRevive():
return needRevive(_that.userChallengeId,_that.message);case _Error():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( List<UserChallenge> challenges)?  success,TResult? Function( int userChallengeId,  String message)?  needRevive,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case _Initial() when initial != null:
return initial();case _Loading() when loading != null:
return loading();case _Success() when success != null:
return success(_that.challenges);case _NeedRevive() when needRevive != null:
return needRevive(_that.userChallengeId,_that.message);case _Error() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _Initial implements UserChallengeState {
  const _Initial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Initial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserChallengeState.initial()';
}


}




/// @nodoc


class _Loading implements UserChallengeState {
  const _Loading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Loading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'UserChallengeState.loading()';
}


}




/// @nodoc


class _Success implements UserChallengeState {
  const _Success(final  List<UserChallenge> challenges): _challenges = challenges;
  

 final  List<UserChallenge> _challenges;
 List<UserChallenge> get challenges {
  if (_challenges is EqualUnmodifiableListView) return _challenges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_challenges);
}


/// Create a copy of UserChallengeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SuccessCopyWith<_Success> get copyWith => __$SuccessCopyWithImpl<_Success>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Success&&const DeepCollectionEquality().equals(other._challenges, _challenges));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_challenges));

@override
String toString() {
  return 'UserChallengeState.success(challenges: $challenges)';
}


}

/// @nodoc
abstract mixin class _$SuccessCopyWith<$Res> implements $UserChallengeStateCopyWith<$Res> {
  factory _$SuccessCopyWith(_Success value, $Res Function(_Success) _then) = __$SuccessCopyWithImpl;
@useResult
$Res call({
 List<UserChallenge> challenges
});




}
/// @nodoc
class __$SuccessCopyWithImpl<$Res>
    implements _$SuccessCopyWith<$Res> {
  __$SuccessCopyWithImpl(this._self, this._then);

  final _Success _self;
  final $Res Function(_Success) _then;

/// Create a copy of UserChallengeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? challenges = null,}) {
  return _then(_Success(
null == challenges ? _self._challenges : challenges // ignore: cast_nullable_to_non_nullable
as List<UserChallenge>,
  ));
}


}

/// @nodoc


class _NeedRevive implements UserChallengeState {
  const _NeedRevive(this.userChallengeId, this.message);
  

 final  int userChallengeId;
 final  String message;

/// Create a copy of UserChallengeState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NeedReviveCopyWith<_NeedRevive> get copyWith => __$NeedReviveCopyWithImpl<_NeedRevive>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NeedRevive&&(identical(other.userChallengeId, userChallengeId) || other.userChallengeId == userChallengeId)&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,userChallengeId,message);

@override
String toString() {
  return 'UserChallengeState.needRevive(userChallengeId: $userChallengeId, message: $message)';
}


}

/// @nodoc
abstract mixin class _$NeedReviveCopyWith<$Res> implements $UserChallengeStateCopyWith<$Res> {
  factory _$NeedReviveCopyWith(_NeedRevive value, $Res Function(_NeedRevive) _then) = __$NeedReviveCopyWithImpl;
@useResult
$Res call({
 int userChallengeId, String message
});




}
/// @nodoc
class __$NeedReviveCopyWithImpl<$Res>
    implements _$NeedReviveCopyWith<$Res> {
  __$NeedReviveCopyWithImpl(this._self, this._then);

  final _NeedRevive _self;
  final $Res Function(_NeedRevive) _then;

/// Create a copy of UserChallengeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? userChallengeId = null,Object? message = null,}) {
  return _then(_NeedRevive(
null == userChallengeId ? _self.userChallengeId : userChallengeId // ignore: cast_nullable_to_non_nullable
as int,null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class _Error implements UserChallengeState {
  const _Error(this.message);
  

 final  String message;

/// Create a copy of UserChallengeState
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
  return 'UserChallengeState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class _$ErrorCopyWith<$Res> implements $UserChallengeStateCopyWith<$Res> {
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

/// Create a copy of UserChallengeState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_Error(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
