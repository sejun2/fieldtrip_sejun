import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/question1_page.dart';
import 'package:history_game_project/pages/splash_page.dart';

import 'routes/app_pages.dart';
import 'services/progress_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await initServices();
  await _initApp();
  runApp(const MyApp());
}

_initApp() async {
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
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

  // This widget is the root of your application@override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.fadeIn,
        getPages: AppPages.pages,
        title: 'Flutter Demo',
        theme: ThemeData(),
        home: const SplashPage() //const SplashPage// (), //for test..ㅇ.
        );
  }
}
