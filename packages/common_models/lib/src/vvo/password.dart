import '../core/either.dart';
import '../failure/password_failure.dart';
import '../regexp.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class ValidatePasswordOptions {
  const ValidatePasswordOptions({
    this.empty = true,
    this.tooShort = true,
    this.tooLong = true,
    this.containsWhitespace = true,
    this.noUppercaseCharsFound = true,
    this.noLowercaseCharsFound = true,
    this.noDigitsFound = true,
    this.noSpecialCharsFound = true,
  });

  final bool empty;
  final bool tooShort;
  final bool tooLong;
  final bool containsWhitespace;
  final bool noUppercaseCharsFound;
  final bool noLowercaseCharsFound;
  final bool noDigitsFound;
  final bool noSpecialCharsFound;
}

class Password extends ValueObject<PasswordFailure, String> {
  factory Password(
    String value, {
    ValidatePasswordOptions options = const ValidatePasswordOptions(),
  }) {
    if (options.empty && value.isEmpty) {
      return Password._(left(PasswordFailure.empty));
    }

    if (options.tooShort && value.length < VVOConfig.password.minLength) {
      return Password._(left(PasswordFailure.tooShort));
    }

    if (options.tooLong && value.length > VVOConfig.password.maxLength) {
      return Password._(left(PasswordFailure.tooLong));
    }

    if (options.containsWhitespace && value.contains(patternWhitespace)) {
      return Password._(left(PasswordFailure.containsWhitespace));
    }

    if (options.noUppercaseCharsFound &&
        VVOConfig.password.checkForUppercase &&
        !value.contains(patternUppercase)) {
      return Password._(left(PasswordFailure.noUppercaseCharsFound));
    }

    if (options.noLowercaseCharsFound &&
        VVOConfig.password.checkForLowercase &&
        !value.contains(patternLowercase)) {
      return Password._(left(PasswordFailure.noLowercaseCharsFound));
    }

    if (options.noDigitsFound && VVOConfig.password.checkForDigits && !value.contains(patternDigits)) {
      return Password._(left(PasswordFailure.noDigitsFound));
    }

    if (options.noSpecialCharsFound &&
        VVOConfig.password.checkForSpecialCharacters &&
        !value.contains(patternSpecialCharacters)) {
      return Password._(left(PasswordFailure.noSpecialCharsFound));
    }

    return Password._(right(value));
  }

  factory Password.empty() => Password._(left(PasswordFailure.empty));

  Password._(Either<PasswordFailure, String> value) : super(value);
}
