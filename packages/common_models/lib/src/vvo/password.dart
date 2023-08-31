import '../core/either.dart';
import '../failure/password_failure.dart';
import '../regexp.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class Password extends ValueObject<PasswordFailure, String> {
  factory Password(String value) {
    if (value.isEmpty) {
      return Password._(left(PasswordFailure.empty));
    }
    if (value.length < VVOConfig.password.minLength) {
      return Password._(left(PasswordFailure.tooShort));
    }
    if (value.length > VVOConfig.password.maxLength) {
      return Password._(left(PasswordFailure.tooLong));
    }
    if (value.contains(patternWhitespace)) {
      return Password._(left(PasswordFailure.containsWhitespace));
    }
    if (VVOConfig.password.checkForUppercase && !value.contains(patternUppercase)) {
      return Password._(left(PasswordFailure.noUppercaseCharsFound));
    }
    if (VVOConfig.password.checkForLowercase && !value.contains(patternLowercase)) {
      return Password._(left(PasswordFailure.noLowercaseCharsFound));
    }
    if (VVOConfig.password.checkForDigits && !value.contains(patternDigits)) {
      return Password._(left(PasswordFailure.noDigitsFound));
    }
    if (VVOConfig.password.checkForSpecialCharacters && !value.contains(patternSpecialCharacters)) {
      return Password._(left(PasswordFailure.noSpecialCharsFound));
    }

    return Password._(right(value));
  }

  factory Password.empty() => Password._(left(PasswordFailure.empty));

  Password._(Either<PasswordFailure, String> value) : super(value);
}
