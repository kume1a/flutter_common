import 'dart:async';

import 'package:collection/collection.dart';

A _id<A>(A a) => a;

abstract class Result<T> {
  const Result();

  factory Result.success(T data) = _Success<T>;

  factory Result.err() = _Err<T>;

  B fold<B>(B Function() ifErr, B Function(T data) ifSuccess);

  B? ifErr<B>(B Function() ifErr) => fold(ifErr, (_) => null);

  B? ifSuccess<B>(B Function(T data) ifSuccess) => fold(() => null, ifSuccess);

  Future<B> foldAsync<B>(Future<B> Function() ifErr, Future<B> Function(T data) ifSuccess);

  T? get dataOrNull => fold(() => null, _id);

  T get dataOrThrow => getOrElse(() => throw Exception('dataOrThrow called on err'));

  bool get isErr => fold(() => true, (_) => false);

  bool get isSuccess => fold(() => false, (_) => true);

  T getOrElse(T Function() dflt) => fold(() => dflt(), _id);

  T operator |(T dflt) => getOrElse(() => dflt);

  Result<T2> map<T2>(T2 Function(T data) f) => fold(
        Result.err,
        (T r) => Result.success(f(r)),
      );

  Future<Result<T2>> mapAsync<T2>(Future<T2> Function(T r) f) => foldAsync(
        () => Future.value(Result.err()),
        (T r) async => Result.success(await f(r)),
      );

  @override
  String toString() => fold(() => 'Result.Err()', (T data) => 'Result.Success($data)');
}

class _Err<T> extends Result<T> {
  const _Err();

  @override
  B fold<B>(B Function() ifErr, B Function(T data) ifSuccess) => ifErr();

  @override
  Future<B> foldAsync<B>(
    Future<B> Function() ifErr,
    Future<B> Function(T data) ifSuccess,
  ) =>
      ifErr();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Err<T> && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;
}

class _Success<T> extends Result<T> {
  const _Success(this._data);

  final T _data;

  T get value => _data;

  @override
  B fold<B>(B Function() ifErr, B Function(T data) ifSuccess) => ifSuccess(_data);

  @override
  Future<B> foldAsync<B>(
    Future<B> Function() ifErr,
    Future<B> Function(T data) ifSuccess,
  ) async =>
      ifSuccess(_data);

  @override
  bool operator ==(Object other) =>
      other is _Success && const DeepCollectionEquality().equals(other._data, _data);

  @override
  int get hashCode => _data.hashCode;
}

extension FutureResultX<R> on Future<Result<R>> {
  Future<B> awaitFold<B>(
    FutureOr<B> Function() ifErr,
    FutureOr<B> Function(R r) ifSuccess,
  ) async {
    final result = await this;

    return result.fold(ifErr, ifSuccess);
  }
}
