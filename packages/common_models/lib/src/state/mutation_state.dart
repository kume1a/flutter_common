import 'package:collection/collection.dart';

import '../core/either.dart';

sealed class MutationState<F, T> {
  const MutationState._();

  factory MutationState.idle() => _Idle<F, T>._();

  factory MutationState.executing() => _Executing<F, T>._();

  factory MutationState.failed(F failure) => _Failed<F, T>._(failure);

  factory MutationState.executed(T data) => _Executed<F, T>._(data);

  factory MutationState.fromEither(Either<F, T> either) {
    return either.fold(
      (l) => MutationState.failed(l),
      (r) => MutationState.executed(r),
    );
  }

  R when<R>(
    R Function() idle,
    R Function() executing,
    R Function(T data) executed,
    R Function(F failure) failed,
  ) {
    return switch (this) {
      _Idle<F, T> _ => idle(),
      _Executing<F, T> _ => executing(),
      final _Failed<F, T> result => failed(result.failure),
      final _Executed<F, T> result => executed(result.data),
    };
  }

  R maybeWhen<R>(
    R Function()? idle,
    R Function()? executing,
    R Function(T data)? executed,
    R Function(F failure)? failed,
    R Function() orElse,
  ) {
    return switch (this) {
      _Idle<F, T> _ => idle?.call() ?? orElse(),
      _Executing<F, T> _ => executing?.call() ?? orElse(),
      final _Failed<F, T> result => failed?.call(result.failure) ?? orElse(),
      final _Executed<F, T> result => executed?.call(result.data) ?? orElse(),
    };
  }
}

class _Idle<F, T> extends MutationState<F, T> {
  const _Idle._() : super._();

  @override
  String toString() => 'MutationState._Idle()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Idle<F, T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class _Executing<F, T> extends MutationState<F, T> {
  const _Executing._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Executing<F, T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'MutationState._Executing';
}

class _Failed<F, T> extends MutationState<F, T> {
  const _Failed._(this.failure) : super._();

  final F failure;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failed<F, T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(failure, other.failure);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(failure),
      );

  @override
  String toString() => 'MutationState._Failed{failure: $failure}';
}

class _Executed<F, T> extends MutationState<F, T> {
  const _Executed._(this.data) : super._();

  final T data;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Executed<F, T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(data, other.data);

  @override
  int get hashCode => Object.hash(runtimeType, const DeepCollectionEquality().hash(data));

  @override
  String toString() => 'MutationState._Executed{data: $data}';
}
