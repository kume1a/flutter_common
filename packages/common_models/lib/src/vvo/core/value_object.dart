import '../../core/either.dart';

/// base of a validated value object
/// holds either a value of type [T] or a err from validation of type [E]
abstract class ValueObject<E, T> {
  const ValueObject(this._value);

  final Either<E, T> _value;

  /// @returns value if [_value] is valid, null otherwise
  T? get get => _value.fold((E l) => null, (T r) => r);

  /// @returns value [T] if present
  /// @throws [Exception] if value isn't valid
  T get getOrThrow => _value.fold((E l) => throw Exception('getOrThrow called with error'), (T t) => t);

  T getOrElse(T orElse) => _value.getOrElse(() => orElse);

  bool get valid => _value.isRight;

  bool get invalid => _value.isLeft;

  String? errToString(String? Function(E) mapper) => _value.fold(
        (E l) => mapper(l),
        (_) => null,
      );

  @override
  bool operator ==(Object o) => identical(this, o) || o is ValueObject<E, T> && o._value == _value;

  @override
  int get hashCode => _value.hashCode;

  @override
  String toString() => 'ValueObject{$_value}';
}
