import '../../common_models.dart';
import '../failure/repeated_password_failure.dart';

class RepeatedPasswordVVO extends ValueObject<RepeatedPasswordFailure, String> {
  factory RepeatedPasswordVVO(String password, String repeatedPassword) {
    if (repeatedPassword.isEmpty) {
      return RepeatedPasswordVVO._(left(const RepeatedPasswordFailure.none()));
    }
    if (password != repeatedPassword) {
      return RepeatedPasswordVVO._(left(const RepeatedPasswordFailure.doesntMatch()));
    }
    return RepeatedPasswordVVO._(right(repeatedPassword));
  }

  factory RepeatedPasswordVVO.empty() => RepeatedPasswordVVO._(left(const RepeatedPasswordFailure.none()));

  RepeatedPasswordVVO._(Either<RepeatedPasswordFailure, String> value) : super(value);
}
