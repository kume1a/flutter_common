import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';

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
    this.onEmptyListBuilder,
    this.reverse = false,
  }) : listType = ListType.builder;

  const PagedList.sliver({
    required this.totalCount,
    required this.items,
    required this.request,
    required this.itemBuilder,
    this.loadingBuilder,
    this.onEmptyListBuilder,
  })  : listType = ListType.sliverBuilder,
        padding = null,
        axis = Axis.vertical,
        scrollController = null,
        reverse = false;

  final Axis axis;
  final ListType listType;
  final ScrollController? scrollController;
  final EdgeInsets? padding;
  final VoidCallback request;
  final ItemBuilder<T> itemBuilder;
  final WidgetBuilder? loadingBuilder;
  final List<T> items;
  final int totalCount;
  final WidgetBuilder? onEmptyListBuilder;
  final bool reverse;

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) {
      switch (listType) {
        case ListType.sliverBuilder:
          return onEmptyListBuilder != null
              ? SliverList(
                  delegate: SliverChildListDelegate(
                    <Widget>[onEmptyListBuilder!.call(context)],
                  ),
                )
              : const SliverToBoxAdapter();
        case ListType.builder:
          return onEmptyListBuilder != null
              ? SingleChildScrollView(
                  child: onEmptyListBuilder!.call(context),
                )
              : const SizedBox.shrink();
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
          reverse: reverse,
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
      return loadingBuilder != null
          ? loadingBuilder!.call(context)
          : const Center(
              child: Padding(
                padding: EdgeInsets.all(16),
                child: CircularProgressIndicator(),
              ),
            );
    }
    return itemBuilder.call(context, items[index]);
  }
}
