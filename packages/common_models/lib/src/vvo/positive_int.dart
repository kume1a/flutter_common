import '../core/either.dart';
import '../failure/positive_number_failure.dart';
import 'core/value_object.dart';

class PositiveInt extends ValueObject<PositiveNumberFailure, int> {
  factory PositiveInt(String value) {
    if (value.trim().isEmpty) {
      return PositiveInt._(left(PositiveNumberFailure.empty));
    }

    final parsed = int.tryParse(value);

    if (parsed == null) {
      return PositiveInt._(left(PositiveNumberFailure.invalid));
    }

    if (parsed < 0) {
      return PositiveInt._(left(PositiveNumberFailure.negative));
    }

    return PositiveInt._(right(parsed));
  }

  factory PositiveInt.fromInt(int value) {
    if (value < 0) {
      return PositiveInt._(left(PositiveNumberFailure.invalid));
    }

    return PositiveInt._(right(value));
  }

  factory PositiveInt.empty() => PositiveInt._(left(PositiveNumberFailure.empty));

  PositiveInt._(super.value);
}
