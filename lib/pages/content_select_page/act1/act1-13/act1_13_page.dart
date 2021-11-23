import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_13Page extends StatefulWidget {
  const Act1_13Page({Key? key}) : super(key: key);

  @override
  _Act1_13PageState createState() => _Act1_13PageState();
}

class _Act1_13PageState extends State<Act1_13Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/closet_sound.mp3';

  initResources() async{
    _player = await AudioCache().play(audioPath);
  }
  @override
  void dispose() {
    progressService.isDone.close();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    initResources();
    progressService.lastProgress = 2;
    Timer(const Duration(milliseconds: 600), () {
      progressService.progress.value = 1;
    });
    progressService.isDone.listen((value) {
      if (value) {
        //isDone 일경우
        Get.log('isDone : $value');
        if(mounted) {
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
              'assets/background/closet.png',
              width: Get.width,
              height: Get.height,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            bottom: 7,
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
                        statement: '박 대통령과 차 실장의 대화 내용을 도청한 김재규 부장은 그 내용에 소스라치게 놀라며 결심을 하게 된다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        statement: '가만히 앉아서 당하느니 내가 먼저 친다!',
                        name: '김재규'),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: () async {
                await _player.stop();
                progressService.resetProgress();
                Get.offNamed('/act1-14');
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
