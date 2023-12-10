import 'package:collection/collection.dart';

import '../core/either.dart';

sealed class ActionState<F> {
  const ActionState._();

  factory ActionState.idle() => _Idle<F>._();

  factory ActionState.executing() => _Executing<F>._();

  factory ActionState.failed(F failure) => _Failed<F>._(failure);

  factory ActionState.executed() => _Executed<F>._();

  factory ActionState.fromEither(Either<F, dynamic> either) {
    return either.fold(
      (l) => ActionState.failed(l),
      (r) => ActionState.executed(),
    );
  }

  R when<R>({
    required R Function() idle,
    required R Function() executing,
    required R Function() executed,
    required R Function(F failure) failed,
  }) {
    return switch (this) {
      _Idle<F> _ => idle(),
      _Executing<F> _ => executing(),
      final _Failed<F> result => failed(result.failure),
      _Executed<F> _ => executed(),
    };
  }

  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? idle,
    R Function()? executing,
    R Function()? executed,
    R Function(F failure)? failed,
  }) {
    return switch (this) {
      _Idle<F> _ => idle?.call() ?? orElse(),
      _Executing<F> _ => executing?.call() ?? orElse(),
      final _Failed<F> result => failed?.call(result.failure) ?? orElse(),
      _Executed<F> _ => executed?.call() ?? orElse(),
    };
  }
}

class _Idle<F> extends ActionState<F> {
  const _Idle._() : super._();

  @override
  String toString() => 'ActionState._Idle()';

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Idle<F> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class _Executing<F> extends ActionState<F> {
  const _Executing._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Executing<F> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'ActionState._Executing';
}

class _Failed<F> extends ActionState<F> {
  const _Failed._(this.failure) : super._();

  final F failure;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failed<F> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(failure, other.failure);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(failure),
      );

  @override
  String toString() => 'ActionState._Failed{failure: $failure}';
}

class _Executed<F> extends ActionState<F> {
  const _Executed._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Executed<F> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'ActionState._Executed';
}
