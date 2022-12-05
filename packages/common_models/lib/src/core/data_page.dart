import 'package:collection/collection.dart';

class DataPage<T> {
  DataPage({
    required this.items,
    required this.count,
  });

  factory DataPage.empty() => DataPage<T>(items: List<T>.empty(growable: true), count: 0);

  final List<T> items;
  final int count;

  DataPage<T> copyWith({
    List<T>? items,
    int? count,
  }) {
    if (const DeepCollectionEquality().equals(items, this.items) && count == this.count) {
      return this;
    }

    return DataPage<T>(
      items: items ?? this.items,
      count: count ?? this.count,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DataPage<T> &&
          runtimeType == other.runtimeType &&
          const DeepCollectionEquality().equals(items, other.items) &&
          count == other.count;

  @override
  int get hashCode => Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(items),
        count.hashCode,
      );

  @override
  String toString() => 'DataPage{items: $items, count: $count}';

  DataPage<T> insert(int index, T item) {
    final List<T> items = List<T>.of(this.items);

    items.insert(index, item);

    return copyWith(
      items: items,
      count: count + 1,
    );
  }

  DataPage<T> replace(
    bool Function(T e) where,
    T Function(T old) replacementResolver,
  ) {
    final int index = this.items.indexWhere(where);
    if (index == -1) {
      return this;
    }

    final T oldItem = this.items[index];

    final List<T> items = List<T>.of(this.items);
    items.removeAt(index);
    items.insert(index, replacementResolver(oldItem));
    return copyWith(items: items);
  }

  DataPage<T> removeWhere(bool Function(T e) test) {
    final List<T> items = List<T>.of(this.items);
    items.removeWhere(test);

    final int lengthDiff = this.items.length - items.length;

    return copyWith(
      items: items,
      count: count - lengthDiff,
    );
  }

  DataPage<T> removeOne(T item) {
    final List<T> items = List<T>.of(this.items);
    final int index = items.indexOf(item);
    if (index == -1) {
      return this;
    }

    items.removeAt(index);

    return copyWith(
      items: items,
      count: count - 1,
    );
  }
}
