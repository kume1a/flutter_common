enum ValueFailure {
  empty,
  tooLong,
  invalid;

  T when<T>({
    required T Function() empty,
    required T Function() tooLong,
    required T Function() invalid,
  }) {
    switch (this) {
      case ValueFailure.empty:
        return empty();
      case ValueFailure.tooLong:
        return tooLong();
      case ValueFailure.invalid:
        return invalid();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooLong,
    T Function()? invalid,
  }) {
    return when(
      empty: empty ?? orElse,
      tooLong: tooLong ?? orElse,
      invalid: invalid ?? orElse,
    );
  }
}
