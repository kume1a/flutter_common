import '../core/either.dart';
import '../failure/name_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class NameVVO extends ValueObject<NameFailure, String> {
  factory NameVVO(String name) {
    if (name.isEmpty) {
      return NameVVO._(left(const NameFailure.empty()));
    }
    if (name.length < VVOConfig.nameVVOConfig.minLength) {
      return NameVVO._(left(const NameFailure.tooShort()));
    }
    return NameVVO._(right(name));
  }

  factory NameVVO.empty() => NameVVO('');

  const NameVVO._(Either<NameFailure, String> value) : super(value);
}
