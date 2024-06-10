import 'dart:async';

import 'package:collection/collection.dart';

import '../core/either.dart';

abstract class DataState<E, T> {
  const DataState._();

  factory DataState.success(T data) => _Success<E, T>._(data);

  factory DataState.idle() => _Idle<E, T>._();

  factory DataState.loading() => _Loading<E, T>._();

  factory DataState.failure(E err, [T? data]) => _Failure<E, T>._(err, data);

  factory DataState.fromEither(Either<E, T> either) => either.fold(
        (E l) => DataState<E, T>.failure(l),
        (T r) => DataState<E, T>.success(r),
      );

  A when<A extends Object?>({
    required A Function() idle,
    required A Function(T data) success,
    required A Function() loading,
    required A Function(E err, T? data) failure,
  }) {
    if (this is _Idle<E, T>) {
      return idle();
    } else if (this is _Success<E, T>) {
      final _Success<E, T> value = this as _Success<E, T>;
      return success(value.data);
    } else if (this is _Loading<E, T>) {
      return loading();
    } else if (this is _Failure<E, T>) {
      final _Failure<E, T> value = this as _Failure<E, T>;
      return failure(value.err, value.data);
    }

    throw Exception('unsupported subclass');
  }

  A maybeWhen<A extends Object?>({
    required A Function() orElse,
    A Function()? idle,
    A Function(T data)? success,
    A Function()? loading,
    A Function(E failure, T? data)? failure,
  }) {
    if (this is _Idle<E, T>) {
      return idle != null ? idle() : orElse();
    } else if (this is _Success<E, T>) {
      final _Success<E, T> value = this as _Success<E, T>;
      return success != null ? success(value.data) : orElse();
    } else if (this is _Loading<E, T>) {
      return loading != null ? loading() : orElse();
    } else if (this is _Failure<E, T>) {
      final _Failure<E, T> value = this as _Failure<E, T>;
      return failure != null ? failure(value.err, value.data) : orElse();
    }

    throw Exception('unsupported subclass');
  }

  A ifData<A extends Object?>(
    A Function(T data) ifData, {
    required A Function() orElse,
  }) {
    return maybeWhen<A>(
      success: (data) => ifData(data),
      failure: (_, data) => data != null ? ifData(data) : orElse(),
      orElse: orElse,
    );
  }

  T dataOrElse(T Function() orElse) => maybeWhen(
        success: (data) => data,
        failure: (_, data) => data ?? orElse(),
        orElse: orElse,
      );

  bool get isIdle => maybeWhen(idle: () => true, orElse: () => false);

  bool get isLoading => maybeWhen(loading: () => true, orElse: () => false);

  bool get isFailure => maybeWhen(failure: (_, __) => true, orElse: () => false);

  bool get isSuccess => maybeWhen(success: (_) => true, orElse: () => false);

  bool get hasData => maybeWhen(
        success: (_) => true,
        failure: (_, T? data) => data != null,
        orElse: () => false,
      );

  T get getOrThrow => maybeWhen(
        success: (T data) => data,
        failure: (_, T? data) => data!,
        orElse: () => throw Exception('getOrThrow called on !success'),
      );

  T? get getOrNull => maybeWhen(
        success: (T data) => data,
        failure: (_, T? data) => data,
        orElse: () => null,
      );

  FutureOr<DataState<E, T>> map(
    FutureOr<T?> Function(T data) modifier,
  ) async {
    return maybeWhen(
      success: (T data) async {
        final T? newData = await modifier.call(data);
        if (newData != null) {
          return DataState<E, T>.success(newData);
        }
        return this;
      },
      failure: (E err, T? data) async {
        if (data != null) {
          final T? newData = await modifier.call(data);
          if (newData != null) {
            return DataState<E, T>.failure(err, newData);
          }
        }
        return this;
      },
      orElse: () => this,
    );
  }

  DataState<F3, T3> merge<E2, T2, F3, T3>(
    DataState<E2, T2> other,
    F3 Function(E?, E2?) failureResolver,
    T3 Function(T, T2) dataResolver,
  ) {
    return when(
      idle: () => DataState<F3, T3>.idle(),
      loading: () => DataState<F3, T3>.loading(),
      failure: (E err, _) => DataState<F3, T3>.failure(failureResolver(err, null)),
      success: (T data) {
        return other.when(
          idle: () => DataState<F3, T3>.idle(),
          success: (T2 otherData) => DataState<F3, T3>.success(dataResolver(data, otherData)),
          loading: () => DataState<F3, T3>.loading(),
          failure: (E2 otherErr, _) => DataState<F3, T3>.failure(failureResolver(null, otherErr)),
        );
      },
    );
  }
}

class _Idle<F, T> extends DataState<F, T> {
  const _Idle._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Idle<F, T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'DataState._Idle';
}

class _Success<F, T> extends DataState<F, T> {
  const _Success._(this.data) : super._();

  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Success<F, T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() => 'DataState._Success{data: $data}';
}

class _Loading<F, T> extends DataState<F, T> {
  const _Loading._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Loading<F, T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'DataState._Loading';
}

class _Failure<F, T> extends DataState<F, T> {
  const _Failure._(
    this.err,
    this.data,
  ) : super._();

  final F err;
  final T? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failure<F, T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(err, other.err) &&
          const DeepCollectionEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(err),
        const DeepCollectionEquality().hash(data),
      );

  @override
  String toString() => 'DataState._Failure{err: $err, data: $data}';
}
