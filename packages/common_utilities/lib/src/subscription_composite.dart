import 'dart:async';

final class SubscriptionComposite {
  final List<StreamSubscription<dynamic>> subscriptions = [];

  void add(StreamSubscription<dynamic> subscription) {
    subscriptions.add(subscription);
  }

  void addAll(List<StreamSubscription<dynamic>> subscriptions) {
    this.subscriptions.addAll(subscriptions);
  }

  Future<void> closeAll() async {
    final closeFutures = subscriptions.map((subscription) => subscription.cancel());

    await Future.wait(closeFutures);

    subscriptions.clear();
  }
}
