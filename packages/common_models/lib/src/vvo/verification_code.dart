import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class VerificationCode extends ValueObject<ValueFailure, String> {
  factory VerificationCode(String verificationCode) {
    if (verificationCode.trim().isEmpty) {
      return VerificationCode._(left(ValueFailure.empty));
    } else if (verificationCode.length != VVOConfig.verificationCode.length) {
      return VerificationCode._(left(ValueFailure.invalid));
    }

    return VerificationCode._(right(verificationCode));
  }

  factory VerificationCode.empty() => VerificationCode._(left(ValueFailure.empty));

  VerificationCode._(Either<ValueFailure, String> value) : super(value);
}
