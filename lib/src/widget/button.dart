import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/utils/responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FxButton extends StatefulWidget {
  final String buttonName;
  final void Function()? onTap;
  const FxButton({super.key, required this.buttonName, this.onTap});

  @override
  _FxButtonState createState() => _FxButtonState();
}

class _FxButtonState extends State<FxButton> {
  final ValueNotifier<bool> _isTapped = ValueNotifier<bool>(false);

  void _onTapDown(TapDownDetails details) {
    _isTapped.value = true;
  }

  void _onTapUp(TapUpDetails details) {
    _isTapped.value = false;
  }

  void _onTapCancel() {
    _isTapped.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: ValueListenableBuilder<bool>(
        valueListenable: _isTapped,
        builder: (context, isTapped, child) {
          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            width: MediaQuery.of(context).size.width,
            height: isTapped
                ? MediaQuery.of(context).size.height * 0.05
                : MediaQuery.of(context).size.height * 0.06,
            decoration: BoxDecoration(
              color: Colors.indigo,
              borderRadius: BorderRadius.circular(10),
            ),
            alignment: Alignment.center,
            child: Text(
              widget.buttonName,
              style: TextStyle(
                color: ConstColor.white,
                fontSize: Responsive.isTablet(context) ? 10.sp : 16.sp,
              ),
            ),
          );
        },
      ),
    );
  }
}
