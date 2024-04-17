import '../core/either.dart';
import '../error/positive_number_error.dart';
import 'core/value_object.dart';

class PositiveInt extends ValueObject<PositiveNumberError, int> {
  factory PositiveInt(String value) {
    if (value.trim().isEmpty) {
      return PositiveInt._(left(PositiveNumberError.empty));
    }

    final parsed = int.tryParse(value);

    if (parsed == null) {
      return PositiveInt._(left(PositiveNumberError.invalid));
    }

    if (parsed < 0) {
      return PositiveInt._(left(PositiveNumberError.negative));
    }

    return PositiveInt._(right(parsed));
  }

  factory PositiveInt.fromInt(int value) {
    if (value < 0) {
      return PositiveInt._(left(PositiveNumberError.invalid));
    }

    return PositiveInt._(right(value));
  }

  factory PositiveInt.empty() => PositiveInt._(left(PositiveNumberError.empty));

  PositiveInt._(super.value);
}
