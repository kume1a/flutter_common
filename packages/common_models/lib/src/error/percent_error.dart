enum PercentError {
  empty,
  invalid,
  outOfRange;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
    required T Function() outOfRange,
  }) {
    switch (this) {
      case PercentError.empty:
        return empty();
      case PercentError.invalid:
        return invalid();
      case PercentError.outOfRange:
        return outOfRange();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? invalid,
    T Function()? outOfRange,
  }) {
    return when(
      empty: empty ?? orElse,
      invalid: invalid ?? orElse,
      outOfRange: outOfRange ?? orElse,
    );
  }
}
