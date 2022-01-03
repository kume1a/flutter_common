import '../core/either.dart';
import '../failure/value_failure.dart';
import 'core/value_object.dart';

class UrlVVO extends ValueObject<ValueFailure, String> {
  factory UrlVVO(String url) {
    if (url.isEmpty) {
      return UrlVVO._(left(const ValueFailure.empty()));
    } else if (!_urlPattern.hasMatch(url)) {
      return UrlVVO._(left(const ValueFailure.invalid()));
    }
    return UrlVVO._(right(url));
  }

  factory UrlVVO.empty() => UrlVVO._(left(const ValueFailure.empty()));

  UrlVVO._(Either<ValueFailure, String> value) : super(value);

  static final RegExp _urlPattern = RegExp(
      r'^https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)');
}
