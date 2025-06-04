import 'dart:async';

import 'package:collection/collection.dart';

import 'result.dart';

A _id<A>(A a) => a;

sealed class Either<L, R> {
  const Either();

  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight);

  B? ifLeft<B>(B Function(L l) ifLeft) => fold(ifLeft, (r) => null);

  B? ifRight<B>(B Function(R r) ifRight) => fold((_) => null, ifRight);

  Future<B> foldAsync<B>(Future<B> Function(L l) ifLeft, Future<B> Function(R r) ifRight);

  Either<L, R> orElse(Either<L, R> Function() other) => fold((_) => other(), (_) => this);

  R? get rightOrNull => fold((L l) => null, _id);

  L? get leftOrNull => fold(_id, (_) => null);

  R get rightOrThrow => getOrElse(() => throw Exception('rightOrThrow called on Left'));

  L get leftOrThrow => fold(_id, (R r) => throw Exception('leftOrThrow called on Right'));

  bool get isLeft => fold((_) => true, (_) => false);

  bool get isRight => fold((_) => false, (_) => true);

  int get length => fold((_) => 0, (_) => 1);

  R getOrElse(R Function() dflt) => fold((_) => dflt(), _id);

  R operator |(R dflt) => getOrElse(() => dflt);

  Either<L2, R> leftMap<L2>(L2 Function(L l) f) => fold((L l) => left(f(l)), right);

  Either<R, L> swap() => fold(right, left);

  Either<L, R2> map<R2>(R2 Function(R r) f) => fold(left, (R r) => right(f(r)));

  Future<Either<L, R2>> mapAsync<R2>(Future<R2> Function(R r) f) =>
      foldAsync((L l) async => left(l), (R r) async => right(await f(r)));

  Result<R> toResult() => fold((_) => Result.err(), Result.success);

  @override
  String toString() => fold((L l) => 'Left($l)', (R r) => 'Right($r)');
}

class _Left<L, R> extends Either<L, R> {
  const _Left(this._l);

  final L _l;

  L get value => _l;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifLeft(_l);

  @override
  Future<B> foldAsync<B>(
    Future<B> Function(L l) ifLeft,
    Future<B> Function(R r) ifRight,
  ) =>
      ifLeft(_l);

  @override
  bool operator ==(Object other) => other is _Left && const DeepCollectionEquality().equals(other._l, _l);

  @override
  int get hashCode => _l.hashCode;
}

class _Right<L, R> extends Either<L, R> {
  const _Right(this._r);

  final R _r;

  R get value => _r;

  @override
  B fold<B>(B Function(L l) ifLeft, B Function(R r) ifRight) => ifRight(_r);

  @override
  Future<B> foldAsync<B>(
    Future<B> Function(L l) ifLeft,
    Future<B> Function(R r) ifRight,
  ) =>
      ifRight(_r);

  @override
  bool operator ==(Object other) => other is _Right && const DeepCollectionEquality().equals(other._r, _r);

  @override
  int get hashCode => _r.hashCode;
}

Either<L, R> left<L, R>(L l) => _Left<L, R>(l);

Either<L, R> right<L, R>(R r) => _Right<L, R>(r);

extension FutureEitherX<L, R> on Future<Either<L, R>> {
  Future<B> awaitFold<B>(
    FutureOr<B> Function(L l) ifLeft,
    FutureOr<B> Function(R r) ifRight,
  ) async {
    final either = await this;

    return either.fold(ifLeft, ifRight);
  }
}
