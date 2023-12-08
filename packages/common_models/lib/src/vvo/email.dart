import '../core/either.dart';
import '../failure/email_failure.dart';
import '../regexp.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class ValidateEmailOptions {
  const ValidateEmailOptions({
    this.empty = true,
    this.tooLong = true,
    this.containsWhitespace = true,
    this.invalid = true,
  });

  final bool empty;
  final bool tooLong;
  final bool containsWhitespace;
  final bool invalid;
}

class Email extends ValueObject<EmailFailure, String> {
  factory Email(
    String value, {
    ValidateEmailOptions options = const ValidateEmailOptions(),
  }) {
    if (options.empty && value.isEmpty) {
      return Email._(left(EmailFailure.empty));
    }

    if (options.tooLong && value.isNotEmpty && value.length > VVOConfig.value.maxLength) {
      return Email._(left(EmailFailure.tooLong));
    }

    if (options.containsWhitespace && value.isNotEmpty && value.contains(patternWhitespace)) {
      return Email._(left(EmailFailure.containsWhitespace));
    }

    if (options.invalid && value.isNotEmpty && !patternExactEmail.hasMatch(value)) {
      return Email._(left(EmailFailure.invalid));
    }

    return Email._(right(value));
  }

  factory Email.empty() => Email._(left(EmailFailure.empty));

  Email._(super.value);
}
