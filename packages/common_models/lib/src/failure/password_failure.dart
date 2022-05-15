abstract class PasswordFailure {
  const PasswordFailure._();

  factory PasswordFailure.empty() => const _Empty._();

  factory PasswordFailure.tooShort() => const _TooShort._();

  factory PasswordFailure.noUppercaseCharsFound() => const _NoUppercaseCharsFound._();

  factory PasswordFailure.noLowercaseCharsFound() => const _NoLowerCaseChartFound._();

  factory PasswordFailure.noDigitsFound() => const _NoDigitsFound._();

  factory PasswordFailure.noSpecialCharsFound() => const _NoSpecialCharsFound._();

  T when<T>({
    required T Function() empty,
    required T Function() tooShort,
    required T Function() noUppercaseCharsFound,
    required T Function() noLowercaseCharsFound,
    required T Function() noDigitsFound,
    required T Function() noSpecialCharsFound,
  }) {
    if (this is _Empty) {
      return empty();
    } else if (this is _TooShort) {
      return tooShort();
    } else if (this is _NoUppercaseCharsFound) {
      return noUppercaseCharsFound();
    } else if (this is _NoLowerCaseChartFound) {
      return noLowercaseCharsFound();
    } else if (this is _NoDigitsFound) {
      return noDigitsFound();
    } else if (this is _NoSpecialCharsFound) {
      return noSpecialCharsFound();
    }

    throw Exception('unsupported subclass');
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooShort,
    T Function()? noUppercaseCharsFound,
    T Function()? noLowercaseCharsFound,
    T Function()? noDigitsFound,
    T Function()? noSpecialCharsFound,
  }) {
    return when(
      empty: empty ?? orElse,
      tooShort: tooShort ?? orElse,
      noUppercaseCharsFound: noUppercaseCharsFound ?? orElse,
      noLowercaseCharsFound: noLowercaseCharsFound ?? orElse,
      noDigitsFound: noDigitsFound ?? orElse,
      noSpecialCharsFound: noSpecialCharsFound ?? orElse,
    );
  }
}

class _Empty extends PasswordFailure {
  const _Empty._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _Empty && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PasswordFailure._Empty';
}

class _TooShort extends PasswordFailure {
  const _TooShort._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _TooShort && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PasswordFailure._TooShort';
}

class _NoUppercaseCharsFound extends PasswordFailure {
  const _NoUppercaseCharsFound._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _NoUppercaseCharsFound && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PasswordFailure._NoUppercaseCharsFound';
}

class _NoLowerCaseChartFound extends PasswordFailure {
  const _NoLowerCaseChartFound._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _NoLowerCaseChartFound && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PasswordFailure._NoLowerCaseChartFound';
}

class _NoDigitsFound extends PasswordFailure {
  const _NoDigitsFound._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _NoDigitsFound && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PasswordFailure._NoDigitsFound';
}

class _NoSpecialCharsFound extends PasswordFailure {
  const _NoSpecialCharsFound._() : super._();

  @override
  bool operator ==(Object other) =>
      identical(this, other) || other is _NoSpecialCharsFound && runtimeType == other.runtimeType;

  @override
  int get hashCode => 0;

  @override
  String toString() => 'PasswordFailure._NoSpecialCharsFound';
}
