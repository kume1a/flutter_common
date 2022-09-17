enum SimpleContentValueFailure {
  empty;

  T when<T>({
    required T Function() empty,
  }) {
    switch (this) {
      case SimpleContentValueFailure.empty:
        return empty();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? empty,
  }) {
    return when(
      empty: empty ?? orElse,
    );
  }
}
