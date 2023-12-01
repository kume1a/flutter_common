import '../../common_models.dart';

class PositiveInt extends ValueObject<ValueFailure, int> {
  factory PositiveInt(String value) {
    if (value.trim().isEmpty) {
      return PositiveInt._(left(ValueFailure.empty));
    }

    final parsed = int.tryParse(value);

    if (parsed == null || parsed < 0) {
      return PositiveInt._(left(ValueFailure.invalid));
    }

    return PositiveInt._(right(parsed));
  }

  factory PositiveInt.empty() => PositiveInt._(left(ValueFailure.empty));

  PositiveInt._(Either<ValueFailure, int> value) : super(value);
}
