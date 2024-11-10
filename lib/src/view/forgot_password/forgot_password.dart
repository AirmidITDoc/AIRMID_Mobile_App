import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/widget/button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final TextEditingController _forgotPasswordController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15).r,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _newPasswordController,
                decoration: const InputDecoration(
                  hintText: "Email",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return ConstString.emailError;
                  }
                  return null;
                },
              ),
              FxBox.h28,
              TextFormField(
                controller: _confirmPasswordController,
                decoration: const InputDecoration(
                  hintText: "Enter New Password",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return ConstString.emailError;
                  }
                  return null;
                },
              ),
              FxBox.h28,
              TextFormField(
                controller: _forgotPasswordController,
                decoration: const InputDecoration(
                  hintText: "Confirm Password",
                ),
                validator: (value) {
                  if (value?.isEmpty ?? false) {
                    return ConstString.emailError;
                  }
                  return null;
                },
              ),
              FxBox.h28,
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.0.w),
                child: Pinput(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  controller: _otpController,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  closeKeyboardWhenCompleted: true,
                  length: 4,
                  keyboardType: TextInputType.number,
                  errorPinTheme: PinTheme(
                    height: 60.0.h,
                    width: 60.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      // color: ConstColor.darkFillColor,
                      border: Border.all(
                        color: ConstColor.red,
                      ),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ConstString.enterOtp;
                    }
                    return null;
                  },
                  defaultPinTheme: PinTheme(
                    height: 60.0.h,
                    width: 60.0.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: ConstColor.white,
                      border: Border.all(
                          // color: ConstColor.darkBorderColor,
                          ),
                    ),
                  ),
                ),
              ),
              FxBox.h36,
              const FxButton(buttonName: "Verify"),
            ],
          ),
        ),
      ),
    );
  }
}
