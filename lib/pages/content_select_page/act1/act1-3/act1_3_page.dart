import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

//기본틀로 이 페이지 사용하면 될듯?
class Act1_3Page extends StatefulWidget {
  const Act1_3Page({Key? key}) : super(key: key);

  @override
  _Act1_3PageState createState() => _Act1_3PageState();
}

class _Act1_3PageState extends State<Act1_3Page> with TickerProviderStateMixin {
  late AnimationController backgroundController;
  late Animation backgroundAnimation;

  late AnimationController statementContainerController;
  late Animation statementContainerAnimation;

  final progressService = Get.put(ProgressService());

  double _wholeOpacity = 1.0;
  double _chapterOpacity = 0.0;

  bool _wholeIgnore = false;
  bool _chapterIgnore = true;

  final _bluehouseSoundPath = 'BGM/bluehouse_sound.mp3';
  final _chapterSoundPath = 'BGM/chapter_sound.mp3';
  late AudioPlayer _chapterPlayer;
  late AudioPlayer _bluehousePlayer;

  Future<void> _initResources() async {
    await AudioCache().clearAll();
    progressService.isDone.listen((value) async {
      if (value) {
        await _bluehousePlayer.stop();
        _chapterPlayer = await AudioCache().play(_chapterSoundPath);
        //해당 page의 progress가 끝났을 경우...
        progressService.resetProgress();
        Get.log('act1-3 done...');
        Timer(const Duration(seconds: 1), () async {
          if (mounted) {
            setState(() {
              _wholeIgnore = true;
              _chapterIgnore = false;
              _wholeOpacity = 0.0;
              _chapterOpacity = 1.0;
            });
          }
        });
      }
    });

    _bluehousePlayer = await AudioCache().play(_bluehouseSoundPath);
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
    super.initState();
    progressService.lastProgress = 9;
    _initAnimation();
    _initResources();
    Timer(const Duration(seconds: 2), () {
      backgroundController.forward(from: 0.0);
      statementContainerController.forward(from: 0.0);
    });
  }

  releaseResources() async{
    await _chapterPlayer.stop();
  }
  @override
  void dispose() {
    Get.log('dispose called...');
    statementContainerController.dispose();
    releaseResources();
    backgroundController.dispose();
    progressService.isDone.close();
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
                          'assets/background/bluehouseoffice.png',
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
                          name: '김재규',
                          statement:
                              '각하, 미국 프레이저 청문회에서 <b>김형욱</b>이 폭로를 하고 있습니다. 횡령이나 박동선이라는 자와의 일을 밝혔으며, FBI와 기자들에게, 각하에 대해 안좋은 이야기를 퍼뜨리고 있다고 합니다.',
                          leftPerson: 'assets/character/chajichul.png',
                          rightPerson: 'assets/character/kimjaegyu2.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '차지철',
                          statement:
                              '아니, <b>중정부장</b>씩이나 되는 사람이 그거 하나 못 막고 뭘 하고 있었던거요?',
                          leftPerson: 'assets/character/chajichul.png',
                          rightPerson: 'assets/character/kimjaegyu2.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '박정희',
                          statement: '그 배신자 새끼를 어떻게 하면 좋겠나?',
                          leftPerson: 'assets/character/chajichul.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '차지철',
                          statement: '당장 잡아다가 청와대 뒷마당 무궁화 퇴비로 써야죠. 각하!',
                          leftPerson: 'assets/character/chajichul.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '김재규',
                          statement: '각하 우선 제가 미국으로 넘어가서 조용히 해결해보겠습니다.',
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '박정희',
                          statement: '김부장 잠시..',
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '김재규',
                          statement:
                              '각하 현재 미국의 시선이 <b>김형욱</b>에게 집중되어 있습니다. 제가 미국으로 넘어가 직접 만나서 <r>회고록</r>부터 회수하도록 하겠습니다.',
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '박정희',
                          statement: '<b>김부장</b>도 내가 그만두기를 바라나?',
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                        )),
                        IndexedStackChild(
                            child: const StatementSceneWidget(
                          name: '김재규',
                          statement: '제가.. 각하 옆을 지키겠습니다.',
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
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
                  setState(() {
                    _chapterOpacity = 0.0;
                  });
                  await _chapterPlayer.stop();
                  Timer(const Duration(seconds: 2), () async {
                    await _chapterPlayer.stop();
                    progressService.resetProgress();
                    Get.offNamed('/act1-4');
                  });
                },
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.black,
                  child: const Center(
                    child: Text(
                      'CHAPTER. 2\n첩보전',
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
