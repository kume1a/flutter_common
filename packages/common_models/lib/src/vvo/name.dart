import '../core/either.dart';
import '../failure/name_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class Name extends ValueObject<NameFailure, String> {
  factory Name(String name) {
    if (name.trim().isEmpty) {
      return Name._(left(NameFailure.empty()));
    }
    if (name.length < VVOConfig.name.minLength) {
      return Name._(left(NameFailure.tooShort()));
    }
    return Name._(right(name));
  }

  factory Name.empty() => Name._(left(NameFailure.empty()));

  const Name._(Either<NameFailure, String> value) : super(value);
}
