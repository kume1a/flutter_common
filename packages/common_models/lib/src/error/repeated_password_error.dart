enum RepeatedPasswordError {
  empty,
  doesNotMatch;

  T when<T>({
    required T Function() empty,
    required T Function() doesNotMatch,
  }) {
    return switch (this) {
      RepeatedPasswordError.empty => empty(),
      RepeatedPasswordError.doesNotMatch => doesNotMatch(),
    };
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
