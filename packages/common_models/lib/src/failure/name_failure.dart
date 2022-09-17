enum NameFailure {
  empty,
  tooShort;

  T when<T>({
    required T Function() empty,
    required T Function() tooShort,
  }) {
    switch (this) {
      case NameFailure.empty:
        return empty();
      case NameFailure.tooShort:
        return tooShort();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
    T Function()? tooShort,
  }) {
    return when(
      empty: empty ?? orElse,
      tooShort: tooShort ?? orElse,
    );
  }
}
