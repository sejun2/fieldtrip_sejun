import 'package:get/get.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/act1_1_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-1/hint_page/hint5_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-10/act1_10_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-11/act1_11_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-11/question4_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-2/act1_2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-3/act1_3_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-4/act1_4_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-4/hint_page/hint2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-4/question2_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-5/act1_5_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-6/act1_6_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-7/act1_7_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-7/hint_page/hint3_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-7/question3_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-8/act1_8_page.dart';
import 'package:history_game_project/pages/content_select_page/act1/act1-9/act1_9_page.dart';
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
    GetPage(name: AppRoutes.Q3, page: ()=> const Question3Page()),
    GetPage(name: AppRoutes.ACT1_6, page: () => const Act1_6Page()),
    GetPage(name: AppRoutes.ACT1_HINT5, page: () => const Hint5Page()),
    GetPage(name: AppRoutes.ACT1_2, page: () => const Act1_2Page()),
    GetPage(name: AppRoutes.Act1_3, page: () => const Act1_3Page()),
    GetPage(name: AppRoutes.Q2, page: () => const Question2Page()),
    GetPage(name: AppRoutes.ACT1_4, page: () => const Act1_4Page()),
    GetPage(name: AppRoutes.ACT1_5, page: () => const Act1_5Page()),
    GetPage(name: AppRoutes.Q2_HINT, page: () => const Hint2Page()),
    GetPage(name: AppRoutes.ACT1_8, page: () => const Act1_8Page()),
    GetPage(name: AppRoutes.ACT1_7, page: () => const Act1_7Page()),
    GetPage(name: AppRoutes.Q3_hint, page: () => const Hint3Page()),
    GetPage(name: AppRoutes.ACT1_9, page: () => const Act1_9Page()),
    GetPage(name: AppRoutes.ACT1_10, page: () => const Act1_10Page()),
    GetPage(name: AppRoutes.ACT1_11, page: () => const Act1_11Page()),
    GetPage(name: AppRoutes.Q4, page: () => const Question4Page()),
  ];
}
