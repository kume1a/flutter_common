enum UrlFailure {
  empty,
  invalid;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
  }) {
    switch (this) {
      case UrlFailure.empty:
        return empty();
      case UrlFailure.invalid:
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
