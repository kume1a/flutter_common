import 'package:diffutil_dart/diffutil.dart';
import 'package:flutter/widgets.dart';

const Duration _kDuration = Duration(milliseconds: 300);

class ImplicitAnimatedList<T> extends StatefulWidget {
  const ImplicitAnimatedList({
    Key? key,
    required this.items,
    required this.itemBuilder,
    required this.keyingFunction,
    this.scrollDirection = Axis.vertical,
    this.reverse = false,
    this.controller,
    this.primary,
    this.physics,
    this.shrinkWrap = false,
    this.padding,
    this.insertDuration = _kDuration,
    this.removeDuration = _kDuration,
  }) : super(key: key);

  final List<T> items;
  final Widget Function(BuildContext, T, Animation<double>) itemBuilder;
  final Key Function(T item) keyingFunction;
  final Axis scrollDirection;
  final bool reverse;
  final ScrollController? controller;
  final bool? primary;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final EdgeInsetsGeometry? padding;
  final Duration insertDuration;
  final Duration removeDuration;

  @override
  _ImplicitAnimatedListState<T> createState() => _ImplicitAnimatedListState<T>();
}

class _ImplicitAnimatedListState<T> extends State<ImplicitAnimatedList<T>> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  @override
  void didUpdateWidget(ImplicitAnimatedList<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final List<Key> oldKeys = oldWidget.items.map((T e) => oldWidget.keyingFunction(e)).toList();
    final List<Key> newKeys = widget.items.map((T e) => widget.keyingFunction(e)).toList();

    for (final DataDiffUpdate<Key> update in calculateListDiff<Key>(
      oldKeys,
      newKeys,
      detectMoves: false,
    ).getUpdatesWithData()) {
      if (update is DataInsert<Key>) {
        _listKey.currentState!.insertItem(
          update.position,
          duration: widget.insertDuration,
        );
      } else if (update is DataRemove<Key>) {
        _listKey.currentState!.removeItem(
          update.position,
          (BuildContext context, Animation<double> animation) =>
              oldWidget.itemBuilder(context, oldWidget.items[update.position], animation),
          duration: widget.removeDuration,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedList(
      key: _listKey,
      scrollDirection: widget.scrollDirection,
      reverse: widget.reverse,
      controller: widget.controller,
      primary: widget.primary,
      physics: widget.physics,
      shrinkWrap: widget.shrinkWrap,
      padding: widget.padding,
      initialItemCount: widget.items.length,
      itemBuilder: (BuildContext context, int index, Animation<double> animation) =>
          widget.itemBuilder(context, widget.items[index], animation),
    );
  }
}
