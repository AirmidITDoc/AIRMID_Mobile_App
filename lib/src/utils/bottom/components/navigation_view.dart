library navigation_view;

import 'package:airmid/src/constant/const.dart';
import 'package:airmid/src/utils/bottom/components/item_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NavigationView extends StatefulWidget {
  final Function(int) onChangePage;
  final Color? backgroundColor;
  final Color? borderTopColor;
  final Curve? curve;
  final Color? color;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final Duration? durationAnimation;
  final List<ItemNavigationView> items;
  const NavigationView({
    super.key,
    required this.onChangePage,
    required this.items,
    this.durationAnimation,
    this.backgroundColor,
    this.borderRadius,
    this.gradient,
    this.color,
    this.curve,
    this.borderTopColor,
  });

  @override
  State<StatefulWidget> createState() => _NavigationView();
}

class _NavigationView extends State<NavigationView> {
  final double borderRadius = 11.1.r;

  Duration durationAnimation = const Duration(milliseconds: 400);
  @override
  void initState() {
    if (widget.durationAnimation != null) {
      durationAnimation = widget.durationAnimation!;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
        color: (widget.backgroundColor != null)
            ? widget.backgroundColor
            : Colors.white,
      ),
      height: 80.h,
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (p0, constraints) {
                return Stack(
                  children: [
                    AnimatedPositioned(
                      curve: (widget.curve != null)
                          ? widget.curve!
                          : Curves.easeInOutQuint,
                      left: (constraints.maxWidth / widget.items.length) *
                          currentTab.value,
                      width: constraints.maxWidth / widget.items.length,
                      height: constraints.maxHeight,
                      duration: Duration(
                          milliseconds: durationAnimation.inMilliseconds),
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 0,
                            bottom: 0,
                            left: (45 / widget.items.length),
                            right: (45 / widget.items.length)),
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: (widget.borderRadius != null)
                                    ? widget.borderRadius
                                    : BorderRadius.circular(borderRadius)),
                            child: Column(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(
                                      milliseconds:
                                          durationAnimation.inMilliseconds ~/
                                              2),
                                  width: 40.w,
                                  height: 4.h,
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: (widget.borderRadius != null)
                                        ? widget.borderRadius!
                                        : const BorderRadius.only(
                                            topLeft: Radius.circular(4),
                                            topRight: Radius.circular(4),
                                            bottomLeft: Radius.circular(4),
                                            bottomRight: Radius.circular(4),
                                          ).r,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: double.maxFinite,
                      height: double.maxFinite,
                      child: Row(
                        textDirection: TextDirection.ltr,
                        children: widget.items
                            .map(
                              (e) => Flexible(
                                flex: 1,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentTab.value =
                                          widget.items.indexOf(e);
                                      widget.onChangePage
                                          .call(widget.items.indexOf(e));
                                    });
                                  },
                                  child: LayoutBuilder(
                                    builder: (BuildContext context,
                                        BoxConstraints constraints) {
                                      return Center(
                                        child: AnimatedCrossFade(
                                          firstChild: e.childBefore!,
                                          secondChild: e.childAfter!,
                                          crossFadeState: (currentTab.value ==
                                                  widget.items.indexOf(e))
                                              ? CrossFadeState.showSecond
                                              : CrossFadeState.showFirst,
                                          firstCurve: Curves.ease,
                                          secondCurve: Curves.ease,
                                          duration: Duration(
                                              milliseconds: durationAnimation
                                                      .inMilliseconds ~/
                                                  2),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
