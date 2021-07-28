import 'package:freezed_annotation/freezed_annotation.dart';

part 'value_failure.freezed.dart';

@freezed
class ValueFailure with _$ValueFailure {
  const factory ValueFailure.empty() = _Empty;
  const factory ValueFailure.invalid() = _Invalid;
}