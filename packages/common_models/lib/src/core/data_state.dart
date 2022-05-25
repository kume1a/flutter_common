import 'dart:async';

import 'package:collection/collection.dart';

import '../../common_models.dart';
import 'either.dart';

abstract class DataState<F, T> {
  const DataState._();

  factory DataState.success(T data) => _Success<F, T>._(data);

  factory DataState.idle() => _Idle<F, T>._();

  factory DataState.loading() => _Loading<F, T>._();

  factory DataState.failure(F failure, [T? data]) => _Failure<F, T>._(failure, data);

  factory DataState.fromEither(Either<F, T> either) => either.fold(
        (F l) => DataState<F, T>.failure(l),
        (T r) => DataState<F, T>.success(r),
      );

  A when<A extends Object?>({
    required A Function() idle,
    required A Function(T data) success,
    required A Function() loading,
    required A Function(F failure, T? data) failure,
  }) {
    if (this is _Idle<F, T>) {
      return idle();
    } else if (this is _Success<F, T>) {
      final _Success<F, T> value = this as _Success<F, T>;
      return success(value.data);
    } else if (this is _Loading<F, T>) {
      return loading();
    } else if (this is _Failure<F, T>) {
      final _Failure<F, T> value = this as _Failure<F, T>;
      return failure(value.failure, value.data);
    }

    throw Exception('unsupported subclass');
  }

  A maybeWhen<A extends Object?>({
    required A Function() orElse,
    A Function()? idle,
    A Function(T data)? success,
    A Function()? loading,
    A Function(F failure, T? data)? failure,
  }) {
    if (this is _Idle<F, T>) {
      return idle != null ? idle() : orElse();
    } else if (this is _Success<F, T>) {
      final _Success<F, T> value = this as _Success<F, T>;
      return success != null ? success(value.data) : orElse();
    } else if (this is _Loading<F, T>) {
      return loading != null ? loading() : orElse();
    } else if (this is _Failure<F, T>) {
      final _Failure<F, T> value = this as _Failure<F, T>;
      return failure != null ? failure(value.failure, value.data) : orElse();
    }

    throw Exception('unsupported subclass');
  }

  bool get isSuccess => maybeWhen(
        success: (_) => true,
        orElse: () => false,
      );

  bool get hasData => maybeWhen(
        success: (_) => true,
        failure: (_, T? data) => data != null,
        orElse: () => false,
      );

  T get getOrThrow => maybeWhen(
        success: (T data) => data,
        failure: (F failure, T? data) => data!,
        orElse: () => throw Exception('getOrThrow called on !success'),
      );

  T? get get => maybeWhen(
        success: (T data) => data,
        failure: (F failure, T? data) => data,
        orElse: () => null,
      );

  FutureOr<DataState<F, T>> modifyData(
    FutureOr<T?> Function(T data) modifier,
  ) async {
    return maybeWhen(
      success: (T data) async {
        final T? newData = await modifier.call(data);
        if (newData != null) {
          return DataState<F, T>.success(newData);
        }
        return this;
      },
      failure: (F failure, T? data) async {
        if (data != null) {
          final T? newData = await modifier.call(data);
          if (newData != null) {
            return DataState<F, T>.failure(failure, newData);
          }
        }
        return this;
      },
      orElse: () => this,
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
    this.failure,
    this.data,
  ) : super._();

  final F failure;
  final T? data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failure<F, T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(failure, other.failure) &&
          const DeepCollectionEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(failure),
        const DeepCollectionEquality().hash(data),
      );

  @override
  String toString() => 'DataState._Failure{failure: $failure, data: $data}';
}
