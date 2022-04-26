import '../core/either.dart';
import '../failure/repeated_password_failure.dart';
import 'core/value_object.dart';

class RepeatedPassword extends ValueObject<RepeatedPasswordFailure, String> {
  factory RepeatedPassword(String password, String repeatedPassword) {
    if (repeatedPassword.isEmpty) {
      return RepeatedPassword._(left(const RepeatedPasswordFailure.none()));
    }
    if (password != repeatedPassword) {
      return RepeatedPassword._(left(const RepeatedPasswordFailure.doesntMatch()));
    }
    return RepeatedPassword._(right(repeatedPassword));
  }

  factory RepeatedPassword.empty() =>
      RepeatedPassword._(left(const RepeatedPasswordFailure.none()));

  RepeatedPassword._(Either<RepeatedPasswordFailure, String> value) : super(value);
}
