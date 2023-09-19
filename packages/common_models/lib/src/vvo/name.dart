import '../core/either.dart';
import '../failure/name_failure.dart';
import 'core/value_object.dart';
import 'core/vvo_config.dart';

class ValidateNameOptions {
  const ValidateNameOptions({
    this.empty = true,
    this.tooShort = true,
    this.tooLong = true,
  });

  final bool empty;
  final bool tooShort;
  final bool tooLong;
}

class Name extends ValueObject<NameFailure, String> {
  factory Name(
    String name, {
    ValidateNameOptions options = const ValidateNameOptions(),
  }) {
    if (options.empty && name.trim().isEmpty) {
      return Name._(left(NameFailure.empty));
    }

    if (options.tooShort && name.length < VVOConfig.name.minLength) {
      return Name._(left(NameFailure.tooShort));
    }

    if (options.tooLong && name.length > VVOConfig.name.maxLength) {
      return Name._(left(NameFailure.tooLong));
    }

    return Name._(right(name));
  }

  factory Name.empty() => Name._(left(NameFailure.empty));

  const Name._(Either<NameFailure, String> value) : super(value);
}
