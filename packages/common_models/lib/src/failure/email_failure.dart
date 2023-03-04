enum EmailFailure {
  empty,
  tooLong,
  invalid,
  containsWhitespace;

  T when<T>({
    required T Function() empty,
    required T Function() tooLong,
    required T Function() invalid,
    required T Function() containsWhitespace,
  }) {
    switch (this) {
      case EmailFailure.empty:
        return empty();
      case EmailFailure.tooLong:
        return tooLong();
      case EmailFailure.invalid:
        return invalid();
      case EmailFailure.containsWhitespace:
        return containsWhitespace();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooLong,
    T Function()? invalid,
    T Function()? containsWhitespace,
  }) {
    return when(
      empty: empty ?? orElse,
      tooLong: tooLong ?? orElse,
      invalid: invalid ?? orElse,
      containsWhitespace: containsWhitespace ?? orElse,
    );
  }
}
