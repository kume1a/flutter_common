import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';
import '../sliver_sized_box.dart';

class PagedList<T> extends StatelessWidget {
  const PagedList({
    this.axis = Axis.vertical,
    required this.totalCount,
    required this.items,
    required this.request,
    required this.itemBuilder,
    this.loadingBuilder,
    this.scrollController,
    this.padding,
  }) : listType = ListType.builder;

  const PagedList.sliver({
    required this.totalCount,
    required this.items,
    required this.request,
    required this.itemBuilder,
    this.loadingBuilder,
  })  : listType = ListType.sliverBuilder,
        padding = null,
        axis = Axis.vertical,
        scrollController = null;

  final Axis axis;
  final ListType listType;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final VoidCallback request;
  final ItemBuilder<T> itemBuilder;
  final WidgetBuilder? loadingBuilder;
  final List<T> items;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) {
      switch (listType) {
        case ListType.sliverBuilder:
          return const SliverSizedBox.shrink();
        case ListType.builder:
          return const SizedBox.shrink();
      }
    }

    final int l = items.length;
    final int itemCount = totalCount <= l ? l : l + 1;
    switch (listType) {
      case ListType.sliverBuilder:
        return SliverList(
          delegate: SliverChildBuilderDelegate(
            _itemBuilder,
            childCount: itemCount,
          ),
        );
      case ListType.builder:
        return ListView.builder(
          itemCount: itemCount,
          scrollDirection: axis,
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
