import '../core/either.dart';
import '../failure/simple_content_value_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class SimpleContentValue extends ValueObject<SimpleContentValueFailure, String> {
  factory SimpleContentValue(String value) {
    if (value.trim().isEmpty) {
      return SimpleContentValue._(left(SimpleContentValueFailure.empty));
    }

    if (value.length > VVOConfig.simpleContent.maxLength) {
      return SimpleContentValue._(left(SimpleContentValueFailure.tooLong));
    }

    return SimpleContentValue._(right(value));
  }

  factory SimpleContentValue.empty() => SimpleContentValue._(left(SimpleContentValueFailure.empty));

  SimpleContentValue._(super.value);
}
