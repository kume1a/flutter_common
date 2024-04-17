import '../core/either.dart';
import '../error/repeated_password_error.dart';
import 'core/value_object.dart';

class RepeatedPassword extends ValueObject<RepeatedPasswordError, String> {
  factory RepeatedPassword(String password, String repeatedPassword) {
    if (repeatedPassword.isEmpty) {
      return RepeatedPassword._(left(RepeatedPasswordError.empty));
    }

    if (password != repeatedPassword) {
      return RepeatedPassword._(left(RepeatedPasswordError.doesNotMatch));
    }

    return RepeatedPassword._(right(repeatedPassword));
  }

  factory RepeatedPassword.empty() => RepeatedPassword._(left(RepeatedPasswordError.empty));

  RepeatedPassword._(super.value);
}
