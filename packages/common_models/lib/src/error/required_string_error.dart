enum RequiredStringError {
  empty,
  tooLong;

  T when<T>({
    required T Function() empty,
    required T Function() tooLong,
  }) {
    return switch (this) {
      RequiredStringError.empty => empty(),
      RequiredStringError.tooLong => tooLong(),
    };
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooLong,
  }) {
    return when(
      empty: empty ?? orElse,
      tooLong: tooLong ?? orElse,
    );
  }
}
