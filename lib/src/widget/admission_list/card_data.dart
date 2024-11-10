import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdmissionCardData extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget space;
  const AdmissionCardData(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.space});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 14.sp,
          ),
        ),
        space,
        Text(
          subTitle,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 15.sp,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class AdmissionListButton extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const AdmissionListButton({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const Spacer(),
          Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20.sp,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}
