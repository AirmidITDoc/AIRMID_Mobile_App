import 'package:airmid/src/widget/shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class ShimmerContainer extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;
  final BoxShape shape;
  final Color? baseColor;
  final Color? highlightColor;

  const ShimmerContainer({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
    this.shape = BoxShape.rectangle,
    this.baseColor,
    this.highlightColor,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: baseColor ?? Colors.grey,
      highlightColor: highlightColor ?? Colors.white,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white12,
          shape: shape,
          borderRadius: borderRadius,
        ),
      ),
    );
  }
}
