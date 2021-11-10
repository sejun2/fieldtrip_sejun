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

  initResources() async{
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

    progressService.lastProgress = 7;

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
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '박 대통령과의 관계 회복을 기대하며 대통령 주재 회의 직후 김형욱 암살 성공을 알리는 김재규 부장.',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '김형욱 암살로 인해 이제 박 대통령이 자신을 다시 신망할거라 생각하고 있었다.',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '각하! 제가 이렇게까지 해드렸으니 제발 게엄령만은 거두어 주시고 미국 내 여론은 제가 어떻게든 할 테니 협조를 해주셔야 합니다.',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '김부장! 지금 나 협박해? 그깟 배신자 하나 죽인 게 뭐가 그렇게 중요한가? 김형욱이 숨긴 돈은 어딨니?',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '예? 각하! 김형욱이 중정부장 시절 개인적으로 착복한 돈 외에는 찾을 수가 없었습니다.',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '협박을 하려거든 내가 원하는 걸 좀 제대로 가져와! 거 담배나 하나 줘보게.',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '옆에 있는 탁자 위의 담뱃갑을 쥐지만 순간적으로 박정희에 대한 배신감과 분노에 치를 떨며 담뱃갑을 구겨버린다.',
                        name: '나레이션'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '김형욱을 살릴지 먼저 나서서 죽일지 고심하던 김재규 부장은 이에 결심을 굳히게 된다.',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '바로 박 대통령에게서 자신이 잃어버린 신뢰와 신임을 다시 되찾아 관계를 회복하기 위해서, 친구이자 혁명의 동지였던 김형욱을 차지철 실장보다 먼저 제거하기로 결정하게 되었다.',
                        name: '나레이션'),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: ()  {
                _player.stop();
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
    );
  }
}
