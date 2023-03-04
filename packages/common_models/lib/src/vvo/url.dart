import '../core/either.dart';
import '../failure/url_failure.dart';
import 'core/value_object.dart';

class Url extends ValueObject<UrlFailure, String> {
  factory Url(String url) {
    if (url.isEmpty) {
      return Url._(left(UrlFailure.empty));
    } else if (!_urlPattern.hasMatch(url)) {
      return Url._(left(UrlFailure.invalid));
    }
    return Url._(right(url));
  }

  factory Url.empty() => Url._(left(UrlFailure.empty));

  Url._(Either<UrlFailure, String> value) : super(value);

  static final RegExp _urlPattern = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
  );
}
