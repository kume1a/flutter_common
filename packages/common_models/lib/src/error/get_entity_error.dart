enum GetEntityError {
  network,
  unknown,
  notFound;

  T when<T>({
    required T Function() network,
    required T Function() unknown,
    required T Function() notFound,
  }) {
    switch (this) {
      case GetEntityError.network:
        return network();
      case GetEntityError.unknown:
        return unknown();
      case GetEntityError.notFound:
        return notFound();
    }
  }

  T maybeWhen<T>({
    required T Function() orElse,
    T Function()? network,
    T Function()? notFound,
    T Function()? unknown,
  }) {
    return when(
      network: network ?? orElse,
      unknown: unknown ?? orElse,
      notFound: notFound ?? orElse,
    );
  }
}
