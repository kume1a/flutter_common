enum PercentError {
  empty,
  invalid,
  outOfRange;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
    required T Function() outOfRange,
  }) {
    return switch (this) {
      PercentError.empty => empty(),
      PercentError.invalid => invalid(),
      PercentError.outOfRange => outOfRange(),
    };
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
