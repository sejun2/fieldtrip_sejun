import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  double _backgroundOpacity = 0.0;

  void _initResources() {
    progressService.isDone.listen((value) {
      //해당 page의 progress가 끝났을 경우...
      Get.log('act1_2 isDone...');
    });
  }

  void _initAnimation() {
    backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    backgroundAnimation =
        CurvedAnimation(parent: backgroundController, curve: Curves.linear);

    statementContainerController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    statementContainerAnimation = CurvedAnimation(
        parent: statementContainerController, curve: Curves.linear);

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

  @override
  void dispose() {
    backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                bottom: 50,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 3),
                  opacity: statementContainerAnimation.value,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 2 / 5,
                    padding: const EdgeInsets.all(8),
                    color: Colors.amber,
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
                      '각하, 미국 프레이저 청문회에서 김형욱이 폭로를 하고 있습니다. 횡령이나 박동선이라는 자와의 일을 밝혔으며, FBI와 기자들에게, 각하에 대해 안좋은 이야기를 퍼뜨리고 있다고 합니다.',
                  leftPerson: 'assets/character/chajichul.png',
                  rightPerson: 'assets/character/kimjaegyu2.png',
                )),
                IndexedStackChild(
                    child: const StatementSceneWidget(
                  name: '차지철',
                  statement: '미국의 소식을 듣게 된 김재규는 대통령을 만나기 위해 청와대로 향한다 .',
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
                      statement: '각하 현재 미국의 시선이 김형욱에게 집중되어 있습니다. 제가 미국으로 넘어가 직접 만나서 회고록부터 회수하도록 하겠습니다.',
                      leftPerson: 'assets/character/kimjaegyu1.png',
                      rightPerson: 'assets/character/parkjunghee1.png',
                    )),
                IndexedStackChild(
                    child: const StatementSceneWidget(
                      name: '박정희',
                      statement: '김부장도 내가 그만두기를 바라나?',
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
    );
  }
}
