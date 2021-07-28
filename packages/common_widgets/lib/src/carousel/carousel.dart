import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'page_indicator.dart';

class Carousel extends HookWidget {
  const Carousel({
    Key? key,
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.horizontal,
    this.onPageChanged,
    this.viewPortFraction = .84,
    this.distortionValue = .3,
  }) : super(key: key);

  final double height;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final ValueChanged<int>? onPageChanged;
  final double viewPortFraction;
  final double distortionValue;

  Widget getEnlargeWrapper(Widget? child, {double? width, double? height, required double scale}) {
    return Transform.scale(
      scale: scale,
      child: SizedBox(
        width: width,
        height: height,
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PageController pageController = usePageController(viewportFraction: viewPortFraction);

    return Column(
      children: <Widget>[
        SizedBox(
          height: height,
          child: PageView.builder(
            scrollDirection: scrollDirection,
            itemCount: itemCount,
            onPageChanged: (int index) => onPageChanged?.call(index),
            controller: pageController,
            itemBuilder: (BuildContext context, int index) {
              return AnimatedBuilder(
                animation: pageController,
                builder: (BuildContext context, Widget? child) {
                  double itemOffset;
                  try {
                    itemOffset = pageController.page! - index;
                  } catch (e) {
                    final BuildContext storageContext = pageController.position.context.storageContext;
                    final double? previousSavedPosition =
                        PageStorage.of(storageContext)?.readState(storageContext) as double?;
                    if (previousSavedPosition != null) {
                      itemOffset = previousSavedPosition - index.toDouble();
                    } else {
                      itemOffset = index.toDouble();
                    }
                  }
                  final double distortionRatio = (1 - (itemOffset.abs() * this.distortionValue)).clamp(0.0, 1.0);
                  final double distortionValue = Curves.easeOut.transform(distortionRatio);

                  if (scrollDirection == Axis.horizontal) {
                    return Center(
                      child: getEnlargeWrapper(
                        child,
                        height: distortionValue * height,
                        scale: distortionValue,
                      ),
                    );
                  } else {
                    return Center(
                      child: getEnlargeWrapper(
                        child,
                        width: distortionValue * MediaQuery.of(context).size.width,
                        scale: distortionValue,
                      ),
                    );
                  }
                },
                child: itemBuilder(context, index),
              );
            },
          ),
        ),
        if (itemCount > 1) const SizedBox(height: 18),
        if (itemCount > 1)
          PageIndicator(
            controller: pageController,
            count: itemCount,
            effect: const ScrollingDotsEffect(
              maxVisibleDots: 7,
              radius: 4,
              activeDotScale: 1.2,
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Color(0xFFC0C0C1),
            ),
          ),
      ],
    );
  }
}
