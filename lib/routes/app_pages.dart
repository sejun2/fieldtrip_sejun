import 'package:get/get.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/act1_1_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/hint_page/hint5_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-2/act1_2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-3/act1_3_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-4/act1_4_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-4/hint_page/hint2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-4/question2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-5/act1_5_page.dart';
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
    GetPage(name: AppRoutes.Act1_3, page: () => const Act1_3Page()),
    GetPage(name: AppRoutes.Q2, page: () => const Question2Page()),
    GetPage(name: AppRoutes.ACT1_4, page: () => const Act1_4Page()),
    GetPage(name: AppRoutes.ACT1_5, page: () => const Act1_5Page()),
    GetPage(name: AppRoutes.Q2_HINT, page: () => const Hint2Page()),
  ];
}
