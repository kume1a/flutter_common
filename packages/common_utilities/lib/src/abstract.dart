abstract interface class Factory<T> {
  T create();
}

abstract interface class FactoryWithParam<T, P> {
  T create(P param);
}

abstract interface class AsycFactory<T> {
  Future<T> create();
}

abstract interface class Provider<T> {
  T get();
}

abstract interface class AsyncProvider<T> {
  Future<T> get();
}
