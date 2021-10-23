import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';

class RefreshableList<T> extends StatelessWidget {
  const RefreshableList({
    Key? key,
    required this.data,
    required this.itemBuilder,
    required this.errorText,
    required this.onRefresh,
    this.padding,
    this.refreshBuilder,
    this.onEmptyListErrorBuilder,
    this.reverse = false,
  })  : listType = ListType.builder,
        super(key: key);

  const RefreshableList.sliver({
    Key? key,
    required this.data,
    required this.itemBuilder,
    required this.errorText,
    required this.onRefresh,
    this.refreshBuilder,
    this.onEmptyListErrorBuilder,
  })  : listType = ListType.sliverBuilder,
        padding = null,
        reverse = false,
        super(key: key);

  final ListType listType;
  final List<T>? data;
  final ItemBuilder<T> itemBuilder;
  final String errorText;
  final VoidCallback onRefresh;

  final EdgeInsets? padding;
  final WidgetBuilder? refreshBuilder;
  final WidgetBuilder? onEmptyListErrorBuilder;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    switch (listType) {
      case ListType.sliverBuilder:
        if ((data == null || data?.isEmpty == true) && onEmptyListErrorBuilder != null) {
          return SliverToBoxAdapter(child: onEmptyListErrorBuilder!.call(context));
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => _itemBuilder(context, index),
            childCount: (data?.length ?? 0) + 1,
          ),
        );
      case ListType.builder:
        if ((data == null || data?.isEmpty == true) && onEmptyListErrorBuilder != null) {
          return onEmptyListErrorBuilder!.call(context);
        }

        return ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: (data?.length ?? 0) + 1,
          reverse: reverse,
          padding: padding,
        );
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index == (data?.length ?? 0)) {
      if (refreshBuilder != null) {
        return refreshBuilder!.call(context);
      }
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              child: Text(
                errorText,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: onRefresh,
              splashRadius: 24,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
    }
    return itemBuilder.call(context, data![index]);
  }
}
