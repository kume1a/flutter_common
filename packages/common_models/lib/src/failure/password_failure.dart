enum PasswordFailure {
  empty,
  tooShort,
  noUppercaseCharsFound,
  noLowercaseCharsFound,
  noDigitsFound,
  noSpecialCharsFound;

  T when<T>({
    required T Function() empty,
    required T Function() tooShort,
    required T Function() noUppercaseCharsFound,
    required T Function() noLowercaseCharsFound,
    required T Function() noDigitsFound,
    required T Function() noSpecialCharsFound,
  }) {
    switch (this) {
      case PasswordFailure.empty:
        return empty();
      case PasswordFailure.tooShort:
        return tooShort();
      case PasswordFailure.noUppercaseCharsFound:
        return noUppercaseCharsFound();
      case PasswordFailure.noLowercaseCharsFound:
        return noLowercaseCharsFound();
      case PasswordFailure.noDigitsFound:
        return noDigitsFound();
      case PasswordFailure.noSpecialCharsFound:
        return noSpecialCharsFound();
    }
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
