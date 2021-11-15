import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';
import 'core/default_paging_empty_list_indicator.dart';
import 'core/default_paging_loading_indicator.dart';
import 'core/list_config.dart';

class PagedGrid<T> extends StatelessWidget {
  const PagedGrid({
    Key? key,
    this.listViewConfig,
    required this.gridDelegate,
    required this.data,
    required this.totalCount,
    required this.onScrolledToEnd,
    required this.itemBuilder,
    this.loadingBuilder,
    this.emptyListBuilder,
  })  : listType = ListType.builder,
        sliverListConfig = null,
        super(key: key);

  const PagedGrid.sliver({
    Key? key,
    this.sliverListConfig,
    required this.gridDelegate,
    required this.data,
    required this.totalCount,
    required this.onScrolledToEnd,
    required this.itemBuilder,
    this.loadingBuilder,
    this.emptyListBuilder,
  })  : listType = ListType.sliverBuilder,
        listViewConfig = null,
        super(key: key);

  final ListBuilderConfig? listViewConfig;
  final SliverBuilderConfig? sliverListConfig;

  final SliverGridDelegate gridDelegate;
  final ListType listType;

  final List<T> data;
  final int totalCount;
  final VoidCallback onScrolledToEnd;
  final ItemBuilder<T> itemBuilder;

  final WidgetBuilder? loadingBuilder;
  final WidgetBuilder? emptyListBuilder;

  @override
  Widget build(BuildContext context) {
    if (totalCount == 0) {
      switch (listType) {
        case ListType.sliverBuilder:
          return SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                if (emptyListBuilder != null)
                  emptyListBuilder!.call(context)
                else
                  const DefaultPagingEmptyListIndicator(),
              ],
            ),
          );
        case ListType.builder:
          return SingleChildScrollView(
            child: emptyListBuilder != null ? emptyListBuilder!.call(context) : const DefaultPagingEmptyListIndicator(),
          );
      }
    }
    final int l = data.length;
    final int itemCount = totalCount <= l ? l : l + 1;

    switch (listType) {
      case ListType.sliverBuilder:
        return SliverGrid(
          gridDelegate: gridDelegate,
          delegate: sliverListConfig != null
              ? SliverChildBuilderDelegate(
                  _itemBuilder,
                  childCount: itemCount,
                  findChildIndexCallback: sliverListConfig!.findChildIndexCallback,
                  addAutomaticKeepAlives: sliverListConfig!.addAutomaticKeepAlives,
                  addRepaintBoundaries: sliverListConfig!.addRepaintBoundaries,
                  addSemanticIndexes: sliverListConfig!.addSemanticIndexes,
                  semanticIndexCallback: sliverListConfig!.semanticIndexCallback,
                  semanticIndexOffset: sliverListConfig!.semanticIndexOffset,
                )
              : SliverChildBuilderDelegate(
                  _itemBuilder,
                  childCount: itemCount,
                ),
        );
      case ListType.builder:
        return listViewConfig != null
            ? GridView.builder(
                gridDelegate: gridDelegate,
                itemCount: itemCount,
                itemBuilder: _itemBuilder,
                scrollDirection: listViewConfig!.scrollDirection,
                reverse: listViewConfig!.reverse,
                controller: listViewConfig!.controller,
                primary: listViewConfig!.primary,
                physics: listViewConfig!.physics,
                shrinkWrap: listViewConfig!.shrinkWrap,
                padding: listViewConfig!.padding,
                addAutomaticKeepAlives: listViewConfig!.addAutomaticKeepAlives,
                addRepaintBoundaries: listViewConfig!.addRepaintBoundaries,
                addSemanticIndexes: listViewConfig!.addSemanticIndexes,
                cacheExtent: listViewConfig!.cacheExtent,
                semanticChildCount: listViewConfig!.semanticChildCount,
                dragStartBehavior: listViewConfig!.dragStartBehavior,
                keyboardDismissBehavior: listViewConfig!.keyboardDismissBehavior,
                restorationId: listViewConfig!.restorationId,
                clipBehavior: listViewConfig!.clipBehavior,
              )
            : GridView.builder(
                gridDelegate: gridDelegate,
                itemBuilder: _itemBuilder,
                itemCount: itemCount,
              );
    }
  }

  Widget _itemBuilder(BuildContext context, int index) {
    if (index >= data.length) {
      onScrolledToEnd.call();

      return loadingBuilder != null ? loadingBuilder!.call(context) : const DefaultPagingLoadingIndicator();
    }
    return itemBuilder.call(context, data[index]);
  }
}
