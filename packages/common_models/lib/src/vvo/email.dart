import '../core/either.dart';
import '../failure/email_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class Email extends ValueObject<EmailFailure, String> {
  factory Email(String email) {
    if (email.isEmpty) {
      return Email._(left(EmailFailure.empty));
    } else if (email.length > VVOConfig.value.maxLength) {
      return Email._(left(EmailFailure.tooLong));
    } else if (email.contains(_patternWhitespace)) {
      return Email._(left(EmailFailure.containsWhitespace));
    } else if (!_patternEmail.hasMatch(email)) {
      return Email._(left(EmailFailure.invalid));
    }
    return Email._(right(email));
  }

  factory Email.empty() => Email._(left(EmailFailure.empty));

  Email._(Either<EmailFailure, String> value) : super(value);

  static final RegExp _patternEmail = RegExp(
      r'''^(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9][0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])$''');
  static final RegExp _patternWhitespace = RegExp(r'\s');
}
