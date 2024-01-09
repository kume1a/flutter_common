import '../core/either.dart';
import '../failure/required_string_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class RequiredString extends ValueObject<RequiredStringFailure, String> {
  factory RequiredString(String value) {
    if (value.trim().isEmpty) {
      return RequiredString._(left(RequiredStringFailure.empty));
    }

    if (value.length > VVOConfig.simpleContent.maxLength) {
      return RequiredString._(left(RequiredStringFailure.tooLong));
    }

    return RequiredString._(right(value));
  }

  factory RequiredString.empty() => RequiredString._(left(RequiredStringFailure.empty));

  RequiredString._(super.value);
}
