import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class PhoneNumberVVO extends ValueObject<ValueFailure, String> {
  factory PhoneNumberVVO(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return PhoneNumberVVO._(left(const ValueFailure.empty()));
    } else if (!_patternPhoneNumber.hasMatch(phoneNumber.trim())) {
      return PhoneNumberVVO._(left(const ValueFailure.invalid()));
    }
    return PhoneNumberVVO._(right(phoneNumber));
  }

  factory PhoneNumberVVO.empty() => PhoneNumberVVO._(left(const ValueFailure.empty()));

  PhoneNumberVVO._(Either<ValueFailure, String> value) : super(value);

  static final RegExp _patternPhoneNumber = RegExp(r'^(995)?\d{9}$');
}
