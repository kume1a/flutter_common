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
}
