import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1_page.dart';

import 'routes/app_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.fadeIn,
      getPages: AppPages.pages,
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
      home: const Act1Page()//const SplashPage(), //for test... default home is SplashPage()...
    );
  }
}

