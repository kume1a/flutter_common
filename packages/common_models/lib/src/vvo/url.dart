import '../core/either.dart';
import '../error/value_error.dart';
import '../regexp.dart';
import 'core/value_object.dart';

class Url extends ValueObject<ValueError, String> {
  factory Url(String url) {
    if (url.isEmpty) {
      return Url._(left(ValueError.empty));
    }

    if (!patternUrl.hasMatch(url)) {
      return Url._(left(ValueError.invalid));
    }

    return Url._(right(url));
  }

  factory Url.empty() => Url._(left(ValueError.empty));

  Url._(super.value);
}
