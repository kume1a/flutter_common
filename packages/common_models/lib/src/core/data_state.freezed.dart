// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'data_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$DataStateTearOff {
  const _$DataStateTearOff();

  _Success<F, T> success<F, T>(T data) {
    return _Success<F, T>(
      data,
    );
  }

  _Idle<F, T> idle<F, T>() {
    return _Idle<F, T>();
  }

  _Loading<F, T> loading<F, T>() {
    return _Loading<F, T>();
  }

  _Error<F, T> error<F, T>(F failure, [T? data]) {
    return _Error<F, T>(
      failure,
      data,
    );
  }
}

/// @nodoc
const $DataState = _$DataStateTearOff();

/// @nodoc
mixin _$DataState<F, T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(F failure, T? data) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, T> value) success,
    required TResult Function(_Idle<F, T> value) idle,
    required TResult Function(_Loading<F, T> value) loading,
    required TResult Function(_Error<F, T> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DataStateCopyWith<F, T, $Res> {
  factory $DataStateCopyWith(
          DataState<F, T> value, $Res Function(DataState<F, T>) then) =
      _$DataStateCopyWithImpl<F, T, $Res>;
}

/// @nodoc
class _$DataStateCopyWithImpl<F, T, $Res>
    implements $DataStateCopyWith<F, T, $Res> {
  _$DataStateCopyWithImpl(this._value, this._then);

  final DataState<F, T> _value;
  // ignore: unused_field
  final $Res Function(DataState<F, T>) _then;
}

/// @nodoc
abstract class _$SuccessCopyWith<F, T, $Res> {
  factory _$SuccessCopyWith(
          _Success<F, T> value, $Res Function(_Success<F, T>) then) =
      __$SuccessCopyWithImpl<F, T, $Res>;
  $Res call({T data});
}

/// @nodoc
class __$SuccessCopyWithImpl<F, T, $Res>
    extends _$DataStateCopyWithImpl<F, T, $Res>
    implements _$SuccessCopyWith<F, T, $Res> {
  __$SuccessCopyWithImpl(
      _Success<F, T> _value, $Res Function(_Success<F, T>) _then)
      : super(_value, (v) => _then(v as _Success<F, T>));

  @override
  _Success<F, T> get _value => super._value as _Success<F, T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_Success<F, T>(
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc

class _$_Success<F, T> extends _Success<F, T> {
  const _$_Success(this.data) : super._();

  @override
  final T data;

  @override
  String toString() {
    return 'DataState<$F, $T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Success<F, T> &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$SuccessCopyWith<F, T, _Success<F, T>> get copyWith =>
      __$SuccessCopyWithImpl<F, T, _Success<F, T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(F failure, T? data) error,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
  }) {
    return success?.call(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, T> value) success,
    required TResult Function(_Idle<F, T> value) idle,
    required TResult Function(_Loading<F, T> value) loading,
    required TResult Function(_Error<F, T> value) error,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
  }) {
    return success?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class _Success<F, T> extends DataState<F, T> {
  const factory _Success(T data) = _$_Success<F, T>;
  const _Success._() : super._();

  T get data;
  @JsonKey(ignore: true)
  _$SuccessCopyWith<F, T, _Success<F, T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$IdleCopyWith<F, T, $Res> {
  factory _$IdleCopyWith(_Idle<F, T> value, $Res Function(_Idle<F, T>) then) =
      __$IdleCopyWithImpl<F, T, $Res>;
}

/// @nodoc
class __$IdleCopyWithImpl<F, T, $Res>
    extends _$DataStateCopyWithImpl<F, T, $Res>
    implements _$IdleCopyWith<F, T, $Res> {
  __$IdleCopyWithImpl(_Idle<F, T> _value, $Res Function(_Idle<F, T>) _then)
      : super(_value, (v) => _then(v as _Idle<F, T>));

  @override
  _Idle<F, T> get _value => super._value as _Idle<F, T>;
}

/// @nodoc

class _$_Idle<F, T> extends _Idle<F, T> {
  const _$_Idle() : super._();

  @override
  String toString() {
    return 'DataState<$F, $T>.idle()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Idle<F, T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(F failure, T? data) error,
  }) {
    return idle();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
  }) {
    return idle?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, T> value) success,
    required TResult Function(_Idle<F, T> value) idle,
    required TResult Function(_Loading<F, T> value) loading,
    required TResult Function(_Error<F, T> value) error,
  }) {
    return idle(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
  }) {
    return idle?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
    required TResult orElse(),
  }) {
    if (idle != null) {
      return idle(this);
    }
    return orElse();
  }
}

