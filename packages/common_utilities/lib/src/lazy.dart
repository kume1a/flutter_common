typedef InitFunction<T> = T Function();

class Lazy<T> {
  Lazy(InitFunction<T> function) : _factory = function;

  InitFunction<T>? _factory;

  bool get isValueCreated => _isValueCreated;
  bool _isValueCreated = false;

  T get value => _isValueCreated ? _value : _createValue();
  late final T _value;

  T call() => value;

  T _createValue() {
    _value = _factory!();
    _factory = null;
    _isValueCreated = true;
    return _value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) || (other is Lazy && other._value == _value);

  @override
  int get hashCode => _value.hashCode;
}

class MutableLazy<T> extends Lazy<T> {
  MutableLazy(InitFunction<T> function) : super(function);

  void reset() => _isValueCreated = false;

  @override
  // ignore: overridden_fields
  late T _value;

  @override
  T _createValue() {
    _value = _factory!();
    _isValueCreated = true;
    return _value;
  }
}
