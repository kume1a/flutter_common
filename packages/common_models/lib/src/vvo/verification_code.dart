import '../../common_models.dart';

class VerificationCode extends ValueObject<ValueFailure, String> {
  factory VerificationCode(String verificationCode) {
    if (verificationCode.isEmpty) {
      return VerificationCode._(left(ValueFailure.empty()));
    } else if (verificationCode.length != VVOConfig.verificationCode.length) {
      return VerificationCode._(left(ValueFailure.invalid()));
    }
    return VerificationCode._(right(verificationCode));
  }

  factory VerificationCode.empty() => VerificationCode._(left(ValueFailure.empty()));

  VerificationCode._(Either<ValueFailure, String> value) : super(value);
}
