import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class PositiveInt extends ValueObject<ValueFailure, int> {
  factory PositiveInt(String value) {
    if (value.trim().isEmpty) {
      return PositiveInt._(left(ValueFailure.empty));
    }

    final parsed = int.tryParse(value);

    if (parsed == null || parsed < 0) {
      return PositiveInt._(left(ValueFailure.invalid));
    }

    return PositiveInt._(right(parsed));
  }

  factory PositiveInt.fromInt(int value) {
    if (value < 0) {
      return PositiveInt._(left(ValueFailure.invalid));
    }

    return PositiveInt._(right(value));
  }

  factory PositiveInt.empty() => PositiveInt._(left(ValueFailure.empty));

  PositiveInt._(super.value);
}
