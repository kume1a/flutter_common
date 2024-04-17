enum EmailError {
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
      case EmailError.empty:
        return empty();
      case EmailError.tooLong:
        return tooLong();
      case EmailError.invalid:
        return invalid();
      case EmailError.containsWhitespace:
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
