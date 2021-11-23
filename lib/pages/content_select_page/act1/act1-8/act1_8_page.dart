import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_8Page extends StatefulWidget {
  const Act1_8Page({Key? key}) : super(key: key);

  @override
  _Act1_8PageState createState() => _Act1_8PageState();
}

class _Act1_8PageState extends State<Act1_8Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/bluehouse_sound.mp3';

  initResources() async{
    _player = await AudioCache().play(audioPath);
  }
  @override
  void dispose() {
    Get.log('Act1_8page dispose called...');
    progressService.isDone.close();
    super.dispose();
  }
  @override
  void initState() {
    super.initState();

    initResources();

    progressService.lastProgress = 9;

    Timer(const Duration(milliseconds: 600), () {
      progressService.progress.value = 1;
    });
    progressService.isDone.listen((value) {
      if (value) {
        //isDone 일경우
        Get.log('isDone : $value');
        Get.log('act 1-8 isdone called...');
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
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '<b>김부장.</b> 오랜만에 한잔 어떠신가?',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '예 각하!',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '참 오래되었어. 우리가 함께 한 세월 말이야. 내가 오래 대통령을 해왔지. 이후에 내가 이 자리를 내려놓게 되면 그땐 김부장이 뒤를 이어 주었으면 해.',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '각하! 무슨 말씀이십니까?',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '그나저나, <b>김형욱</b>은 어떻게 <r>처리</r>를 해야 좋을 거 같나, 김부장',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '각하, 제가 어떻게 하길 원하십니까?',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '임자 하고 싶은 대로 해. 임자 곁에는 내가 있잖아.',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '김형욱을 살릴지 먼저 나서서 죽일지 고심하던 <b>김재규</b> 부장은 이에 결심을 굳히게 된다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement:
                        '바로 <b>박 대통령</b>에게서 자신이 잃어버린 신뢰와 신임을 다시 되찾아 관계를 회복하기 위해서, 친구이자 혁명의 동지였던 <b>김형욱</b>을 <b>차지철</b> 실장보다 먼저 <r>제거</r>하기로 결정하게 되었다.',
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
                Get.offNamed('/act1-9');
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
