import 'package:collection/collection.dart';

import '../core/either.dart';

sealed class MutationState<E, T> {
  const MutationState._();

  factory MutationState.idle() => _Idle<E, T>._();

  factory MutationState.executing() => _Executing<E, T>._();

  factory MutationState.failed(E err) => _Failed<E, T>._(err);

  factory MutationState.executed(T data) => _Executed<E, T>._(data);

  factory MutationState.fromEither(Either<E, T> either) {
    return either.fold(
      (l) => MutationState.failed(l),
      (r) => MutationState.executed(r),
    );
  }

  R when<R>({
    required R Function() idle,
    required R Function() executing,
    required R Function(T data) executed,
    required R Function(E err) failed,
  }) {
    return switch (this) {
      _Idle<E, T> _ => idle(),
      _Executing<E, T> _ => executing(),
      final _Failed<E, T> result => failed(result.err),
      final _Executed<E, T> result => executed(result.data),
    };
  }

  R maybeWhen<R>({
    required R Function() orElse,
    R Function()? idle,
    R Function()? executing,
    R Function(T data)? executed,
    R Function(E err)? failed,
  }) {
    return switch (this) {
      _Idle<E, T> _ => idle?.call() ?? orElse(),
      _Executing<E, T> _ => executing?.call() ?? orElse(),
      final _Failed<E, T> result => failed?.call(result.err) ?? orElse(),
      final _Executed<E, T> result => executed?.call(result.data) ?? orElse(),
    };
  }

  R? whenOrNull<R>({
    R Function()? idle,
    R Function()? executing,
    R Function(T data)? executed,
    R Function(E err)? failed,
  }) {
    return switch (this) {
      _Idle<E, T> _ => idle?.call(),
      _Executing<E, T> _ => executing?.call(),
      final _Failed<E, T> result => failed?.call(result.err),
      final _Executed<E, T> result => executed?.call(result.data),
    };
  }

  bool get isIdle => maybeWhen(orElse: () => false, idle: () => true);

  bool get isExecuting => maybeWhen(orElse: () => false, executing: () => true);

  bool get isFailed => maybeWhen(orElse: () => false, failed: (_) => true);

  bool get isExecuted => maybeWhen(orElse: () => false, executed: (_) => true);

  E? get errOrNull => maybeWhen(orElse: () => null, failed: (err) => err);

  T? get dataOrNull => maybeWhen(orElse: () => null, executed: (d) => d);
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
  const _Failed._(this.err) : super._();

  final F err;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _Failed<F, T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(err, other.err);

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(err),
      );

  @override
  String toString() => 'MutationState._Failed{err: $err}';
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
