import 'package:get/get.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/intro_page/intro_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/question1_page.dart';
import 'package:history_game_project/pages/content_select_page/content_select_page.dart';
import 'package:history_game_project/pages/splash_page.dart';
import 'package:history_game_project/routes/app_routes.dart';

abstract class AppPages{
  static final pages = [
    GetPage(name: AppRoutes.SPLASH, page: () => const SplashPage()),
    GetPage(name: AppRoutes.SELECTION, page: () => const ContentSelectPage()),
    GetPage(name: AppRoutes.ACT1_INTRO, page: () => const IntroPage()),
    GetPage(name: AppRoutes.ACT1, page: () => const Act1Page()),
    GetPage(name: AppRoutes.Q1, page: () => const Question1Page()),
  ];
}