enum RepeatedPasswordError {
  empty,
  doesNotMatch;

  T when<T>({
    required T Function() empty,
    required T Function() doesNotMatch,
  }) {
    switch (this) {
      case RepeatedPasswordError.empty:
        return empty();
      case RepeatedPasswordError.doesNotMatch:
        return doesNotMatch();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? doesNotMatch,
  }) {
    return when(
      empty: empty ?? orElse,
      doesNotMatch: doesNotMatch ?? orElse,
    );
  }
}
