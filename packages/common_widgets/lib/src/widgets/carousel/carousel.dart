import 'package:flutter/material.dart';

import 'carousel_indicator_options.dart';
import 'page_indicator.dart';

class Carousel extends StatefulWidget {
  const Carousel({
    Key? key,
    required this.height,
    required this.itemCount,
    required this.itemBuilder,
    this.scrollDirection = Axis.horizontal,
    this.onPageChanged,
    this.viewPortFraction = .84,
    this.distortionValue = .3,
    this.indicatorOptions,
  }) : super(key: key);

  final double height;
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final Axis scrollDirection;
  final ValueChanged<int>? onPageChanged;
  final double viewPortFraction;
  final double distortionValue;
  final CarouselIndicatorOptions? indicatorOptions;

  @override
  State<Carousel> createState() => _CarouselState();
}

class _CarouselState extends State<Carousel> {
  late final PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(viewportFraction: widget.viewPortFraction);
  }


  @override
  void dispose() {
    pageController.dispose();

    super.dispose();
  }

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
    return Column(
      children: <Widget>[
        SizedBox(
          height: widget.height,
          child: PageView.builder(
            scrollDirection: widget.scrollDirection,
            itemCount: widget.itemCount,
            onPageChanged: (int index) => widget.onPageChanged?.call(index),
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
                  final double distortionRatio = (1 - (itemOffset.abs() * widget.distortionValue)).clamp(0.0, 1.0);
                  final double distortionValue = Curves.easeOut.transform(distortionRatio);

                  if (widget.scrollDirection == Axis.horizontal) {
                    return Center(
                      child: getEnlargeWrapper(
                        child,
                        height: distortionValue * widget.height,
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
                child: widget.itemBuilder(context, index),
              );
            },
          ),
        ),
        if (widget.indicatorOptions != null && widget.itemCount > 1)
          SizedBox(height: widget.indicatorOptions!.spaceFromPageIndicatorToCarousel),
        if (widget.indicatorOptions != null && widget.itemCount > 1)
          PageIndicator(
            controller: pageController,
            count: widget.itemCount,
            onDotClicked: widget.indicatorOptions!.onDotClicked,
            effect: ScrollingDotsEffect(
              maxVisibleDots: widget.indicatorOptions!.maxVisibleDots,
              radius: widget.indicatorOptions!.radius,
              activeDotScale: widget.indicatorOptions!.activeDotScale,
              dotHeight: widget.indicatorOptions!.dotHeight,
              dotWidth: widget.indicatorOptions!.dotWidth,
              dotColor: widget.indicatorOptions!.dotColor,
              activeDotColor: widget.indicatorOptions!.activeDotColor,
              activeStrokeWidth: widget.indicatorOptions!.activeStrokeWidth,
              paintStyle: widget.indicatorOptions!.paintStyle,
              spacing: widget.indicatorOptions!.spacing,
              strokeWidth: widget.indicatorOptions!.strokeWidth,
            ),
          ),
      ],
    );
  }
}
