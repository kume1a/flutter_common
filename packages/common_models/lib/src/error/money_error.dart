enum MoneyError {
  empty,
  invalid,
  lessThanMin,
  moreThanMax;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
    required T Function() lessThanMin,
    required T Function() moreThanMax,
  }) {
    switch (this) {
      case MoneyError.empty:
        return empty();
      case MoneyError.invalid:
        return invalid();
      case MoneyError.lessThanMin:
        return lessThanMin();
      case MoneyError.moreThanMax:
        return moreThanMax();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? invalid,
    T Function()? lessThanMin,
    T Function()? moreThanMax,
  }) {
    return when(
      empty: empty ?? orElse,
      invalid: invalid ?? orElse,
      lessThanMin: lessThanMin ?? orElse,
      moreThanMax: moreThanMax ?? orElse,
    );
  }
}
