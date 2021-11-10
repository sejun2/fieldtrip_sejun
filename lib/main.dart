import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-18/question5_page.dart';

import 'pages/content_select_page/act1/act1-17/act1_17_page.dart';
import 'routes/app_pages.dart';
import 'services/progress_service.dart';

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
            const Question5Page() //const SplwashPage(), //for test... default home is SplashPage()...
        );
  }
}
