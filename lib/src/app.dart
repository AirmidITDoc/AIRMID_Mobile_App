import 'dart:developer';
import 'package:airmid/src/constant/string.dart';
import 'package:airmid/src/provider/connection_cubit.dart';
import 'package:airmid/src/utils/bottom/components/bottom_bar.dart';
import 'package:airmid/src/utils/hive/hive_keys.dart';
import 'package:airmid/src/utils/hive/hive_utils.dart';
import 'package:airmid/src/view/auth/signin.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    if (HiveUtils.isContainKey(HiveKeys.token)) {
      log("My App Token ${HiveUtils.get(HiveKeys.token)}");
    }
    return ScreenUtilInit(
      designSize: const Size(428, 926),
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => ConnectivityCubit()),
          // BlocProvider(create: (context) => ThemeCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: ConstString.appNameText,
          theme: ThemeData.light(),
          home: BlocListener<ConnectivityCubit, ConnectivityResult>(
            listener: (context, state) {
              (context).read<ConnectivityCubit>().stream.listen(
                (event) {
                  (context)
                      .read<ConnectivityCubit>()
                      .chcekConnectivity(event, context);
                },
              );
            },
            child: _screenhandle(),
          ),
        ),
      ),
    );
  }

  Widget _screenhandle() {
    if (!HiveUtils.isContainKey(HiveKeys.token)) {
      return const SignIn();
    } else {
      return const LandingPage();
    }
  }
}
