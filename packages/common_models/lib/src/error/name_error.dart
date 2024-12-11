enum NameError {
  empty,
  tooShort,
  tooLong;

  T when<T>({
    required T Function() empty,
    required T Function() tooShort,
    required T Function() tooLong,
  }) {
    return switch (this) {
      NameError.empty => empty(),
      NameError.tooShort => tooShort(),
      NameError.tooLong => tooLong(),
    };
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooShort,
    T Function()? tooLong,
  }) {
    return when(
      empty: empty ?? orElse,
      tooShort: tooShort ?? orElse,
      tooLong: tooLong ?? orElse,
    );
  }
}
