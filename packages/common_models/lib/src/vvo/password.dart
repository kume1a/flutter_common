import '../core/either.dart';
import '../failure/password_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class Password extends ValueObject<PasswordFailure, String> {
  factory Password(String value) {
    if (value.isEmpty) {
      return Password._(left(PasswordFailure.empty()));
    }
    if (value.length < VVOConfig.password.minLength) {
      return Password._(left(PasswordFailure.tooShort()));
    }
    if (VVOConfig.password.checkForUppercase && !value.contains(_patternUppercase)) {
      return Password._(left(PasswordFailure.noUppercaseCharsFound()));
    }
    if (VVOConfig.password.checkForLowercase && !value.contains(_patternLowercase)) {
      return Password._(left(PasswordFailure.noLowercaseCharsFound()));
    }
    if (VVOConfig.password.checkForDigits && !value.contains(_patternDigits)) {
      return Password._(left(PasswordFailure.noDigitsFound()));
    }
    if (VVOConfig.password.checkForSpecialCharacters &&
        !value.contains(_patternSpecialCharacters)) {
      return Password._(left(PasswordFailure.noSpecialCharsFound()));
    }

    return Password._(right(value));
  }

  factory Password.empty() => Password._(left(PasswordFailure.empty()));

  Password._(Either<PasswordFailure, String> value) : super(value);

  static final Pattern _patternUppercase = RegExp('[A-Z]');
  static final Pattern _patternLowercase = RegExp('[a-z]');
  static final Pattern _patternDigits = RegExp('[0-9]');
  static final Pattern _patternSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
}
