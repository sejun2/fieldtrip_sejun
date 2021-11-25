import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_11Page extends StatefulWidget {
  const Act1_11Page({Key? key}) : super(key: key);

  @override
  _Act1_11PageState createState() => _Act1_11PageState();
}

class _Act1_11PageState extends State<Act1_11Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/closet_sound.mp3';

  initResources() async {
    _player = await AudioCache().play(audioPath);
  }

  @override
  void dispose() {
    // progressService.isDone.close();
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
      if (mounted) {
        if (value) {
          //isDone 일경우
          progressService.resetProgress();
          Get.log('isDone : $value');
          setState(() {
            _isIgnore = false;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {return Future(() => false);},
      child: Scaffold(
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
                          statement:
                              '이대로라면 박정희로부터 버림받을 위기에 놓였다고 생각한 <b>김재규</b>는 비가 억수같이 쏟아지는 밤,',
                          name: ''),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          statement:
                              '<b>차 실장과 박 대통령</b>이 술을 나누는 술자리로 <r>잠입</r>해 옆방의 옷장에서 둘이 나누는 이야기를 도청한다.',
                          name: ''),
                    ),
                  ]),
            ),
            IgnorePointer(
              ignoring: _isIgnore,
              child: GestureDetector(
                onTap: () async {
                  await _player.stop();
                  progressService.resetProgress();
                  Get.offNamed('/act1/question4');
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
      ),
    );
  }
}
