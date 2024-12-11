import 'package:collection/collection.dart';

import '../core/either.dart';

sealed class ActionState<E> {
  const ActionState._();

  factory ActionState.idle() => _Idle<E>._();

  factory ActionState.executing() => _Executing<E>._();

  factory ActionState.failed(E err) => _Failed<E>._(err);

  factory ActionState.executed() => _Executed<E>._();

  factory ActionState.fromEither(Either<E, dynamic> either) {
    return either.fold(
      (l) => ActionState.failed(l),
      (r) => ActionState.executed(),
    );
  }

  R when<R>({
    required R Function() idle,
    required R Function() executing,
    required R Function() executed,
    required R Function(E err) failed,
  }) {
    return switch (this) {
      _Idle<E> _ => idle(),
      _Executing<E> _ => executing(),
      final _Failed<E> result => failed(result.err),
      _Executed<E> _ => executed(),
    };
  }

  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? idle,
    R Function()? executing,
    R Function()? executed,
    R Function(E err)? failed,
  }) {
    return switch (this) {
      _Idle<E> _ => idle?.call() ?? orElse(),
      _Executing<E> _ => executing?.call() ?? orElse(),
      final _Failed<E> result => failed?.call(result.err) ?? orElse(),
      _Executed<E> _ => executed?.call() ?? orElse(),
    };
  }

  R? whenOrNull<R>({
    R Function()? idle,
    R Function()? executing,
    R Function()? executed,
    R Function(E err)? failed,
  }) {
    return switch (this) {
      _Idle<E> _ => idle?.call(),
      _Executing<E> _ => executing?.call(),
      final _Failed<E> result => failed?.call(result.err),
      _Executed<E> _ => executed?.call(),
    };
  }

  bool get isIdle => maybeWhen(orElse: () => false, idle: () => true);

  bool get isExecuting => maybeWhen(orElse: () => false, executing: () => true);

  bool get isFailed => maybeWhen(orElse: () => false, failed: (_) => true);

  bool get isExecuted => maybeWhen(orElse: () => false, executed: () => true);

  E? get errOrNull => maybeWhen(orElse: () => null, failed: (err) => err);
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

class _Failed<E> extends ActionState<E> {
  const _Failed._(this.err) : super._();

  final E err;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failed<E> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(err, other.err);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(err),
      );

  @override
  String toString() => 'ActionState._Failed{err: $err}';
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
