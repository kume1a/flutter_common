import '../../common_models.dart';

class VerificationCodeVVO extends ValueObject<ValueFailure, String> {
  factory VerificationCodeVVO(String verificationCode) {
    if (verificationCode.isEmpty) {
      return VerificationCodeVVO._(left(const ValueFailure.empty()));
    } else if (verificationCode.length < 4) {
      return VerificationCodeVVO._(left(const ValueFailure.invalid()));
    }
    return VerificationCodeVVO._(right(verificationCode));
  }

  factory VerificationCodeVVO.empty() => VerificationCodeVVO._(left(const ValueFailure.empty()));

  VerificationCodeVVO._(Either<ValueFailure, String> value) : super(value);
}
