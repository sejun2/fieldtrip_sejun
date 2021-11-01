import 'package:get/get.dart';
import 'package:history_game_project/pages/splash_page.dart';
import 'package:history_game_project/routes/app_routes.dart';

abstract class AppPages{
  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashPage()),

  ];
}