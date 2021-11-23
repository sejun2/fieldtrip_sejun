import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_15Page extends StatefulWidget {
  const Act1_15Page({Key? key}) : super(key: key);

  @override
  _Act1_15PageState createState() => _Act1_15PageState();
}

class _Act1_15PageState extends State<Act1_15Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/goongjungdong_sound.mp3';

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
    progressService.lastProgress = 1;
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
              'assets/background/home.png',
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
                        statement: '김재규 부장은 비밀 금고에서 권총을 챙겨 주머니에 찔러 넣고 궁정동 안가의 만찬 장소로 향한다.',
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
                Get.offNamed('/act1-16');
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
