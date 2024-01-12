import '../core/either.dart';
import '../failure/positive_number_failure.dart';
import 'core/value_object.dart';

class PositiveDouble extends ValueObject<PositiveNumberFailure, double> {
  factory PositiveDouble(String value) {
    if (value.trim().isEmpty) {
      return PositiveDouble._(left(PositiveNumberFailure.empty));
    }

    final parsed = double.tryParse(value);

    if (parsed == null) {
      return PositiveDouble._(left(PositiveNumberFailure.invalid));
    }

    if (parsed < 0) {
      return PositiveDouble._(left(PositiveNumberFailure.negative));
    }

    return PositiveDouble._(right(parsed));
  }

  factory PositiveDouble.fromDouble(double value) {
    if (value < 0) {
      return PositiveDouble._(left(PositiveNumberFailure.invalid));
    }

    return PositiveDouble._(right(value));
  }

  factory PositiveDouble.empty() => PositiveDouble._(left(PositiveNumberFailure.empty));

  PositiveDouble._(super.value);
}
