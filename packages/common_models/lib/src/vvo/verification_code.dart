import '../core/either.dart';
import '../error/value_error.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class VerificationCode extends ValueObject<ValueError, String> {
  factory VerificationCode(String verificationCode) {
    if (verificationCode.trim().isEmpty) {
      return VerificationCode._(left(ValueError.empty));
    }

    if (verificationCode.length != VVOConfig.verificationCode.length) {
      return VerificationCode._(left(ValueError.invalid));
    }

    return VerificationCode._(right(verificationCode));
  }

  factory VerificationCode.empty() => VerificationCode._(left(ValueError.empty));

  VerificationCode._(super.value);
}
