import 'dart:async';

import 'package:collection/collection.dart';

import '../core/either.dart';
import '../core/result.dart';

sealed class SimpleDataState<T> {
  const SimpleDataState();

  factory SimpleDataState.success(T data) => _Success<T>(data);

  factory SimpleDataState.idle() => _Idle<T>();

  factory SimpleDataState.loading() => _Loading<T>();

  factory SimpleDataState.failure([T? data]) => _Failure<T>(data);

  factory SimpleDataState.fromEither(Either<dynamic, T> either) => either.fold(
        (_) => SimpleDataState<T>.failure(),
        (T r) => SimpleDataState<T>.success(r),
      );

  factory SimpleDataState.fromResult(Result<T> result) => result.fold(
        () => SimpleDataState<T>.failure(),
        (T r) => SimpleDataState<T>.success(r),
      );

  A when<A extends Object?>({
    required A Function() idle,
    required A Function(T data) success,
    required A Function() loading,
    required A Function(T? data) failure,
  }) {
    return switch (this) {
      _Idle<T> _ => idle(),
      final _Success<T> value => success(value.data),
      _Loading<T> _ => loading(),
      final _Failure<T> value => failure(value.data),
      _ => throw Exception('unsupported subclass'),
    };
  }

  A maybeWhen<A extends Object?>({
    required A Function() orElse,
    A Function()? idle,
    A Function(T data)? success,
    A Function()? loading,
    A Function(T? data)? failure,
  }) {
    return switch (this) {
      _Idle<T> _ => idle != null ? idle() : orElse(),
      final _Success<T> value => success != null ? success(value.data) : orElse(),
      _Loading<T> _ => loading != null ? loading() : orElse(),
      final _Failure<T> value => failure != null ? failure(value.data) : orElse(),
      _ => throw Exception('unsupported subclass'),
    };
  }

  A? whenOrNull<A extends Object?>({
    A Function()? idle,
    A Function(T data)? success,
    A Function()? loading,
    A Function(T? data)? failure,
  }) {
    return switch (this) {
      _Idle<T> _ => idle?.call(),
      final _Success<T> value => success?.call(value.data),
      _Loading<T> _ => loading?.call(),
      final _Failure<T> value => failure?.call(value.data),
      _ => throw Exception('unsupported subclass'),
    };
  }

  A ifData<A extends Object?>(
    A Function(T data) ifData, {
    required A Function() orElse,
  }) {
    return maybeWhen<A>(
      success: (data) => ifData(data),
      failure: (data) => data != null ? ifData(data) : orElse(),
      orElse: orElse,
    );
  }

  T dataOrElse(T Function() orElse) => maybeWhen(
        success: (data) => data,
        failure: (data) => data ?? orElse(),
        orElse: orElse,
      );

  bool get isIdle => maybeWhen(idle: () => true, orElse: () => false);

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);

  bool get isFailure => maybeWhen(failure: (_) => true, orElse: () => false);

  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);

  bool get hasData => maybeWhen(
        success: (_) => true,
        failure: (T? data) => data != null,
        orElse: () => false,
      );

  T get getOrThrow => maybeWhen(
        success: (T data) => data,
        failure: (T? data) => data!,
        orElse: () => throw Exception('getOrThrow called on no data'),
      );

  T? get getOrNull => maybeWhen(
        success: (T data) => data,
        failure: (T? data) => data,
        orElse: () => null,
      );

  FutureOr<SimpleDataState<T>> map(
    FutureOr<T?> Function(T data) modifier,
  ) async {
    return maybeWhen(
      success: (T data) async {
        final T? newData = await modifier.call(data);
        if (newData != null) {
          return SimpleDataState<T>.success(newData);
        }
        return this;
      },
      failure: (T? data) async {
        if (data != null) {
          final T? newData = await modifier.call(data);
          if (newData != null) {
            return SimpleDataState<T>.failure(newData);
          }
        }
        return this;
      },
      orElse: () => this,
    );
  }
}

class _Idle<T> extends SimpleDataState<T> {
  const _Idle() : super();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Idle<T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'SimpleDataState._Idle';
}

class _Success<T> extends SimpleDataState<T> {
  const _Success(this.data) : super();

  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Success<T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() => 'SimpleDataState._Success{data: $data}';
}

class _Loading<T> extends SimpleDataState<T> {
  const _Loading() : super();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Loading<T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'SimpleDataState._Loading';
}

class _Failure<T> extends SimpleDataState<T> {
  const _Failure(this.data) : super();

  final T? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failure<T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(data),
      );

  @override
  String toString() => 'DataState._Failure{data: $data}';
}
