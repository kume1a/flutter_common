enum NetworkCallError {
  network,
  unknown;

  T when<T>({
    required T Function() network,
    required T Function() unknown,
  }) {
    switch (this) {
      case NetworkCallError.network:
        return network();
      case NetworkCallError.unknown:
        return unknown();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? network,
    T Function()? unknown,
  }) {
    return when(
      network: network ?? orElse,
      unknown: unknown ?? orElse,
    );
  }
}
