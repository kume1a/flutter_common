import 'package:flutter/material.dart';

import 'core/enums/list_type.dart';
import 'core/typedefs.dart';

class RefreshableList<T> extends StatelessWidget {
  const RefreshableList({
    Key? key,
    required this.data,
    required this.itemBuilder,
    required this.errorText,
    required this.onRefresh,
    this.padding,
    this.refreshBuilder,
  })  : listType = ListType.builder,
        super(key: key);

  const RefreshableList.sliver({
    Key? key,
    required this.data,
    required this.itemBuilder,
    required this.errorText,
    required this.onRefresh,
    this.refreshBuilder,
  })  : listType = ListType.sliverBuilder,
        padding = null,
        super(key: key);

  final ListType listType;
  final List<T>? data;
  final ItemBuilder<T> itemBuilder;
  final String errorText;
  final VoidCallback onRefresh;

  final EdgeInsets? padding;
  final WidgetBuilder? refreshBuilder;

  @override
  Widget build(BuildContext context) {
    switch (listType) {
      case ListType.sliverBuilder:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) => _itemBuilder(context, index),
            childCount: (data?.length ?? 0) + 1,
          ),
        );
      case ListType.builder:
        return ListView.builder(
          itemBuilder: _itemBuilder,
          itemCount: (data?.length ?? 0) + 1,
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
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(errorText),
            const SizedBox(width: 12),
            IconButton(
              onPressed: onRefresh,
              splashRadius: 28,
              icon: const Icon(Icons.refresh),
            ),
          ],
        ),
      );
    }
    return itemBuilder.call(context, data![index]);
  }
}
