enum GetEntityFailure {
  network,
  unknown,
  notFound;

  T when<T>({
    required T Function() network,
    required T Function() unknown,
    required T Function() notFound,
  }) {
    switch (this) {
      case GetEntityFailure.network:
        return network();
      case GetEntityFailure.unknown:
        return unknown();
      case GetEntityFailure.notFound:
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
