import 'package:airmid/src/app.dart';
import 'package:airmid/src/utils/hive/hive.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveUtils.init().then(
    (value) async {
      runApp(const MyApp());
    },
  );
}
