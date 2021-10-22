import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_action_failure.freezed.dart';

@freezed
class SimpleActionFailure with _$SimpleActionFailure {
  const factory SimpleActionFailure.network() = _Network;

  const factory SimpleActionFailure.unknown() = _Unknown;
}
