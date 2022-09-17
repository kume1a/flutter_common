enum SimpleActionFailure {
  network,
  unknown;

  T when<T>({
    required T Function() network,
    required T Function() unknown,
  }) {
    switch (this) {
      case SimpleActionFailure.network:
        return network();
      case SimpleActionFailure.unknown:
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
