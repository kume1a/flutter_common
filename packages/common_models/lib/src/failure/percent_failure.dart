import 'package:freezed_annotation/freezed_annotation.dart';

part 'percent_failure.freezed.dart';

@freezed
class PercentFailure with _$PercentFailure {
  const factory PercentFailure.empty() = _Empty;

  const factory PercentFailure.invalid() = _Invalid;

  const factory PercentFailure.outOfRange() = _OutOfRange;
}
