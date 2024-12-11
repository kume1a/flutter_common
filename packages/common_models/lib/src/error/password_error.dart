enum PasswordError {
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
    return switch (this) {
      PasswordError.empty => empty(),
      PasswordError.tooShort => tooShort(),
      PasswordError.tooLong => tooLong(),
      PasswordError.noUppercaseCharsFound => noUppercaseCharsFound(),
      PasswordError.noLowercaseCharsFound => noLowercaseCharsFound(),
      PasswordError.noDigitsFound => noDigitsFound(),
      PasswordError.noSpecialCharsFound => noSpecialCharsFound(),
      PasswordError.containsWhitespace => containsWhitespace(),
    };
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
