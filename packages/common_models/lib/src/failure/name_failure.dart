enum NameFailure {
  empty,
  tooShort,
  tooLong;

  T when<T>({
    required T Function() empty,
    required T Function() tooShort,
    required T Function() tooLong,
  }) {
    switch (this) {
      case NameFailure.empty:
        return empty();
      case NameFailure.tooShort:
        return tooShort();
      case NameFailure.tooLong:
        return tooLong();
    }
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
