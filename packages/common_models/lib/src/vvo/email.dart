import '../core/either.dart';
import '../failure/email_failure.dart';
import '../regexp.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class Email extends ValueObject<EmailFailure, String> {
  factory Email(String email) {
    if (email.isEmpty) {
      return Email._(left(EmailFailure.empty));
    } else if (email.length > VVOConfig.value.maxLength) {
      return Email._(left(EmailFailure.tooLong));
    } else if (email.contains(patternWhitespace)) {
      return Email._(left(EmailFailure.containsWhitespace));
    } else if (!patternEmail.hasMatch(email)) {
      return Email._(left(EmailFailure.invalid));
    }
    return Email._(right(email));
  }

  factory Email.empty() => Email._(left(EmailFailure.empty));

  Email._(Either<EmailFailure, String> value) : super(value);
}