abstract class _Idle<F, T> extends DataState<F, T> {
  const factory _Idle() = _$_Idle<F, T>;
  const _Idle._() : super._();
}

/// @nodoc
abstract class _$LoadingCopyWith<F, T, $Res> {
  factory _$LoadingCopyWith(
          _Loading<F, T> value, $Res Function(_Loading<F, T>) then) =
      __$LoadingCopyWithImpl<F, T, $Res>;
}

/// @nodoc
class __$LoadingCopyWithImpl<F, T, $Res>
    extends _$DataStateCopyWithImpl<F, T, $Res>
    implements _$LoadingCopyWith<F, T, $Res> {
  __$LoadingCopyWithImpl(
      _Loading<F, T> _value, $Res Function(_Loading<F, T>) _then)
      : super(_value, (v) => _then(v as _Loading<F, T>));

  @override
  _Loading<F, T> get _value => super._value as _Loading<F, T>;
}

/// @nodoc

class _$_Loading<F, T> extends _Loading<F, T> {
  const _$_Loading() : super._();

  @override
  String toString() {
    return 'DataState<$F, $T>.loading()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Loading<F, T>);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(F failure, T? data) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, T> value) success,
    required TResult Function(_Idle<F, T> value) idle,
    required TResult Function(_Loading<F, T> value) loading,
    required TResult Function(_Error<F, T> value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class _Loading<F, T> extends DataState<F, T> {
  const factory _Loading() = _$_Loading<F, T>;
  const _Loading._() : super._();
}

/// @nodoc
abstract class _$ErrorCopyWith<F, T, $Res> {
  factory _$ErrorCopyWith(
          _Error<F, T> value, $Res Function(_Error<F, T>) then) =
      __$ErrorCopyWithImpl<F, T, $Res>;
  $Res call({F failure, T? data});
}

/// @nodoc
class __$ErrorCopyWithImpl<F, T, $Res>
    extends _$DataStateCopyWithImpl<F, T, $Res>
    implements _$ErrorCopyWith<F, T, $Res> {
  __$ErrorCopyWithImpl(_Error<F, T> _value, $Res Function(_Error<F, T>) _then)
      : super(_value, (v) => _then(v as _Error<F, T>));

  @override
  _Error<F, T> get _value => super._value as _Error<F, T>;

  @override
  $Res call({
    Object? failure = freezed,
    Object? data = freezed,
  }) {
    return _then(_Error<F, T>(
      failure == freezed
          ? _value.failure
          : failure // ignore: cast_nullable_to_non_nullable
              as F,
      data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T?,
    ));
  }
}

/// @nodoc

class _$_Error<F, T> extends _Error<F, T> {
  const _$_Error(this.failure, [this.data]) : super._();

  @override
  final F failure;
  @override
  final T? data;

  @override
  String toString() {
    return 'DataState<$F, $T>.error(failure: $failure, data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Error<F, T> &&
            const DeepCollectionEquality().equals(other.failure, failure) &&
            const DeepCollectionEquality().equals(other.data, data));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(failure),
      const DeepCollectionEquality().hash(data));

  @JsonKey(ignore: true)
  @override
  _$ErrorCopyWith<F, T, _Error<F, T>> get copyWith =>
      __$ErrorCopyWithImpl<F, T, _Error<F, T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function() idle,
    required TResult Function() loading,
    required TResult Function(F failure, T? data) error,
  }) {
    return error(failure, data);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
  }) {
    return error?.call(failure, data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function()? idle,
    TResult Function()? loading,
    TResult Function(F failure, T? data)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(failure, data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Success<F, T> value) success,
    required TResult Function(_Idle<F, T> value) idle,
    required TResult Function(_Loading<F, T> value) loading,
    required TResult Function(_Error<F, T> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Success<F, T> value)? success,
    TResult Function(_Idle<F, T> value)? idle,
    TResult Function(_Loading<F, T> value)? loading,
    TResult Function(_Error<F, T> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class _Error<F, T> extends DataState<F, T> {
  const factory _Error(F failure, [T? data]) = _$_Error<F, T>;
  const _Error._() : super._();

  F get failure;
  T? get data;
  @JsonKey(ignore: true)
  _$ErrorCopyWith<F, T, _Error<F, T>> get copyWith =>
      throw _privateConstructorUsedError;
}
