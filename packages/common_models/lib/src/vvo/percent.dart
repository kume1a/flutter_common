import '../core/either.dart';
import '../error/percent_error.dart';
import 'core/value_object.dart';

class Percent extends ValueObject<PercentError, double> {
  factory Percent(String value) {
    if (value.trim().isEmpty) {
      return Percent._(left(PercentError.empty));
    }

    final double? percentValue = double.tryParse(value);
    if (percentValue == null || percentValue.isNaN) {
      return Percent._(left(PercentError.invalid));
    }

    if (percentValue < 0 || percentValue > 100) {
      return Percent._(left(PercentError.outOfRange));
    }

    return Percent._(right(percentValue));
  }

  factory Percent.fromDouble(double value) {
    if (value < 0 || value > 100) {
      return Percent._(left(PercentError.outOfRange));
    }

    return Percent._(right(value));
  }

  factory Percent.empty() => Percent._(left(PercentError.empty));

  Percent._(super.value);
}
