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
    return switch (this) {
      MoneyError.empty => empty(),
      MoneyError.invalid => invalid(),
      MoneyError.lessThanMin => lessThanMin(),
      MoneyError.moreThanMax => moreThanMax(),
    };
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
