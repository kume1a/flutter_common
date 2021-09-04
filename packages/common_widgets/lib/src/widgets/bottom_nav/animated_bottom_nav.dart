import 'package:flutter/material.dart';

import 'animated_bottom_nav_item.dart';

class AnimatedBottomNav extends StatelessWidget {
  const AnimatedBottomNav({
    Key? key,
    required this.items,
    this.currentIndex = 0,
    this.onTap,
    this.selectedItemColor,
    this.unselectedItemColor,
    this.backgroundColor,
    this.borderRadius,
    this.selectedColorOpacity = .1,
    this.itemShape = const StadiumBorder(),
    this.margin = const EdgeInsets.all(8),
    this.itemPadding = const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
    this.duration = const Duration(milliseconds: 500),
    this.curve = Curves.easeOutQuint,
  }) : super(key: key);

  final List<AnimatedBottomNavItem> items;
  final int currentIndex;
  final Function(int)? onTap;
  final Color? selectedItemColor;
  final Color? unselectedItemColor;
  final Color? backgroundColor;
  final double selectedColorOpacity;
  final BorderRadius? borderRadius;
  final ShapeBorder itemShape;
  final EdgeInsets margin;
  final EdgeInsets itemPadding;
  final Duration duration;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return Container(
      padding: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: backgroundColor ?? theme.bottomNavigationBarTheme.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          for (final AnimatedBottomNavItem item in items)
            TweenAnimationBuilder<double>(
              tween: Tween<double>(
                end: items.indexOf(item) == currentIndex ? 1 : 0,
              ),
              curve: curve,
              duration: duration,
              builder: (BuildContext context, double t, _) {
                final Color _selectedColor = item.selectedColor ?? selectedItemColor ?? theme.primaryColor;
                final Color? _unselectedColor = item.unselectedColor ?? unselectedItemColor ?? theme.iconTheme.color;

                return Material(
                  color: Color.lerp(
                    _selectedColor.withOpacity(0),
                    _selectedColor.withOpacity(selectedColorOpacity),
                    t,
                  ),
                  shape: itemShape,
                  child: InkWell(
                    onTap: () => onTap?.call(items.indexOf(item)),
                    customBorder: itemShape,
                    focusColor: _selectedColor.withOpacity(0.1),
                    highlightColor: _selectedColor.withOpacity(0.1),
                    splashColor: _selectedColor.withOpacity(0.1),
                    hoverColor: _selectedColor.withOpacity(0.1),
                    child: Padding(
                      padding: itemPadding - EdgeInsets.only(right: itemPadding.right * t),
                      child: Row(
                        children: <Widget>[
                          IconTheme(
                            data: IconThemeData(
                              color: Color.lerp(_unselectedColor, _selectedColor, t),
                              size: 24,
                            ),
                            child: items.indexOf(item) == currentIndex ? item.activeIcon ?? item.icon : item.icon,
                          ),
                          ClipRect(
                            child: SizedBox(
                              height: 20,
                              child: Align(
                                alignment: const Alignment(-0.2, 0),
                                widthFactor: t,
                                child: Padding(
                                  padding: EdgeInsets.only(left: itemPadding.right / 2, right: itemPadding.right),
                                  child: DefaultTextStyle(
                                    style: TextStyle(
                                      color: Color.lerp(_selectedColor.withOpacity(0), _selectedColor, t),
                                      fontWeight: FontWeight.w500,
                                      fontSize: 13,
                                    ),
                                    child: item.title,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
        ],
      ),
    );
  }
}
