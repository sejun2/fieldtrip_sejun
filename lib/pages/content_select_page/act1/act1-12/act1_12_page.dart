import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_12Page extends StatefulWidget {
  const Act1_12Page({Key? key}) : super(key: key);

  @override
  _Act1_12PageState createState() => _Act1_12PageState();
}

class _Act1_12PageState extends State<Act1_12Page> {
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
              'assets/background/food.png',
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
                      leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '<b>차실장</b> 덕분에 미 대사관에서 <b>김부장</b>의 속내를 알 수 있었어.',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '아닙니다 각하. 당연한 일을 했을 뿐입니다.',
                        name: '차지철'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '나를 몰아내겠다고 하는 주한대사나 <b>김재규</b> 부장. 그 새끼나 다 똑같은 새끼들이다. 미국에게 붙어먹고 <r>친구나 죽인</r> 교활한 백정같은 배신자 새끼일 뿐이야!',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '<b>김재규</b>를 어떻게 하면 좋겠습니까?',
                        name: '차지철'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '임자 하고 싶은 대로 해. 임자 곁에는 내가 있잖아!',
                        name: '박정희'),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: () async {
                await _player.stop();
                progressService.resetProgress();
                Get.offNamed('/act1-13');
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
