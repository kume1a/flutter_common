import '../core/either.dart';
import '../error/value_error.dart';
import 'core/value_object.dart';

class RequiredInt extends ValueObject<ValueError, int> {
  factory RequiredInt(String value) {
    if (value.trim().isEmpty) {
      return RequiredInt._(left(ValueError.empty));
    }

    final parsed = int.tryParse(value);

    if (parsed == null) {
      return RequiredInt._(left(ValueError.invalid));
    }

    return RequiredInt._(right(parsed));
  }

  factory RequiredInt.fromInt(int value) => RequiredInt._(right(value));

  factory RequiredInt.empty() => RequiredInt._(left(ValueError.empty));

  RequiredInt._(super.value);
}
