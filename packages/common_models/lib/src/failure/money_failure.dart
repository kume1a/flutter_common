enum MoneyFailure {
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
      case MoneyFailure.empty:
        return empty();
      case MoneyFailure.invalid:
        return invalid();
      case MoneyFailure.lessThanMin:
        return lessThanMin();
      case MoneyFailure.moreThanMax:
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
