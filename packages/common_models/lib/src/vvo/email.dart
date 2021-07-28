import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class EmailVVO extends ValueObject<ValueFailure, String> {
  factory EmailVVO(String email) {
    if (email.isEmpty) {
      return EmailVVO._(left(const ValueFailure.empty()));
    } else if (!_emailPattern.hasMatch(email)) {
      return EmailVVO._(left(const ValueFailure.invalid()));
    }
    return EmailVVO._(right(email));
  }

  factory EmailVVO.empty() => EmailVVO._(left(const ValueFailure.empty()));

  EmailVVO._(Either<ValueFailure, String> value) : super(value);

  static final RegExp _emailPattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
}
