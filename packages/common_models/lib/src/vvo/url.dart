import '../core/either.dart';
import '../failure/value_failure.dart';
import '../regexp.dart';
import 'core/value_object.dart';

class Url extends ValueObject<ValueFailure, String> {
  factory Url(String url) {
    if (url.isEmpty) {
      return Url._(left(ValueFailure.empty));
    }

    if (!patternUrl.hasMatch(url)) {
      return Url._(left(ValueFailure.invalid));
    }

    return Url._(right(url));
  }

  factory Url.empty() => Url._(left(ValueFailure.empty));

  Url._(super.value);
}
