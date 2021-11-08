import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_6Page extends StatefulWidget {
  const Act1_6Page({Key? key}) : super(key: key);

  @override
  _Act1_6PageState createState() => _Act1_6PageState();
}

class _Act1_6PageState extends State<Act1_6Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  @override
  void initState() {
    super.initState();

    progressService.lastProgress = 6;

    Timer(const Duration(milliseconds: 600), () {
      progressService.progress.value = 1;
    });
    progressService.isDone.listen((value) {
      if (value) {
        //isDone 일경우
        Get.log('isDone : $value');
        _isIgnore = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GestureDetector(
            onTap: () {},
            child: Image.asset(
              'assets/background/partyroom2.png',
              width: Get.width,
              height: Get.height,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 50,
            child: Opacity(
              opacity: 0.7,
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
                        rightPerson: 'assets/character/sujiparktomson.png',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        statement: '그 즈음 한미 친선 연회가 열리게 되었고,',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/sujiparktomson.png',
                        statement:
                        '파티에 참여한 김재규 부장은 수지 박 톰슨을 만나 김형욱의 의향을 전해 듣게 되는데,',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/sujiparktomson.png',
                        statement: '김형욱은 김부장의 혁명에 대해 이야기하더군요.',
                        name: '수지 박'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/sujiparktomson.png',
                        statement:
                        '혁명 이라니.. 그 무슨!!',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                        '그토록 존경하고 가까이 지내던 박 대통령이긴 하나,',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                        '그를 몰아내고 정권을 차지하라는 김형욱의 권유는 너무나 고민되면서 매혹적인 것이었다.',
                        name: '나레이션'),
                  ),
                ]),
          ),
          GestureDetector(
            onTap: () {
              if (!_isIgnore) {
                Get.offNamed('/act1/question3');
              }
            },
            child: Container(
              width: Get.width,
              height: Get.height,
            ),
          ),
        ],
      ),
    );
  }
}