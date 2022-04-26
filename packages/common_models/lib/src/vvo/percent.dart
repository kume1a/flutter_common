import '../core/either.dart';
import '../failure/percent_failure.dart';
import 'core/value_object.dart';

class Percent extends ValueObject<PercentFailure, double> {
  factory Percent(String value) {
    if (value.trim().isEmpty) {
      return Percent._(left(const PercentFailure.empty()));
    }

    final double? percentValue = double.tryParse(value);
    if (percentValue == null || percentValue.isNaN) {
      return Percent._(left(const PercentFailure.invalid()));
    }

    if (percentValue < 0 || percentValue > 100) {
      return Percent._(left(const PercentFailure.outOfRange()));
    }

    return Percent._(right(percentValue));
  }

  factory Percent.empty() => Percent('');

  Percent._(Either<PercentFailure, double> value) : super(value);
}
