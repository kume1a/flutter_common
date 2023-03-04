enum PriceFailure {
  empty,
  invalid;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
  }) {
    switch (this) {
      case PriceFailure.empty:
        return empty();
      case PriceFailure.invalid:
        return invalid();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? invalid,
  }) {
    return when(
      empty: empty ?? orElse,
      invalid: invalid ?? orElse,
    );
  }
}
