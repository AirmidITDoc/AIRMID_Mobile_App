import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CountData extends StatelessWidget {
  final String title;
  final String count;
  final String image;
  const CountData(
      {super.key,
      required this.count,
      required this.image,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 6,
      child: Container(
        padding: const EdgeInsets.all(20),
        width: MediaQuery.sizeOf(context).width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: IntrinsicHeight(
          child: Row(
            children: [
              Image(
                height: 55.h,
                image: AssetImage(
                  image,
                ),
              ),
              const VerticalDivider(
                endIndent: 3,
                indent: 3,
                color: Colors.black,
                thickness: 0.5,
              ),
              FxBox.w10,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    count,
                    style: TextStyle(
                      fontSize: 24.sp,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
