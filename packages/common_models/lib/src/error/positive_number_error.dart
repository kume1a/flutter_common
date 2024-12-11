enum PositiveNumberError {
  empty,
  invalid,
  negative;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
    required T Function() negative,
  }) {
    return switch (this) {
      PositiveNumberError.empty => empty(),
      PositiveNumberError.invalid => invalid(),
      PositiveNumberError.negative => negative(),
    };
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? invalid,
    T Function()? negative,
  }) {
    return when(
      empty: empty ?? orElse,
      invalid: invalid ?? orElse,
      negative: negative ?? orElse,
    );
  }
}
