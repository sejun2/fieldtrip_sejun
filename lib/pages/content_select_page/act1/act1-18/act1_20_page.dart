import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_20Page extends StatefulWidget {
  const Act1_20Page({Key? key}) : super(key: key);

  @override
  _Act1_20PageState createState() => _Act1_20PageState();
}

class _Act1_20PageState extends State<Act1_20Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/bluehouse_sound.mp3';

  initResources() async {
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
              'assets/background/bluehouseoffice.png',
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
                        '박정희가 죽은 지 6개월 후, 누군가 주인 잃은 청와대 집무실에 몰래 들어오는데,',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                        '무엇을 찾는 것인지 조심스럽게 들어와서 뒤적거리다가, 이내 금고를 찾아내고는 해제를 시도한다.',
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
                Get.offNamed('/act1/question5');
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
