import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/act1_1_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/question1_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-11/act1_11_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-2/act1_2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-3/act1_3_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-4/question2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-5/act1_5_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-6/act1_6_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-8/act1_8_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-9/act1_9_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/intro_page/intro_page.dart';
import 'package:history_game_project/pages/splash_page.dart';

import 'pages/content_select_page/act1/act1-4/act1_4_page.dart';
import 'pages/content_select_page/act1/act1-7/act1_7_page.dart';
import 'services/progress_service.dart';
import 'routes/app_pages.dart';

void main() async {
  await initServices();
  runApp(const MyApp());
}

initServices() async {
  print('starting services ...');

  /// Here is where you put get_storage, hive, shared_pref initialization.
  /// or moor connection, or whatever that's async.
  //await Get.putAsync(SettingsService()).init();
  await Get.putAsync(() => ProgressService().init());
  print('All services started...');
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        getPages: AppPages.pages,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home:
            const Act1_11Page() //const SplashPage(), //for test... default home is SplashPage()...
        );
  }
}
