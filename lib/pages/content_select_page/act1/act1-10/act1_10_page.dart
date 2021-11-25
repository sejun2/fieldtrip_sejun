import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_10Page extends StatefulWidget {
  const Act1_10Page({Key? key}) : super(key: key);

  @override
  _Act1_10PageState createState() => _Act1_10PageState();
}

class _Act1_10PageState extends State<Act1_10Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/bluehouse_sound.mp3';

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

    progressService.lastProgress = 7;

    Timer(const Duration(milliseconds: 600), () {
      progressService.progress.value = 1;
    });
    progressService.isDone.listen((value) {
      if (mounted) {
        if (value) {
          progressService.resetProgress();
          //isDone 일경우
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
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                          statement:
                              '<b>박 대통령</b>과의 관계 회복을 기대하며 대통령 주재 회의 직후 <b>김형욱</b> <r>암살</r> 성공을 알리는 <b>김재규</b> 부장.',
                          name: ''),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                          statement:
                              '<b>김형욱</b> <r>암살</r>로 인해 이제 <b>박 대통령</b>이 자신을 다시 신망할거라 생각하고 있었다.',
                          name: ''),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                          statement:
                              '각하! 제가 이렇게까지 해드렸으니 제발 게엄령만은 거두어 주시고 미국 내 여론은 제가 어떻게든 할 테니 협조를 해주셔야 합니다.',
                          name: '김재규'),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                          statement:
                              '<b>김부장!</b> 지금 나 협박해? 그깟 배신자 하나 죽인 게 뭐가 그렇게 중요한가? <b>김형욱</b>이 숨긴 돈은 어딨니?',
                          name: '박정희'),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                          statement:
                              '예? 각하! <b>김형욱</b>이 중정부장 시절 개인적으로 착복한 돈 외에는 찾을 수가 없었습니다.',
                          name: '김재규'),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                          statement: '협박을 하려거든 내가 원하는 걸 좀 제대로 가져와! 거 담배나 하나 줘보게.',
                          name: '박정희'),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          leftPerson: 'assets/character/kimjaegyu1.png',
                          rightPerson: 'assets/character/parkjunghee1.png',
                          statement:
                              '옆에 있는 탁자 위의 담뱃갑을 쥐지만 순간적으로 <b>박정희</b>에 대한 <r>배신감과 분노</r>에 치를 떨며 담뱃갑을 구겨버린다.',
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
                  Get.offNamed('/act1-11');
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
