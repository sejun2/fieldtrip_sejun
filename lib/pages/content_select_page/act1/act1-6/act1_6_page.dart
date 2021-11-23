import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
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

  late AudioPlayer _player;
  final String audioPath = 'BGM/partyroom_sound.mp3';

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

    progressService.lastProgress = 5;

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
              'assets/background/bluehouse_inside.png',
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
                        statement: '<r>도청</r> 사실을 알게 된 <b>김재규</b> 부장은 <b>박정희</b>에게 보고하러 대통령 집무실로 향한다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '각하 보고 드릴 사항이...',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '자! 나가봅시다.',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                        '김재규 부장이 고깝게 보이는 <b>박 대통령</b>은 측근들을 데리고 <b>김재규</b> 부장을 대놓고 무시한 채 지나가 버린다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                        '<b>차지철</b> 실장이 <b>김형욱</b>을 <r>암살</r>할 의도를 가지고 있음을 알게 되었고, 이를 저지하고 싶지만 <b>김형욱</b>에 대한 분노가 머리 끝까지 치달은 <b>박 대통령</b>을 설득하기란 거의 불가능에 가까운 상황.',
                        name: ''),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: () async {
                  await _player.stop();
                  Get.offNamed('/act1-7');
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
