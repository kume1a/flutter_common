import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';
import 'core/default_paging_empty_list_indicator.dart';
import 'core/default_paging_loading_indicator.dart';
import 'core/list_config.dart';

class PagedGrid<T> extends StatelessWidget {
  const PagedGrid({
    Key? key,
    ListBuilderConfig? config,
    required this.gridDelegate,
    required this.data,
    required this.totalCount,
    required this.onScrolledToEnd,
    required this.itemBuilder,
    this.loadingBuilder,
    this.emptyListBuilder,
  })  : listType = ListType.builder,
        listBuilderConfig = config,
        sliverBuilderConfig = null,
        super(key: key);

  const PagedGrid.sliver({
    Key? key,
    SliverBuilderConfig? config,
    required this.gridDelegate,
    required this.data,
    required this.totalCount,
    required this.onScrolledToEnd,
    required this.itemBuilder,
    this.loadingBuilder,
    this.emptyListBuilder,
  })  : listType = ListType.sliverBuilder,
        sliverBuilderConfig = config,
        listBuilderConfig = null,
        super(key: key);

  final ListBuilderConfig? listBuilderConfig;
  final SliverBuilderConfig? sliverBuilderConfig;

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
          delegate: sliverBuilderConfig != null
              ? SliverChildBuilderDelegate(
                  _itemBuilder,
                  childCount: itemCount,
                  findChildIndexCallback: sliverBuilderConfig!.findChildIndexCallback,
                  addAutomaticKeepAlives: sliverBuilderConfig!.addAutomaticKeepAlives,
                  addRepaintBoundaries: sliverBuilderConfig!.addRepaintBoundaries,
                  addSemanticIndexes: sliverBuilderConfig!.addSemanticIndexes,
                  semanticIndexCallback: sliverBuilderConfig!.semanticIndexCallback,
                  semanticIndexOffset: sliverBuilderConfig!.semanticIndexOffset,
                )
              : SliverChildBuilderDelegate(
                  _itemBuilder,
                  childCount: itemCount,
                ),
        );
      case ListType.builder:
        return listBuilderConfig != null
            ? GridView.builder(
                gridDelegate: gridDelegate,
                itemCount: itemCount,
                itemBuilder: _itemBuilder,
                scrollDirection: listBuilderConfig!.scrollDirection,
                reverse: listBuilderConfig!.reverse,
                controller: listBuilderConfig!.controller,
                primary: listBuilderConfig!.primary,
                physics: listBuilderConfig!.physics,
                shrinkWrap: listBuilderConfig!.shrinkWrap,
                padding: listBuilderConfig!.padding,
                addAutomaticKeepAlives: listBuilderConfig!.addAutomaticKeepAlives,
                addRepaintBoundaries: listBuilderConfig!.addRepaintBoundaries,
                addSemanticIndexes: listBuilderConfig!.addSemanticIndexes,
                cacheExtent: listBuilderConfig!.cacheExtent,
                semanticChildCount: listBuilderConfig!.semanticChildCount,
                dragStartBehavior: listBuilderConfig!.dragStartBehavior,
                keyboardDismissBehavior: listBuilderConfig!.keyboardDismissBehavior,
                restorationId: listBuilderConfig!.restorationId,
                clipBehavior: listBuilderConfig!.clipBehavior,
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
