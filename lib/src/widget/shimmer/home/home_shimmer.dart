import 'package:airmid/src/widget/shimmer/shimmer_container.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            ShimmerContainer(
              height: 80.h,
              width: 180.w,
            ),
            FxBox.w20,
            ShimmerContainer(
              height: 80.h,
              width: 180.w,
            ),
          ],
        ),
        FxBox.h20,
        Row(
          children: [
            ShimmerContainer(
              height: 80.h,
              width: 180.w,
            ),
            FxBox.w20,
            ShimmerContainer(
              height: 80.h,
              width: 180.w,
            ),
          ],
        ),
      ],
    );
  }
}
