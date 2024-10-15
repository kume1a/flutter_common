// import 'package:libphonenumber/libphonenumber.dart';

// import '../core/either.dart';
// import '../error/value_error.dart';
// import 'core/value_object.dart';

// class PhoneNumber extends ValueObject<ValueError, String> {
//   PhoneNumber._(super.value);

//   factory PhoneNumber.empty() => PhoneNumber._(left(ValueError.empty));

//   static Future<PhoneNumber> create(String phoneNumber, String isoCode) async {
//     if (phoneNumber.isEmpty) {
//       return PhoneNumber._(left(ValueError.empty));
//     } else if (phoneNumber.length < 2) {
//       return PhoneNumber._(left(ValueError.invalid));
//     }

//     final bool isValid = await PhoneNumberUtil.isValidPhoneNumber(
//           phoneNumber: phoneNumber,
//           isoCode: isoCode,
//         ) ??
//         false;

//     if (!isValid) {
//       return PhoneNumber._(left(ValueError.invalid));
//     }

//     return PhoneNumber._(right(phoneNumber));
//   }
// }
