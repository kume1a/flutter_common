import 'package:freezed_annotation/freezed_annotation.dart';

part 'password_failure.freezed.dart';

@freezed
class PasswordFailure with _$PasswordFailure {
  const factory PasswordFailure.empty() = _Empty;
  const factory PasswordFailure.shortPassword() = _ShortPassword;
  const factory PasswordFailure.noUpperCaseCharacterPresent() = _NoUpperCaseCharacterPresent;
  const factory PasswordFailure.noLowerCaseCharacterPresent() = _NoLowerCaseCharacterPresent;
  const factory PasswordFailure.noDigitsPresent() = _NoDigitsPresent;
  const factory PasswordFailure.noSpecialCharacterPresent() = _NoSpecialCharacterPresent;
}
