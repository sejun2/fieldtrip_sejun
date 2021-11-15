import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_9Page extends StatefulWidget {
  const Act1_9Page({Key? key}) : super(key: key);

  @override
  _Act1_9PageState createState() => _Act1_9PageState();
}

class _Act1_9PageState extends State<Act1_9Page> with TickerProviderStateMixin {
  late AnimationController backgroundController;
  late Animation backgroundAnimation;

  late AnimationController statementContainerController;
  late Animation statementContainerAnimation;

  final progressService = Get.put(ProgressService());
  double _wholeOpacity = 1.0;
  double _chapterOpacity = 0.0;

  bool _wholeIgnore = false;
  bool _chapterIgnore = true;

  final String _chapterPath = 'BGM/chapter_sound.mp3';
  final String _soundPath = 'BGM/france_sound.mp3';
  late AudioPlayer _player;
  late AudioPlayer _chapterPlayer;

  _initResources() async {
    _player = await AudioCache().play(_soundPath);
    progressService.lastProgress = 3;


    progressService.isDone.listen((value) {
      Get.log('isDone : $value');
      if (value) {
        Get.log('if ....');
        _player.stop();
        AudioCache().play(_chapterPath).then((value) => _chapterPlayer = value);
        if(mounted) {
          setState(() {
            _wholeIgnore = true;
            _chapterIgnore = false;
            _wholeOpacity = 0.0;
            _chapterOpacity = 1.0;
          });
        }
      }
    });
  }

  void _initAnimation() {
    backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    backgroundAnimation =
        CurvedAnimation(parent: backgroundController, curve: Curves.linear);

    statementContainerController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    statementContainerAnimation = Tween<double>(
      begin: 0.0,
      end: 0.7,
    ).animate(statementContainerController);

    backgroundAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        progressService.incrementProgress();
      }
    });
  }

  @override
  void initState() {
    _initAnimation();
    _initResources();
    Timer(const Duration(seconds: 2), () {
      backgroundController.forward(from: 0.0);
      statementContainerController.forward(from: 0.0);
    });
    super.initState();
  }

  @override
  void dispose() {
    Get.log('dispose called...');

    _player.stop();
    statementContainerController.dispose();
    backgroundController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          IgnorePointer(
            ignoring: _wholeIgnore,
            child: AnimatedOpacity(
              opacity: _wholeOpacity,
              duration: const Duration(seconds: 2),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: backgroundAnimation,
                    builder: (BuildContext context, Widget? child) {
                      return Opacity(
                        opacity: backgroundAnimation.value,
                        child: Image.asset(
                          'assets/background/france2.png',
                          width: Get.width,
                          height: Get.height,
                          fit: BoxFit.fill,
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: statementContainerAnimation,
                    builder: (BuildContext context, Widget? child) {
                      return Positioned(
                        bottom: 7,
                        child: AnimatedOpacity(
                          duration: const Duration(seconds: 3),
                          opacity: statementContainerAnimation.value,
                          child: Container(
                            width: Get.width,
                            height: Get.height * 2 / 5,
                            padding: const EdgeInsets.all(8),
                            color: Colors.black,
                          ),
                        ),
                      );
                    },
                  ),
                  Obx(() {
                    return ProsteIndexedStack(
                      index: progressService.progress.value,
                      children: [
                        IndexedStackChild(
                          child: Container(),
                        ),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '나레이션',
                          statement: '김재규 부장이 김형욱을 처리하기 위해 수를 쓰게 되는데,',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '나레이션',
                          statement:
                              '미리 파견을 보낸 김재규 부장의 요원을 통해 수지 박을 거짓말로 속여내어 프랑스로 부른 뒤 차에 태워 \'고국땅을 밟고 싶으면 김형욱을 유인하라 \'며 그녀를 포섭하는 방법이었다.',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '나레이션',
                          statement:
                              '납치되어 차를 타고 끌려가던 김형욱은 차량 내부에서 사고를 낸뒤 도망가지만 이내 김재규 부장의 요원들에게 잡혀 현장에서 살해된다.',
                        )),
                      ],
                    );
                  })
                ],
              ),
            ),
          ),
          //chapter 화면
          IgnorePointer(
            ignoring: _chapterIgnore,
            child: AnimatedOpacity(
              opacity: _chapterOpacity,
              duration: const Duration(seconds: 2),
              child: GestureDetector(
                onTap: () async {
                  await _chapterPlayer.stop();
                  setState(() {
                    _chapterOpacity = 0.0;
                  });
                  Timer(const Duration(seconds: 2), () async {
                    Get.offNamed('/act1-10');
                  });
                },
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'CHAPTER. 3\n김재규',
                      style: chapterTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  void doLastProcess() {
    //TODO: 화면이 어두워지면서 Chapter 나타남. 이후 해당 화면 클릭시 화면 이동.
  }
}
