import 'package:freezed_annotation/freezed_annotation.dart';

part 'repeated_password_failure.freezed.dart';

@freezed
class RepeatedPasswordFailure with _$RepeatedPasswordFailure {
  const factory RepeatedPasswordFailure.none() = _None;
  const factory RepeatedPasswordFailure.doesntMatch() = _DoesntMatch;
}