import 'dart:async';
import 'dart:math' as math;

final math.Random _rand = math.Random();

class RetryOptions {
  /// Create a set of [RetryOptions].
  ///
  /// Defaults to 8 attempts, sleeping as following after 1st, 2nd, 3rd, ...,
  /// 7th attempt:
  ///  1. 400 ms +/- 25%
  ///  2. 800 ms +/- 25%
  ///  3. 1600 ms +/- 25%
  ///  4. 3200 ms +/- 25%
  ///  5. 6400 ms +/- 25%
  ///  6. 12800 ms +/- 25%
  ///  7. 25600 ms +/- 25%
  const RetryOptions({
    this.delayFactor = const Duration(milliseconds: 200),
    this.randomizationFactor = 0.25,
    this.maxDelay = const Duration(seconds: 30),
    this.maxAttempts = 8,
  });

  /// Delay factor to double after every attempt.
  ///
  /// Defaults to 200 ms, which results in the following delays:
  ///
  ///  1. 400 ms
  ///  2. 800 ms
  ///  3. 1600 ms
  ///  4. 3200 ms
  ///  5. 6400 ms
  ///  6. 12800 ms
  ///  7. 25600 ms
  ///
  /// Before application of [randomizationFactor].
  final Duration delayFactor;

  /// Percentage the delay should be randomized, given as fraction between
  /// 0 and 1.
  ///
  /// If [randomizationFactor] is `0.25` (default) this indicates 25 % of the
  /// delay should be increased or decreased by 25 %.
  final double randomizationFactor;

  /// Maximum delay between retries, defaults to 30 seconds.
  final Duration maxDelay;

  /// Maximum number of attempts before giving up, defaults to 8.
  final int maxAttempts;

  /// Delay after [attempt] number of attempts.
  ///
  /// This is computed as `pow(2, attempt) * delayFactor`, then is multiplied by
  /// between `-randomizationFactor` and `randomizationFactor` at random.
  Duration delay(int attempt) {
    assert(attempt >= 0, 'attempt cannot be negative');
    if (attempt <= 0) {
      return Duration.zero;
    }
    final double rf = randomizationFactor * (_rand.nextDouble() * 2 - 1) + 1;
    final int exp = math.min(attempt, 31); // prevent overflows.
    final Duration delay = delayFactor * math.pow(2.0, exp) * rf;
    return delay < maxDelay ? delay : maxDelay;
  }

  /// Call [fn] retrying so long as [retryIf] return `true` for the exception
  /// thrown.
  ///
  /// At every retry the [onRetry] function will be called (if given). The
  /// function [fn] will be invoked at-most [this.attempts] times.
  ///
  /// If no [retryIf] function is given this will retry any for any [Exception]
  /// thrown. To retry on an [Error], the error must be caught and _rethrown_
  /// as an [Exception].
  Future<T> retry<T>(
    FutureOr<T> Function() fn, {
    FutureOr<bool> Function(Exception)? retryIf,
    FutureOr<void> Function(Exception)? onRetry,
    FutureOr<bool> Function(T result)? retryIfResult,
  }) async {
    int attempt = 0;
    // ignore: literal_only_boolean_expressions
    while (true) {
      attempt++; // first invocation is the first attempt
      try {
        final T result = await fn();
        final bool? shouldRetry = await retryIfResult?.call(result);
        if (!(shouldRetry ?? false)) {
          return result;
        }
      } on Exception catch (e) {
        if (attempt >= maxAttempts || (retryIf != null && !(await retryIf(e)))) {
          rethrow;
        }
        if (onRetry != null) {
          await onRetry(e);
        }
      }

      // Sleep for a delay
      await Future<void>.delayed(delay(attempt));
    }
  }
}

/// Call [fn] retrying so long as [retryIf] return `true` for the exception
/// thrown, up-to [maxAttempts] times.
///
/// Defaults to 8 attempts, sleeping as following after 1st, 2nd, 3rd, ...,
/// 7th attempt:
///  1. 400 ms +/- 25%
///  2. 800 ms +/- 25%
///  3. 1600 ms +/- 25%
///  4. 3200 ms +/- 25%
///  5. 6400 ms +/- 25%
///  6. 12800 ms +/- 25%
///  7. 25600 ms +/- 25%
///
/// ```dart
/// final response = await retry(
///   // Make a GET request
///   () => http.get('https://google.com').timeout(Duration(seconds: 5)),
///   // Retry on SocketException or TimeoutException
///   retryIf: (e) => e is SocketException || e is TimeoutException,
/// );
/// print(response.body);
/// ```
///
/// If no [retryIf] function is given this will retry any for any [Exception]
/// thrown. To retry on an [Error], the error must be caught and _rethrown_
/// as an [Exception].
Future<T> retry<T>(
  FutureOr<T> Function() fn, {
  Duration delayFactor = const Duration(milliseconds: 200),
  double randomizationFactor = 0.25,
  Duration maxDelay = const Duration(seconds: 30),
  int maxAttempts = 8,
  FutureOr<bool> Function(Exception)? retryIf,
  FutureOr<void> Function(Exception)? onRetry,
  FutureOr<bool> Function(T result)? retryIfResult,
}) =>
    RetryOptions(
      delayFactor: delayFactor,
      randomizationFactor: randomizationFactor,
      maxDelay: maxDelay,
      maxAttempts: maxAttempts,
    ).retry(
      fn,
      retryIf: retryIf,
      onRetry: onRetry,
      retryIfResult: retryIfResult,
    );
