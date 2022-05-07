import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class Price extends ValueObject<ValueFailure, double> {
  factory Price(String value) {
    if (value.trim().isEmpty) {
      return Price._(left(ValueFailure.empty()));
    }

    final double? priceValue = double.tryParse(value);
    if (priceValue == null || priceValue.isNaN || priceValue < 0) {
      return Price._(left(ValueFailure.invalid()));
    }

    return Price._(right(priceValue));
  }

  factory Price.fromDouble(double value) {
    if (value < 0) {
      return Price._(left(ValueFailure.invalid()));
    }

    return Price._(right(value));
  }

  factory Price.empty() => Price._(left(ValueFailure.empty()));

  Price._(Either<ValueFailure, double> value) : super(value);
}
