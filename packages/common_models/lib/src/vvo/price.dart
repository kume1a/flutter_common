import '../core/either.dart';
import '../failure/price_failure.dart';
import 'core/value_object.dart';

class Price extends ValueObject<PriceFailure, double> {
  factory Price(String value) {
    if (value.trim().isEmpty) {
      return Price._(left(PriceFailure.empty));
    }

    final double? priceValue = double.tryParse(value);
    if (priceValue == null || priceValue.isNaN || priceValue < 0) {
      return Price._(left(PriceFailure.invalid));
    }

    return Price._(right(priceValue));
  }

  factory Price.fromDouble(double value) {
    if (value < 0) {
      return Price._(left(PriceFailure.invalid));
    }

    return Price._(right(value));
  }

  factory Price.empty() => Price._(left(PriceFailure.empty));

  Price._(Either<PriceFailure, double> value) : super(value);
}
