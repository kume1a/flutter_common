import 'package:flutter/material.dart';

import '../core/enums/list_type.dart';
import '../core/typedefs.dart';
import 'core/default_paging_refresh_indicator.dart';
import 'core/list_config.dart';

class RefreshableGrid<T> extends StatelessWidget {
  const RefreshableGrid({
    Key? key,
    ListBuilderConfig? config,
    required this.gridDelegate,
    required this.data,
    required this.itemBuilder,
    this.onRefreshPressed,
    this.refreshBuilder,
    this.emptyListErrorBuilder,
  })  : listType = ListType.builder,
        listBuilderConfig = config,
        sliverBuilderConfig = null,
        assert(
          (refreshBuilder == null && onRefreshPressed != null) ||
              (refreshBuilder != null && onRefreshPressed == null),
        ),
        super(key: key);

  const RefreshableGrid.sliver({
    Key? key,
    SliverBuilderConfig? config,
    required this.gridDelegate,
    required this.data,
    required this.itemBuilder,
    this.onRefreshPressed,
    this.refreshBuilder,
    this.emptyListErrorBuilder,
  })  : listType = ListType.sliverBuilder,
        sliverBuilderConfig = config,
        listBuilderConfig = null,
        assert(
          (refreshBuilder == null && onRefreshPressed != null) ||
              (refreshBuilder != null && onRefreshPressed == null),
        ),
        super(key: key);

  final ListBuilderConfig? listBuilderConfig;
  final SliverBuilderConfig? sliverBuilderConfig;

  final SliverGridDelegate gridDelegate;
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
                  _buildRefreshIndicator(context),
              ],
            ),
          );
        case ListType.builder:
          return SingleChildScrollView(
            child: emptyListErrorBuilder != null
                ? emptyListErrorBuilder!.call(context)
                : _buildRefreshIndicator(context),
          );
      }
    }

    final int itemCount = (data?.length ?? 0) + 1;

    switch (listType) {
      case ListType.sliverBuilder:
        return SliverGrid(
          gridDelegate: gridDelegate,
          delegate: sliverBuilderConfig != null
              ? SliverChildBuilderDelegate(
                  (BuildContext context, int index) => _itemBuilder(context, index),
                  childCount: itemCount,
                  findChildIndexCallback: sliverBuilderConfig!.findChildIndexCallback,
                  addAutomaticKeepAlives: sliverBuilderConfig!.addAutomaticKeepAlives,
                  addRepaintBoundaries: sliverBuilderConfig!.addRepaintBoundaries,
                  addSemanticIndexes: sliverBuilderConfig!.addSemanticIndexes,
                  semanticIndexCallback: sliverBuilderConfig!.semanticIndexCallback,
                  semanticIndexOffset: sliverBuilderConfig!.semanticIndexOffset,
                )
              : SliverChildBuilderDelegate(
                  (BuildContext context, int index) => _itemBuilder(context, index),
                  childCount: itemCount,
                ),
        );
      case ListType.builder:
        return listBuilderConfig != null
            ? GridView.builder(
                gridDelegate: gridDelegate,
                itemBuilder: _itemBuilder,
                itemCount: itemCount,
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

  Widget _itemBuilder(
    BuildContext context,
    int index,
  ) =>
      index == (data?.length ?? 0)
          ? _buildRefreshIndicator(context)
          : itemBuilder.call(context, data![index]);

  Widget _buildRefreshIndicator(BuildContext context) => refreshBuilder != null
      ? refreshBuilder!.call(context)
      : DefaultPagingRefreshIndicator(onRefreshPressed: onRefreshPressed!);
}
