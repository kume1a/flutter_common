enum ValueError {
  empty,
  invalid;

  T when<T>({
    required T Function() empty,
    required T Function() invalid,
  }) {
    return switch (this) {
      ValueError.empty => empty(),
      ValueError.invalid => invalid(),
    };
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
