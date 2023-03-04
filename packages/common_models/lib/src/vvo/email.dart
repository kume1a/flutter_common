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

  static final RegExp _patternEmail =
      RegExp(r"^[a-zA-Z\d.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z\d]+\.[a-zA-Z]+");
  static final RegExp _patternWhitespace = RegExp(r'\s');
}
