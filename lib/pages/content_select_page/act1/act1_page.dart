import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';
import 'package:history_game_project/controllers/act1_controller.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1Page extends StatefulWidget {
  const Act1Page({Key? key}) : super(key: key);

  @override
  _Act1PageState createState() => _Act1PageState();
}

class _Act1PageState extends State<Act1Page> with TickerProviderStateMixin {
  int _currentIndex = 0;
  var _isIntroVisible = true;

  final act1Controller = Get.put(Act1Controller());

  ///Animation controllers
  late AnimationController introController;
  late Animation introAnimation;

  late AnimationController backgroundController;
  late Animation backgroundAnimation;

  late AnimationController animationController;
  late Animation animation;

  ///대본

  @override
  void initState() {
    super.initState();

    _initAnimation();
  }

  _initAnimation() async {
    introController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    introAnimation =
        CurvedAnimation(parent: introController, curve: Curves.linear);
    backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    backgroundAnimation =
        CurvedAnimation(parent: backgroundController, curve: Curves.linear);
    backgroundAnimation.addListener(() {});

    introAnimation.addListener(() {
      setState(() {});
    });
    introAnimation.addStatusListener((status) async {
      Get.log('introAnimation status : $status');
      if (status == AnimationStatus.completed) {
        await introController.reverse(from: 1.0);
      }
      if (status == AnimationStatus.dismissed) {
        await backgroundController.forward(from: 0);
        setState(() {
          Get.log('setState...');
          _isIntroVisible = false;
          act1Controller.progress.value = 1;
        });
      }
    });
    backgroundAnimation.addStatusListener((status) {
      Get.log('backgroundAnimation status : $status');
      if (status == AnimationStatus.completed) {}
      if (status == AnimationStatus.dismissed) {}
    });
    await introController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        color: Colors.black,
        child: Stack(
          children: [
            Opacity(
                opacity: backgroundAnimation.value as double,
                child: Image.asset('assets/background/hearing2.png',
                    fit: BoxFit.fill)),
            Positioned(
              bottom: 50,
              child: Opacity(
                opacity: 0.5,
                child: Container(
                  width: Get.width,
                  height: Get.height * 2 / 5,
                  padding: const EdgeInsets.all(8),
                  color: Colors.amber,
                ),
              ),
            ),

            ///오른쪽 인물 Widget
            Positioned(
              child: Image.asset(
                'assets/character/american1.png',
                fit: BoxFit.fitHeight,
                height: (Get.height - Get.height * 2 / 5) * 2 / 5,
              ),
              top: 70,
              left: 60,
            ),

            ///왼쪽 인물 Widget
            Positioned(
                top: 70,
                right: 60,
                child: Image.asset(
                  'assets/character/american2.png',
                  fit: BoxFit.fitHeight,
                  height: (Get.height - Get.height * 2 / 5) * 2 / 5,
                )),
            Obx(() => ProsteIndexedStack(
                  index: act1Controller.progress.value,
                  children: [
                    IndexedStackChild(child: Container()),
                    IndexedStackChild(child: _buildStatementWidget()),
                    IndexedStackChild(child: _buildStatementWidget()),
                    IndexedStackChild(child: _buildStatementWidget()),
                    IndexedStackChild(child: _buildStatementWidget()),
                  ],
                )),
            Visibility(
              visible: _isIntroVisible,
              child: Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: introAnimation.value as double,
                  child: const Text(
                    'CHAPTER. 1\n폭로',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 35),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatementWidget() {
    Get.log(
        '_buildStatementWidget ... progress : ${act1Controller.progress.value}');

    switch (act1Controller.progress.value) {
      case 1:
        return Positioned(
          bottom: 50,
          child: Container(
            width: Get.width,
            height: Get.height * 2 / 5,
            padding: const EdgeInsets.all(8),
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AnimatedTextKit(
                  displayFullTextOnTap: true,
                  isRepeatingAnimation: false,
                  onFinished: () {
                    act1Controller.progress++;
                  },
                  animatedTexts: [
                    TyperAnimatedText(
                        '나레이션\n전 중앙정보부의 부장 김형욱은 미국 프레이저 청문회에 참석해 대통령의 통치와 부정부패 및 비리 등을 폭로한다.',
                        speed: const Duration(milliseconds: 90),
                        textStyle: statementTextStyle),
                    TyperAnimatedText(
                        '나레이션\n심지어 김형욱은 프레이저 청문회에서 밝히진 않았지만 FBI와 기자들에게 잔뜩 알린 대통령의 치부들, 특히 스위스 비밀계좌에 관한 내용에 상세히 적힌 회고록을 작성하고 있었고,',
                        speed: const Duration(milliseconds: 90),
                        textStyle: statementTextStyle),
                    TyperAnimatedText(
                        '나레이션\n이것이 세상에 알려지면 가뜩이나 정권 유지가 위기에 놓은 대통령은 궁지에 몰릴 터였다.',
                        speed: const Duration(milliseconds: 90),
                        textStyle: statementTextStyle)
                  ],
                ),
              ],
            ),
          ),
        );
      default:
        return Container(
          color: Colors.blue,
        );
    }
  }

  _buildTyperAnimatedText(String content) {
    return TyperAnimatedText(content, textStyle: statementTextStyle);
  }
}

/**
 * 1. 왼쪽, 오른쪽 인물을 나타내는 위젯 필요. 인물 변경시 자동으로 이미지도 변경
 * 2. 애니메이션에 맞춰 대사 적용 필요
 * 3. 자동 실행 적용 필요
 */
