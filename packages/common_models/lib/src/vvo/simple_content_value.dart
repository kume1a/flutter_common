import '../core/either.dart';
import '../failure/simple_content_value_failure.dart';
import 'core/value_object.dart';

class SimpleContentValue extends ValueObject<SimpleContentValueFailure, String> {
  factory SimpleContentValue(String value) {
    if (value.trim().isEmpty) {
      return SimpleContentValue._(left(SimpleContentValueFailure.empty()));
    }
    return SimpleContentValue._(right(value));
  }

  factory SimpleContentValue.empty() =>
      SimpleContentValue._(left(SimpleContentValueFailure.empty()));

  SimpleContentValue._(Either<SimpleContentValueFailure, String> value) : super(value);
}
