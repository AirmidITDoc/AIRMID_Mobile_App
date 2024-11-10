import 'package:airmid/src/widget/whatsapp_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AnimatedButton extends StatefulWidget {
  final bool isCard;

  const AnimatedButton({super.key, required this.isCard});
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  final ValueNotifier<bool> _isTapped = ValueNotifier(false);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isTapped,
      builder: (BuildContext context, bool value, Widget? child) =>
          GestureDetector(
        onTapDown: (_) {
          _isTapped.value = true;
        },
        onTapUp: (_) {
          _isTapped.value = false;
          WhatsappShare.whatsAppOpen(
            context: context,
            message: "Testing..",
          );
        },
        onTapCancel: () {
          _isTapped.value = false;
        },
        child: AnimatedScale(
          scale: _isTapped.value ? 0.95 : 1.0,
          duration: Duration(milliseconds: 100),
          child: InkWell(
            splashColor: Colors.transparent,
            focusColor: Colors.transparent,
            highlightColor: Colors.transparent,
            child: widget.isCard
                ? Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18).r,
                    ),
                    elevation: 3,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Icon(
                        Icons.share,
                        color: Colors.blue,
                      ),
                    ),
                  )
                : Icon(
                    Icons.share,
                    color: Colors.blue,
                  ),
          ),
        ),
      ),
    );
  }
}
