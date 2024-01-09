extension ListX<T> on List<T> {
  List<T> replace(
    bool Function(T e) where,
    T Function(T old) replacementResolver,
  ) {
    final int index = indexWhere(where);
    if (index == -1) {
      return this;
    }

    final T oldItem = this[index];

    final items = List<T>.of(this);
    items.removeAt(index);
    items.insert(index, replacementResolver(oldItem));

    return items;
  }
}
