import '../core/either.dart';
import '../error/positive_number_error.dart';
import 'core/value_object.dart';

class PositiveDouble extends ValueObject<PositiveNumberError, double> {
  factory PositiveDouble(String value) {
    if (value.trim().isEmpty) {
      return PositiveDouble._(left(PositiveNumberError.empty));
    }

    final parsed = double.tryParse(value);

    if (parsed == null) {
      return PositiveDouble._(left(PositiveNumberError.invalid));
    }

    if (parsed < 0) {
      return PositiveDouble._(left(PositiveNumberError.negative));
    }

    return PositiveDouble._(right(parsed));
  }

  factory PositiveDouble.fromDouble(double value) {
    if (value < 0) {
      return PositiveDouble._(left(PositiveNumberError.invalid));
    }

    return PositiveDouble._(right(value));
  }

  factory PositiveDouble.empty() => PositiveDouble._(left(PositiveNumberError.empty));

  PositiveDouble._(super.value);
}
