import '../core/either.dart';
import '../failure/password_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class Password extends ValueObject<PasswordFailure, String> {
  factory Password(String value) {
    if (value.isEmpty) {
      return Password._(left(const PasswordFailure.empty()));
    }
    if (value.length < VVOConfig.passwordVVOConfig.minLength) {
      return Password._(left(const PasswordFailure.shortPassword()));
    }
    if (VVOConfig.passwordVVOConfig.checkForUppercase && !value.contains(_patternUppercase)) {
      return Password._(left(const PasswordFailure.noUpperCaseCharacterPresent()));
    }
    if (VVOConfig.passwordVVOConfig.checkForLowercase && !value.contains(_patternLowercase)) {
      return Password._(left(const PasswordFailure.noLowerCaseCharacterPresent()));
    }
    if (VVOConfig.passwordVVOConfig.checkForDigits && !value.contains(_patternDigits)) {
      return Password._(left(const PasswordFailure.noDigitsPresent()));
    }
    if (VVOConfig.passwordVVOConfig.checkForSpecialCharacters &&
        !value.contains(_patternSpecialCharacters)) {
      return Password._(left(const PasswordFailure.noSpecialCharacterPresent()));
    }

    return Password._(right(value));
  }

  factory Password.empty() => Password('');

  Password._(Either<PasswordFailure, String> value) : super(value);

  static final Pattern _patternUppercase = RegExp('[A-Z]');
  static final Pattern _patternLowercase = RegExp('[a-z]');
  static final Pattern _patternDigits = RegExp('[0-9]');
  static final Pattern _patternSpecialCharacters = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
}
