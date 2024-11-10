import 'package:airmid/src/widget/shimmer/shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ListShimmer extends StatelessWidget {
  const ListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 12,
      itemBuilder: (context, index) {
        return Padding(
          padding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0).r,
          child: ShimmerContainer(
            borderRadius: BorderRadius.circular(15),
            height: 100.h,
            width: MediaQuery.sizeOf(context).width,
          ),
        );
      },
    );
  }
}
