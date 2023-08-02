import '../core/either.dart';
import '../failure/money_failure.dart';
import 'core/value_object.dart';

class Money extends ValueObject<MoneyFailure, double> {
  factory Money(
    String value, {
    double? min,
    double? max,
  }) {
    if (value.trim().isEmpty) {
      return Money._(left(MoneyFailure.empty));
    }

    final double? moneyValue = double.tryParse(value);

    if (moneyValue == null || moneyValue.isNaN || moneyValue < 0) {
      return Money._(left(MoneyFailure.invalid));
    }

    if (min != null && moneyValue < min) {
      return Money._(left(MoneyFailure.lessThanMin));
    }

    if (max != null && moneyValue > max) {
      return Money._(left(MoneyFailure.moreThanMax));
    }

    return Money._(right(moneyValue));
  }

  factory Money.fromDouble(double value) {
    if (value < 0) {
      return Money._(left(MoneyFailure.invalid));
    }

    return Money._(right(value));
  }

  factory Money.empty() => Money._(left(MoneyFailure.empty));

  Money._(Either<MoneyFailure, double> value) : super(value);
}
