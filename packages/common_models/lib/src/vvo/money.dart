import '../core/either.dart';
import '../error/money_error.dart';
import 'core/value_object.dart';

class Money extends ValueObject<MoneyError, double> {
  factory Money(
    String value, {
    double? min,
    double? max,
  }) {
    if (value.trim().isEmpty) {
      return Money._(left(MoneyError.empty));
    }

    final double? moneyValue = double.tryParse(value);

    if (moneyValue == null || moneyValue.isNaN || moneyValue < 0) {
      return Money._(left(MoneyError.invalid));
    }

    if (min != null && moneyValue < min) {
      return Money._(left(MoneyError.lessThanMin));
    }

    if (max != null && moneyValue > max) {
      return Money._(left(MoneyError.moreThanMax));
    }

    return Money._(right(moneyValue));
  }

  factory Money.fromDouble(double value) {
    if (value < 0) {
      return Money._(left(MoneyError.invalid));
    }

    return Money._(right(value));
  }

  factory Money.empty() => Money._(left(MoneyError.empty));

  Money._(super.value);
}
