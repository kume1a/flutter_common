import '../core/either.dart';
import '../failure/positive_int_failure.dart';
import 'core/value_object.dart';

class PositiveInt extends ValueObject<PositiveIntFailure, int> {
  factory PositiveInt(String value) {
    if (value.trim().isEmpty) {
      return PositiveInt._(left(PositiveIntFailure.empty));
    }

    final parsed = int.tryParse(value);

    if (parsed == null) {
      return PositiveInt._(left(PositiveIntFailure.invalid));
    }

    if (parsed < 0) {
      return PositiveInt._(left(PositiveIntFailure.negative));
    }

    return PositiveInt._(right(parsed));
  }

  factory PositiveInt.fromInt(int value) {
    if (value < 0) {
      return PositiveInt._(left(PositiveIntFailure.invalid));
    }

    return PositiveInt._(right(value));
  }

  factory PositiveInt.empty() => PositiveInt._(left(PositiveIntFailure.empty));

  PositiveInt._(super.value);
}
