import '../../common_models.dart';
import '../failure/verification_code_failure.dart';

class VerificationCode extends ValueObject<VerificationCodeFailure, String> {
  factory VerificationCode(String verificationCode) {
    if (verificationCode.trim().isEmpty) {
      return VerificationCode._(left(VerificationCodeFailure.empty));
    } else if (verificationCode.length != VVOConfig.verificationCode.length) {
      return VerificationCode._(left(VerificationCodeFailure.invalid));
    }

    return VerificationCode._(right(verificationCode));
  }

  factory VerificationCode.empty() => VerificationCode._(left(VerificationCodeFailure.empty));

  VerificationCode._(Either<VerificationCodeFailure, String> value) : super(value);
}
