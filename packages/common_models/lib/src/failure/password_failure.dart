enum PasswordFailure {
  empty,
  tooShort,
  tooLong,
  noUppercaseCharsFound,
  noLowercaseCharsFound,
  noDigitsFound,
  noSpecialCharsFound,
  containsWhitespace;

  T when<T>({
    required T Function() empty,
    required T Function() tooShort,
    required T Function() tooLong,
    required T Function() noUppercaseCharsFound,
    required T Function() noLowercaseCharsFound,
    required T Function() noDigitsFound,
    required T Function() noSpecialCharsFound,
    required T Function() containsWhitespace,
  }) {
    switch (this) {
      case PasswordFailure.empty:
        return empty();
      case PasswordFailure.tooShort:
        return tooShort();
      case PasswordFailure.tooLong:
        return tooLong();
      case PasswordFailure.noUppercaseCharsFound:
        return noUppercaseCharsFound();
      case PasswordFailure.noLowercaseCharsFound:
        return noLowercaseCharsFound();
      case PasswordFailure.noDigitsFound:
        return noDigitsFound();
      case PasswordFailure.noSpecialCharsFound:
        return noSpecialCharsFound();
      case PasswordFailure.containsWhitespace:
        return containsWhitespace();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooShort,
    T Function()? tooLong,
    T Function()? noUppercaseCharsFound,
    T Function()? noLowercaseCharsFound,
    T Function()? noDigitsFound,
    T Function()? noSpecialCharsFound,
    T Function()? containsWhitespace,
  }) {
    return when(
      empty: empty ?? orElse,
      tooShort: tooShort ?? orElse,
      tooLong: tooLong ?? orElse,
      noUppercaseCharsFound: noUppercaseCharsFound ?? orElse,
      noLowercaseCharsFound: noLowercaseCharsFound ?? orElse,
      noDigitsFound: noDigitsFound ?? orElse,
      noSpecialCharsFound: noSpecialCharsFound ?? orElse,
      containsWhitespace: containsWhitespace ?? orElse,
    );
  }
}
