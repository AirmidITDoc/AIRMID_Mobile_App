import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/image.dart';
import 'package:airmid/src/utils/responsive.dart';
import 'package:airmid/src/view/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileImage extends StatelessWidget {
  final String profileImage;
  const ProfileImage({super.key, required this.profileImage});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 16.0.h),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProfilePage(),
            ),
          );
        },
        child: Container(
          height:Responsive.isTablet(context) ? 40.h: 52.h,
          width: 52.w,
          padding: const EdgeInsets.all(1),
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
          ),
          child: Container(
            height: 42.h,
            width: 42.w,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: ConstColor.bgColorDark),
            child: Image.asset(
              Images.dammyImage,
            ),
          ),
        ),
      ),
    );
  }
}
