import '../core/either.dart';
import '../error/name_error.dart';
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

class Name extends ValueObject<NameError, String> {
  factory Name(
    String value, {
    ValidateNameOptions options = const ValidateNameOptions(),
  }) {
    if (options.empty && value.trim().isEmpty) {
      return Name._(left(NameError.empty));
    }

    if (options.tooShort && value.isNotEmpty && value.length < VVOConfig.name.minLength) {
      return Name._(left(NameError.tooShort));
    }

    if (options.tooLong && value.length > VVOConfig.name.maxLength) {
      return Name._(left(NameError.tooLong));
    }

    return Name._(right(value));
  }

  factory Name.empty() => Name._(left(NameError.empty));

  const Name._(super.value);
}
