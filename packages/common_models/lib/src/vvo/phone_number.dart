import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class PhoneNumber extends ValueObject<ValueFailure, String> {
  factory PhoneNumber(String phoneNumber) {
    if (phoneNumber.isEmpty) {
      return PhoneNumber._(left(ValueFailure.empty()));
    } else if (!_patternPhoneNumber.hasMatch(phoneNumber.trim())) {
      return PhoneNumber._(left(ValueFailure.invalid()));
    }
    return PhoneNumber._(right(phoneNumber));
  }

  factory PhoneNumber.empty() => PhoneNumber._(left(ValueFailure.empty()));

  PhoneNumber._(Either<ValueFailure, String> value) : super(value);

  static final RegExp _patternPhoneNumber = RegExp(r'^(995)?\d{9}$');
}
