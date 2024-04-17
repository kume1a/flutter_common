import '../core/either.dart';
import '../error/required_string_error.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class RequiredString extends ValueObject<RequiredStringError, String> {
  factory RequiredString(String value) {
    if (value.trim().isEmpty) {
      return RequiredString._(left(RequiredStringError.empty));
    }

    if (value.length > VVOConfig.requiredString.maxLength) {
      return RequiredString._(left(RequiredStringError.tooLong));
    }

    return RequiredString._(right(value));
  }

  factory RequiredString.empty() => RequiredString._(left(RequiredStringError.empty));

  RequiredString._(super.value);
}
