import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class Url extends ValueObject<ValueFailure, String> {
  factory Url(String url) {
    if (url.isEmpty) {
      return Url._(left(ValueFailure.empty()));
    } else if (!_urlPattern.hasMatch(url)) {
      return Url._(left(ValueFailure.invalid()));
    }
    return Url._(right(url));
  }

  factory Url.empty() => Url._(left(ValueFailure.empty()));

  Url._(Either<ValueFailure, String> value) : super(value);

  static final RegExp _urlPattern = RegExp(
    r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)',
  );
}
