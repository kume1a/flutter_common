enum ActionFailure {
  network,
  unknown;

  T when<T>({
    required T Function() network,
    required T Function() unknown,
  }) {
    switch (this) {
      case ActionFailure.network:
        return network();
      case ActionFailure.unknown:
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
