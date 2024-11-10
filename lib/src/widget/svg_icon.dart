// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FxSvgAssets extends StatelessWidget {
  final String icon;
  final Color? color;
  final double? height;
  final double? width;
  final BoxFit? fit;

  const FxSvgAssets(
      {super.key,
      required this.icon,
      this.color,
      this.height,
      this.fit,
      this.width});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      fit: fit ?? BoxFit.contain,
      icon,
      color: color,
      width: width,
      height: height,
    );
  }
}
