enum PositiveNumberFailure {
  empty,
  invalid,
  negative;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
    required T Function() negative,
  }) {
    switch (this) {
      case PositiveNumberFailure.empty:
        return empty();
      case PositiveNumberFailure.invalid:
        return invalid();
      case PositiveNumberFailure.negative:
        return negative();
    }
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
