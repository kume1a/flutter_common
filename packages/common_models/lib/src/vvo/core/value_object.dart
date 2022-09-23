import '../../core/either.dart';

/// base of a validated value object
/// holds either a value of type [T] or a failure from validation of type [F]
abstract class ValueObject<F, T> {
  const ValueObject(this._value);

  final Either<F, T> _value;

  /// @returns value if [_value] is valid, null otherwise
  T? get get => _value.fold((F l) => null, (T r) => r);

  /// @returns value [T] if present
  /// @throws [Exception] if value isn't valid
  T get getOrThrow =>
      _value.fold((F l) => throw Exception('getOrThrow called with failure'), (T t) => t);

  T getOrElse(T orElse) => _value.getOrElse(() => orElse);

  bool get valid => _value.isRight();

  bool get invalid => _value.isLeft();

  String? failureToString(String Function(F) mapper) => _value.fold(
        (F l) => mapper(l),
        (_) => null,
      );

  @override
  bool operator ==(Object o) => identical(this, o) || o is ValueObject<F, T> && o._value == _value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => 'ValueObject{$_value}';
}
