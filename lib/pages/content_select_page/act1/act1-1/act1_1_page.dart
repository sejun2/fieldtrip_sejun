import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_1Page extends StatefulWidget {
  const Act1_1Page({Key? key}) : super(key: key);

  @override
  _Act1_1PageState createState() => _Act1_1PageState();
}

class _Act1_1PageState extends State<Act1_1Page> with TickerProviderStateMixin {
  var _isIntroVisible = true;

  final progressService = Get.put<ProgressService>(ProgressService());

  double _opacity = 0.0;
  bool _isIgnore = false;
  bool _canRun = false;

  ///Animation controllers
  late AnimationController introController;
  late Animation introAnimation;

  late AnimationController backgroundController;
  late Animation backgroundAnimation;

  late AnimationController statementContainerController;
  late Animation statementContainerAnimation;

  late AudioPlayer _chapterAudioPlayer;
  late AudioPlayer _contentAudioPlayer;

  final chapterAudioPath = 'BGM/chapter_sound.mp3';
  final contentAudioPath = 'BGM/hearing_sound.wav';
  ///대본

  @override
  void dispose() {
    Get.log('dispose called...');
    introController.dispose();
    backgroundController.dispose();
    statementContainerController.dispose();

    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initAnimation();
    _initResources();
    progressService.lastProgress = 8;
    progressService.isDone.listen((isDone) {
      if (isDone) {
        Future.delayed(const Duration(milliseconds: 2500), () async {
          await progressService.resetProgress();
          Get.log('isDone::true...');
          _canRun = true;
          statementContainerController.reverse(from: 0.7);
          backgroundController.reverse(from: 1.0);
          Timer(const Duration(milliseconds: 500), () {
            Get.offNamed('act1/question1');
          });
        });
      }
    });
  }

  _initResources() async {
    _chapterAudioPlayer = await AudioCache().play(chapterAudioPath);
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
    statementContainerController = AnimationController(
        vsync: this, duration: const Duration(seconds: 3));
    statementContainerAnimation =
        Tween<double>(begin: 0, end: 0.7).animate(statementContainerController);

    backgroundAnimation.addListener(() {});

    introAnimation.addListener(() {
      setState(() {});
    });
    introAnimation.addStatusListener((status) async {
      Get.log('introAnimation status : $status');
      if (status == AnimationStatus.completed) {
        // await introController.reverse(from: 1.0);
      }
      if (status == AnimationStatus.dismissed) {
        backgroundController.forward(from: 0);
        statementContainerController.forward(from: 0);
        setState(() {
          Get.log('setState...');
          _opacity = 0.7;
          _isIntroVisible = false;
          progressService.progress++;
        });
      }
    });
    backgroundAnimation.addStatusListener((status) async {
      Get.log('backgroundAnimation status : $status');
      if (status == AnimationStatus.completed) {
        _contentAudioPlayer = await AudioCache().play(contentAudioPath);
      }
      if (status == AnimationStatus.reverse) {
        await _contentAudioPlayer.stop();
      }
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
            AnimatedOpacity(
                opacity: _opacity,
                duration: const Duration(seconds: 3),
                child: Image.asset('assets/background/hearing2.png',
                    width: Get.width,
                    height: Get.height,
                    fit: BoxFit.fill)),
            Positioned(
              bottom: 50,
              child: AnimatedOpacity(
                duration: const Duration(seconds: 3),
                opacity: _opacity,
                child: Container(
                  width: Get.width,
                  height: Get.height * 2 / 5,
                  padding: const EdgeInsets.all(8),
                  color: Colors.black,
                ),
              ),
            ),
            Obx(
              () => ProsteIndexedStack(
                index: progressService.progress.value,
                children: [
                  IndexedStackChild(child: Container()),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement:
                          '전 중앙정보부의 부장 김형욱은 미국 프레이저 청문회에 참석해 대통령의 통치와 부정부패 및 비리 등을 폭로한다.',
                      name: '나레이션',
                    ),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement:
                          '심지어 김형욱은 프레이저 청문회에서 밝히진 않았지만 FBI와 기자들에게 잔뜩 알린 대통령의 치부들, 특히 스위스 비밀계좌에 관한 내용에 상세히 적힌 회고록을 작성하고 있었고,',
                      name: '나레이션',
                    ),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement:
                          '이것이 세상에 알려지면 가뜩이나 정권 유지가 위기에 놓인 대통령은 궁지에 몰릴 터였다.',
                      name: '나레이션',
                    ),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement:
                          '내가 1960년대 정보부장 시절 주미대사 김현철씨가 말하길 \'박동선이라는 자가 박 대통령의 친척이라고 하고 다닌다\'는 보고를 받았고, 귀국한 박씨를 조사하면서 알게 되었다.',
                      name: '김형욱',
                      leftPerson: 'assets/character/american2.png',
                      rightPerson: 'assets/character/kimhyungwook3.png',
                    ),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement:
                          '이후 나는 박씨가 미국에 발이 넓다는 걸 알고 편의를 제공했었다. 또한 그의 클럽이 자금난이라고 해서 서울 암달러상에게 구한 10만 달러를 파우치편으로 보내주었다.',
                      name: '김형욱',
                      leftPerson: 'assets/character/american2.png',
                      rightPerson: 'assets/character/kimhyungwook3.png',
                    ),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement:
                          '또한 한국의 정부 보유금 300만달러를 박동선의 거래은행에 맡기게 해 클럽 운용자금으로 융자해주었다.',
                      name: '김형욱',
                      leftPerson: 'assets/character/american2.png',
                      rightPerson: 'assets/character/kimhyungwook3.png',
                    ),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement: '정확한 내용이나 증거를 확인할 수 있는 내용입니까?',
                      name: '기자',
                      leftPerson: 'assets/character/american2.png',
                      rightPerson: 'assets/character/kimhyungwook3.png',
                    ),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                      statement: '작성 중인 회고록이 있으며, 회고록에 상세한 내용을 담아 공개할 예정입니다.',
                      name: '김형욱',
                      leftPerson: 'assets/character/american2.png',
                      rightPerson: 'assets/character/kimhyungwook3.png',
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: _isIntroVisible,
              child: Align(
                alignment: Alignment.center,
                child: Opacity(
                  opacity: introAnimation.value as double,
                  child: const Text('CHAPTER. 1\n폭로',
                      textAlign: TextAlign.center, style: chapterTextStyle),
                ),
              ),
            ),
            IgnorePointer(
              ignoring: _isIgnore,
              child: GestureDetector(
                onTap: () async {
                  Get.log('onTap...');
                  await (_chapterAudioPlayer).stop();
                  introController.reverse(from: 1.0);
                  setState(() {
                    _isIgnore = true;
                  });
                },
                child: Container(
                  color: Colors.transparent,
                  width: Get.width,
                  height: Get.height,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

/**
 * 1. 왼쪽, 오른쪽 인물을 나타내는 위젯 필요. 인물 변경시 자동으로 이미지도 변경
 * 2. 애니메이션에 맞춰 대사 적용 필요
 * 3. 자동 실행 적용 필요
 */
