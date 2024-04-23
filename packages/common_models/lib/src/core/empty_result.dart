import 'dart:async';

A _id<A>(A a) => a;

abstract class EmptyResult {
  const EmptyResult();

  factory EmptyResult.success() = _Success;

  factory EmptyResult.err() = _Err;

  B fold<B>(B Function() ifErr, B Function() ifSuccess);

  B? ifErr<B>(B Function() ifErr) => fold(ifErr, () => null);

  B? ifSuccess<B>(B Function() ifSuccess) => fold(() => null, ifSuccess);

  Future<B> foldAsync<B>(Future<B> Function() ifErr, Future<B> Function() ifSuccess);

  bool get isErr => fold(() => true, () => false);

  bool get isSuccess => fold(() => false, () => true);

  @override
  String toString() => fold(() => 'EmptyResult.Err()', () => 'EmptyResult.Success()');
}

class _Err extends EmptyResult {
  const _Err();

  @override
  B fold<B>(B Function() ifErr, B Function() ifSuccess) => ifErr();

  @override
  Future<B> foldAsync<B>(
    Future<B> Function() ifErr,
    Future<B> Function() ifSuccess,
  ) =>
      ifErr();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Err && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class _Success extends EmptyResult {
  const _Success();

  @override
  B fold<B>(B Function() ifErr, B Function() ifSuccess) => ifSuccess();

  @override
  Future<B> foldAsync<B>(
    Future<B> Function() ifErr,
    Future<B> Function() ifSuccess,
  ) async =>
      ifSuccess();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Success && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

extension FutureEmptyResultX on Future<EmptyResult> {
  Future<B> awaitFold<B>(
    FutureOr<B> Function() ifErr,
    FutureOr<B> Function() ifSuccess,
  ) async {
    final result = await this;

    return result.fold(ifErr, ifSuccess);
  }
}
