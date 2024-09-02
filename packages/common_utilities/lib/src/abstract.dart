abstract interface class Factory<T> {
  T create();
}

abstract interface class FactoryWithParam<T, P> {
  T create(P param);
}

abstract interface class AsyncFactory<T> {
  Future<T> create();
}

abstract interface class Provider<T> {
  T get();
}

abstract interface class DisposableProvider<T> extends Provider<T> {
  Future<void> dispose();
}

abstract interface class AsyncProvider<T> {
  Future<T> get();
}

abstract interface class AsyncDisposableProvider<T> extends AsyncProvider<T> {
  Future<void> dispose();
}
