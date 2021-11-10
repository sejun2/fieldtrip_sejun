import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_17Page extends StatefulWidget {
  const Act1_17Page({Key? key}) : super(key: key);

  @override
  _Act1_17PageState createState() => _Act1_17PageState();
}

class _Act1_17PageState extends State<Act1_17Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/shot_sound.mp3';

  initResources() async {
    _player = await AudioCache().play(audioPath);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    initResources();
    progressService.lastProgress = 3;
    Timer(const Duration(milliseconds: 600), () {
      progressService.progress.value = 1;
    });
    progressService.isDone.listen((value) {
      if (value) {
        //isDone 일경우
        Get.log('isDone : $value');
        if (mounted) {
          setState(() {
            _isIgnore = false;
          });
        }
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
              'assets/background/gun.png',
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
                        statement:
                            '박 대통령의 오른쪽 가슴팍에 총탄이 꽂히고, 만찬장은 순식간에 아수라장이 되어버렸다.',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                            '그 사이에 김재규 부장의 부하들은 대통령의 경호원들을 모두 쓰러트리고',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                            '김재규 부장은 차지철 실장을 끝장내기 위해 총을 겨누는데, 순간적으로 건물이 정전되어 버린다.',
                        name: '나레이션'),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: () {
                _player.stop();
                progressService.resetProgress();
                Get.offNamed('/act1-18');
              },
              child: Container(
                color: Colors.transparent,
                width: Get.width,
                height: Get.height,
              ),
            ),
          ),
        ],
      ),
    );
  }
}