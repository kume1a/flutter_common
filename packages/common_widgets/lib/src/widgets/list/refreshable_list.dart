import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';
import 'core/default_paging_empty_list_indicator.dart';
import 'core/default_paging_refresh_indicator.dart';
import 'core/list_config.dart';

class RefreshableList<T> extends StatelessWidget {
  const RefreshableList({
    Key? key,
    this.listViewConfig,
    required this.data,
    required this.itemBuilder,
    this.onRefreshPressed,
    this.refreshBuilder,
    this.emptyListErrorBuilder,
  })  : listType = ListType.builder,
        sliverListConfig = null,
        assert((refreshBuilder == null && onRefreshPressed != null) ||
            (refreshBuilder != null && onRefreshPressed == null)),
        super(key: key);

  const RefreshableList.sliver({
    Key? key,
    this.sliverListConfig,
    required this.data,
    required this.itemBuilder,
    this.onRefreshPressed,
    this.refreshBuilder,
    this.emptyListErrorBuilder,
  })  : listType = ListType.sliverBuilder,
        listViewConfig = null,
        assert((refreshBuilder == null && onRefreshPressed != null) ||
            (refreshBuilder != null && onRefreshPressed == null)),
        super(key: key);

  final ListBuilderConfig? listViewConfig;
  final SliverBuilderConfig? sliverListConfig;

  final ListType listType;

  final List<T>? data;
  final ItemBuilder<T> itemBuilder;

  final VoidCallback? onRefreshPressed;

  final WidgetBuilder? refreshBuilder;
  final WidgetBuilder? emptyListErrorBuilder;

  @override
  Widget build(BuildContext context) {
    if (data == null || data!.isEmpty) {
      switch (listType) {
        case ListType.sliverBuilder:
          return SliverList(
            delegate: SliverChildListDelegate(
              <Widget>[
                if (emptyListErrorBuilder != null)
                  emptyListErrorBuilder!.call(context)
                else
                  const DefaultPagingEmptyListIndicator(),
              ],
            ),
          );
        case ListType.builder:
          return SingleChildScrollView(
            child: emptyListErrorBuilder != null
                ? emptyListErrorBuilder!.call(context)
                : const DefaultPagingEmptyListIndicator(),
          );
      }
    }

    final int itemCount = (data?.length ?? 0) + 1;

    switch (listType) {
      case ListType.sliverBuilder:
        return SliverList(
          delegate: sliverListConfig != null
              ? SliverChildBuilderDelegate(
                  (BuildContext context, int index) => _itemBuilder(context, index),
                  childCount: itemCount,
                  findChildIndexCallback: sliverListConfig!.findChildIndexCallback,
                  addAutomaticKeepAlives: sliverListConfig!.addAutomaticKeepAlives,
                  addRepaintBoundaries: sliverListConfig!.addRepaintBoundaries,
                  addSemanticIndexes: sliverListConfig!.addSemanticIndexes,
                  semanticIndexCallback: sliverListConfig!.semanticIndexCallback,
                  semanticIndexOffset: sliverListConfig!.semanticIndexOffset,
                )
              : SliverChildBuilderDelegate(
                  (BuildContext context, int index) => _itemBuilder(context, index),
                  childCount: itemCount,
                ),
        );
      case ListType.builder:
        return listViewConfig != null
            ? ListView.builder(
                itemBuilder: _itemBuilder,
                itemCount: itemCount,
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
            : ListView.builder(
                itemBuilder: _itemBuilder,
                itemCount: itemCount,
              );
    }
  }

  Widget _itemBuilder(
    BuildContext context,
    int index,
  ) {
    if (index == (data?.length ?? 0)) {
      return refreshBuilder != null
          ? refreshBuilder!.call(context)
          : DefaultPagingRefreshIndicator(onRefreshPressed: onRefreshPressed!);
    }

    return itemBuilder.call(context, data![index]);
  }
}
