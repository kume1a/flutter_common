import 'dart:async';

import 'package:collection/collection.dart';

import '../core/either.dart';

abstract class SimpleDataState<T> {
  const SimpleDataState._();

  factory SimpleDataState.success(T data) => _Success<T>._(data);

  factory SimpleDataState.idle() => _Idle<T>._();

  factory SimpleDataState.loading() => _Loading<T>._();

  factory SimpleDataState.failure([T? data]) => _Failure<T>._(data);

  factory SimpleDataState.fromEither(Either<dynamic, T> either) => either.fold(
        (_) => SimpleDataState<T>.failure(),
        (T r) => SimpleDataState<T>.success(r),
      );

  A when<A extends Object?>({
    required A Function() idle,
    required A Function(T data) success,
    required A Function() loading,
    required A Function(T? data) failure,
  }) {
    if (this is _Idle<T>) {
      return idle();
    } else if (this is _Success<T>) {
      final _Success<T> value = this as _Success<T>;
      return success(value.data);
    } else if (this is _Loading<T>) {
      return loading();
    } else if (this is _Failure<T>) {
      final _Failure<T> value = this as _Failure<T>;
      return failure(value.data);
    }

    throw Exception('unsupported subclass');
  }

  A maybeWhen<A extends Object?>({
    required A Function() orElse,
    A Function()? idle,
    A Function(T data)? success,
    A Function()? loading,
    A Function(T? data)? failure,
  }) {
    if (this is _Idle<T>) {
      return idle != null ? idle() : orElse();
    } else if (this is _Success<T>) {
      final _Success<T> value = this as _Success<T>;
      return success != null ? success(value.data) : orElse();
    } else if (this is _Loading<T>) {
      return loading != null ? loading() : orElse();
    } else if (this is _Failure<T>) {
      final _Failure<T> value = this as _Failure<T>;
      return failure != null ? failure(value.data) : orElse();
    }

    throw Exception('unsupported subclass');
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

  FutureOr<SimpleDataState<T>> modifyData(
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
  const _Idle._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Idle<T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'SimpleDataState._Idle';
}

class _Success<T> extends SimpleDataState<T> {
  const _Success._(this.data) : super._();

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
  const _Loading._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Loading<T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'SimpleDataState._Loading';
}

class _Failure<T> extends SimpleDataState<T> {
  const _Failure._(
    this.data,
  ) : super._();

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
