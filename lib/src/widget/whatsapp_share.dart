import 'dart:io';

import 'package:airmid/src/widget/top_snackbar/top_snackbar_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher_string.dart';

class WhatsappShare {
  static void whatsAppOpen(
      {String? phoneNo,
      required BuildContext context,
      String message = "AIRMID"}) async {
    try {
      String url() {
        if (phoneNo?.isNotEmpty ?? false) {
          if (Platform.isIOS) {
            return "whatsapp://wa.me/$phoneNo/?text=$message";
          } else {
            return "whatsapp://send?phone=$phoneNo&text=$message";
          }
        } else {
          return "https://wa.me/?text=$message";
        }
      }

      if (true) {
        await launchUrlString(url());
      }
    } on PlatformException catch (e) {
      if (e.code == 'ERR_NOT_INSTALLED') {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.info(
            message: "WhatsApp is not installed in this device",
          ),
        );
      } else if (e.code == "ACTIVITY_NOT_FOUND") {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "Activity not found.",
          ),
        );
      } else {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.error(
            message: "Something went wrong",
          ),
        );
      }
    }
  }
}
