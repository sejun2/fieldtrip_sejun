import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/widgets/custom_progress_indicator.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import 'pages/splash_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: const SplashPage(),
    );
  }
}

