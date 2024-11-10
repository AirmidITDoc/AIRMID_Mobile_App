import 'dart:io';

import 'package:airmid/src/constant/color.dart';
import 'package:airmid/src/constant/image.dart';
import 'package:airmid/src/constant/loader.dart';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/provider/bolc/signin_bloc/sign_in_bloc.dart';
import 'package:airmid/src/utils/bottom/components/bottom_bar.dart';
import 'package:airmid/src/utils/responsive.dart';
import 'package:airmid/src/view/forgot_password/forgot_password.dart';
import 'package:airmid/src/widget/button.dart';
import 'package:airmid/src/widget/sizedbox.dart';
import 'package:airmid/src/widget/svg_icon.dart';
import 'package:airmid/src/widget/text_file.dart';
import 'package:airmid/src/widget/top_snackbar/custom_snack_bar.dart';
import 'package:airmid/src/widget/top_snackbar/top_snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ValueNotifier<bool> _showPassword = ValueNotifier<bool>(false);
  final SignInBloc _signInBloc = SignInBloc();
  @override
  void initState() {
    if (kDebugMode) {
      _userNameController.text = "Admin";
      _passwordController.text = "666666";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _signInBloc,
      child: Scaffold(
        bottomNavigationBar: Padding(
          padding: EdgeInsets.only(
                  bottom: Platform.isIOS
                      ? Responsive.isTablet(context)
                          ? 20.0
                          : 0
                      : 0)
              .r,
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Powered by : ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: Responsive.isTablet(context) ? 11.sp : null),
                ),
                Text(
                  "Airmid Healthcare Solution @2024",
                  style: TextStyle(
                      fontSize: Responsive.isTablet(context) ? 11.sp : null),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(
                  horizontal: Responsive.isTablet(context) ? 100 : 15)
              .r,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    Images.appLogo,
                    height: Responsive.isTablet(context) ? 138.h : 145.h,
                    width: Responsive.isTablet(context) ? 138.h : 145.w,
                  ),
                ),
                FxBox.h60,
                Text(
                  ConstString.signInText,
                  style: TextStyle(
                    fontSize: Responsive.isTablet(context) ? 12.sp : 25.0.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  ConstString.signInSubText,
                  style: TextStyle(
                    fontSize: Responsive.isTablet(context) ? 10.sp : 16.0.sp,
                    color: ConstColor.grey,
                  ),
                ),
                FxBox.h20,
                FxTextFormField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.text,
                  label: Text(
                    ConstString.userName,
                  ),
                  controller: _userNameController,
                  validator: (value) {
                    if (value?.isEmpty ?? false) {
                      return ConstString.userName;
                    }
                    return null;
                  },
                ),
                FxBox.h20,
                ValueListenableBuilder(
                  valueListenable: _showPassword,
                  builder: (BuildContext context, bool showPassword,
                          Widget? child) =>
                      FxTextFormField(
                    suffixIcon: GestureDetector(
                      onTap: () {
                        _showPassword.value = !_showPassword.value;
                      },
                      child: showPassword
                          ? Icon(
                              CupertinoIcons.eye,
                              color: ConstColor.black,
                              size: 22.0.sp,
                            )
                          : const FxSvgAssets(
                              color: Colors.black,
                              icon: Images.closeEye,
                              fit: BoxFit.scaleDown,
                            ),
                    ),
                    label: const Text(
                      ConstString.password,
                    ),
                    maxLines: 1,
                    counterText: "",
                    textInputAction: TextInputAction.done,
                    obscureText: !showPassword,
                    controller: _passwordController,
                    validator: (value) {
                      if (value?.isEmpty ?? false) {
                        return ConstString.passwordError;
                      }
                      return null;
                    },
                  ),
                ),
                FxBox.h10,
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ForgotPassword(),
                          ));
                    },
                    child: Text(
                      ConstString.forgotPassword,
                      style: TextStyle(
                        fontSize:
                            Responsive.isTablet(context) ? 10.sp : 16.0.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                FxBox.h40,
                BlocListener<SignInBloc, SignInState>(
                  bloc: _signInBloc,
                  listener: (context, state) {
                    state.when(
                      initial: () => const SizedBox.shrink(),
                      loading: () => const CircularProgressIndicator.adaptive(),
                      success: () {
                        Loader.hide();
                        showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Loagin SucessFully",
                          ),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LandingPage(),
                            ));
                      },
                      error: (message) {
                        Loader.hide();
                        showTopSnackBar(
                          Overlay.of(context),
                          CustomSnackBar.error(
                            message: message.toString(),
                          ),
                        );
                      },
                    );
                  },
                  child: FxButton(
                    onTap: () {
                      if (_formKey.currentState?.validate() ?? false) {
                        Loader.show(context);
                        Map<String, dynamic> loginData = {
                          "userName":
                              _userNameController.text.trim().toString(),
                          "password":
                              _passwordController.text.trim().toString(),
                        };
                        _signInBloc.add(SignInEvent.signIn(loginData));
                      }
                    },
                    buttonName: ConstString.signInText,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
