import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';

class PagedGrid<T> extends StatelessWidget {
  const PagedGrid({
    required this.gridDelegate,
    required this.totalCount,
    required this.items,
    required this.request,
    required this.itemBuilder,
    this.loadingBuilder,
    this.scrollController,
    this.padding,
    this.onEmptyListBuilder,
  }) : listType = ListType.builder;

  const PagedGrid.sliver({
    required this.gridDelegate,
    required this.totalCount,
    required this.items,
    required this.request,
    required this.itemBuilder,
    this.loadingBuilder,
    this.onEmptyListBuilder,
  })  : listType = ListType.sliverBuilder,
        padding = null,
        scrollController = null;

  final SliverGridDelegate gridDelegate;
  final ListType listType;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final VoidCallback request;
  final ItemBuilder<T> itemBuilder;
  final WidgetBuilder? loadingBuilder;
  final List<T> items;
  final int totalCount;
  final WidgetBuilder? onEmptyListBuilder;

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) {
      switch (listType) {
        case ListType.sliverBuilder:
          return SliverToBoxAdapter(
            child: onEmptyListBuilder?.call(context),
          );
        case ListType.builder:
          if (onEmptyListBuilder != null) {
            return onEmptyListBuilder!.call(context);
          }
          return const SizedBox.shrink();
      }
    }

    final int l = items.length;
    final int itemCount = totalCount <= l ? l : l + 1;
    switch (listType) {
      case ListType.sliverBuilder:
        return SliverGrid(
          gridDelegate: gridDelegate,
          delegate: SliverChildBuilderDelegate(
            _itemBuilder,
            childCount: itemCount,
          ),
        );
      case ListType.builder:
        return GridView.builder(
          itemCount: itemCount,
          gridDelegate: gridDelegate,
          itemBuilder: _itemBuilder,
          controller: scrollController,
          padding: padding,
        );
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index >= items.length) {
      request.call();
      if (loadingBuilder != null) {
        return loadingBuilder!.call(context);
      }
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: CircularProgressIndicator(),
        ),
      );
    }
    return itemBuilder.call(context, items[index]);
  }
}
