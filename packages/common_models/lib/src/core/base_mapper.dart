import 'dart:async';

abstract class BaseMapper<L, R> {
  FutureOr<R> mapToRight(L l) {
    throw UnimplementedError();
  }

  FutureOr<L> mapToLeft(R r) {
    throw UnimplementedError();
  }
}
