import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectivityCubit extends Cubit<ConnectivityResult> {
  final Connectivity _connectivity = Connectivity();
  OverlayEntry? overlayEntry;
  OverlayState? overlayState;

  ConnectivityCubit() : super(ConnectivityResult.wifi) {
    _connectivity.checkConnectivity().then((value) => emit);
    _connectivity.onConnectivityChanged.listen((event) => emit);
  }

  bool get isConnected =>
      state == ConnectivityResult.wifi ||
      state == ConnectivityResult.ethernet ||
      state == ConnectivityResult.mobile;

  bool showInternetDialog = false;

  void chcekConnectivity(ConnectivityResult result, BuildContext context) {
    if (result != ConnectivityResult.none) {
      {
        if (overlayEntry != null) {
          overlayEntry?.remove();
          overlayEntry = null;
        }
        emit(ConnectivityResult.mobile);
      }
    } else {
      showInternetDialog = true;
      showOverlay(context);
      emit(ConnectivityResult.none);
    }
  }

  showOverlay(BuildContext context) {
    overlayState = Overlay.of(context);
    overlayEntry = OverlayEntry(
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 110.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Material(
                child: Container(
                  padding: const EdgeInsets.all(16.0),
                  // width: 150.w,
                  // height: 60.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.0.r),
                    color: Colors.black,
                  ),
                  child: Text(
                    "No Internet Connection",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
    overlayState?.insert(overlayEntry!);
  }
}
