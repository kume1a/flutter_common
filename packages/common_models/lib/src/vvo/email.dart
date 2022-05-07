import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class Email extends ValueObject<ValueFailure, String> {
  factory Email(String email) {
    if (email.isEmpty) {
      return Email._(left(ValueFailure.empty()));
    } else if (!_emailPattern.hasMatch(email)) {
      return Email._(left(ValueFailure.invalid()));
    }
    return Email._(right(email));
  }

  factory Email.empty() => Email._(left(ValueFailure.empty()));

  Email._(Either<ValueFailure, String> value) : super(value);

  static final RegExp _emailPattern =
      RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
