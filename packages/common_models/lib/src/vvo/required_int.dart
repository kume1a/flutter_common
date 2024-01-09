import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class RequiredInt extends ValueObject<ValueFailure, int> {
  factory RequiredInt(String value) {
    if (value.trim().isEmpty) {
      return RequiredInt._(left(ValueFailure.empty));
    }

    final parsed = int.tryParse(value);

    if (parsed == null) {
      return RequiredInt._(left(ValueFailure.invalid));
    }

    return RequiredInt._(right(parsed));
  }

  factory RequiredInt.fromInt(int value) => RequiredInt._(right(value));

  factory RequiredInt.empty() => RequiredInt._(left(ValueFailure.empty));

  RequiredInt._(super.value);
}
