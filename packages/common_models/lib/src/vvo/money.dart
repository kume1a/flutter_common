import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class Money extends ValueObject<ValueFailure, double> {
  factory Money(String value) {
    if (value.trim().isEmpty) {
      return Money._(left(ValueFailure.empty));
    }

    final double? moneyValue = double.tryParse(value);
    if (moneyValue == null || moneyValue.isNaN || moneyValue < 0) {
      return Money._(left(ValueFailure.invalid));
    }

    return Money._(right(moneyValue));
  }

  factory Money.fromDouble(double value) {
    if (value < 0) {
      return Money._(left(ValueFailure.invalid));
    }

    return Money._(right(value));
  }

  factory Money.empty() => Money._(left(ValueFailure.empty));

  Money._(Either<ValueFailure, double> value) : super(value);
}
