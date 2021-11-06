import 'package:get/get.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/act1_1_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/hint_page/hint5_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-2/act1_2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/intro_page/intro_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/question1_page.dart';
import 'package:history_game_project/pages/content_select_page/content_select_page.dart';
import 'package:history_game_project/pages/splash_page.dart';
import 'package:history_game_project/routes/app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashPage()),
    GetPage(name: AppRoutes.SELECTION, page: () => const ContentSelectPage()),
    GetPage(name: AppRoutes.ACT1_INTRO, page: () => const IntroPage()),
    GetPage(name: AppRoutes.ACT1, page: () => const Act1_1Page()),
    GetPage(name: AppRoutes.Q1, page: () => const Question1Page()),
    GetPage(name: AppRoutes.ACT1_HINT5, page: () => const Hint5Page()),
    GetPage(name: AppRoutes.ACT1_2, page: () => const Act1_2Page()),
  ];
}