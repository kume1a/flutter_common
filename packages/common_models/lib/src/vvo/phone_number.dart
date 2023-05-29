import 'package:libphonenumber_plugin/libphonenumber_plugin.dart';

import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class PhoneNumber extends ValueObject<ValueFailure, String> {
  PhoneNumber._(Either<ValueFailure, String> value) : super(value);

  factory PhoneNumber.empty() => PhoneNumber._(left(ValueFailure.empty));

  static Future<PhoneNumber> create(String phoneNumber, String isoCode) async {
    if (phoneNumber.isEmpty) {
      return PhoneNumber._(left(ValueFailure.empty));
    } else if (phoneNumber.length < 2) {
      return PhoneNumber._(left(ValueFailure.invalid));
    }

    final bool isValid = await PhoneNumberUtil.isValidPhoneNumber(phoneNumber, isoCode) ?? false;

    if (!isValid) {
      return PhoneNumber._(left(ValueFailure.invalid));
    }

    return PhoneNumber._(right(phoneNumber));
  }
}
