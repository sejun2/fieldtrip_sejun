import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_5Page extends StatefulWidget {
  const Act1_5Page({Key? key}) : super(key: key);

  @override
  _Act1_5PageState createState() => _Act1_5PageState();
}

class _Act1_5PageState extends State<Act1_5Page> {
  final ProgressService progressService = Get.put(ProgressService());

  late AudioPlayer _player;

  final String soundPath = 'BGM/serious_sound.mp3';

  bool _isIgnore = true;

  void initResources() async {
    _player = await AudioCache().play(soundPath);
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
      if (mounted) {
        progressService.resetProgress();
        if (value) {
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
  void dispose() {
    // progressService.isDone.close();
    super.dispose();
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
                'assets/background/tortureroom.png',
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
                          rightPerson: 'assets/character/kimjaegyu1.png',
                          leftPerson: 'assets/character/professor.png',
                          statement: '제임스 류에 대해 확인되었다. 알고 있는 모든 사실을 실토해라.',
                          name: '김재규'),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          rightPerson: 'assets/character/kimjaegyu1.png',
                          leftPerson: 'assets/character/professor.png',
                          statement:
                              '미국에서 <r>제임스 류</r> 라는 중앙정보부 요원의 의뢰로 <b>김형욱</b>을 <r>도청</r>했고, 한국으로 돌아온 후에는 <b>김재규</b>에 대한 <r>도청</r>을 의뢰받았소.',
                          name: '교수'),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          statement: '김재규 부장이 찾아본 결과 <r>제임스 류</r>의 한국 이름은 유동훈.',
                          name: ''),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          statement:
                              '그는 <b>차지철</b> 실장이 군인이었던 시절 그의 밑에서 복무한 부대원 출신이었으며, <b>차지철<b> 실장의 추천으로 중앙정보부에 들어온 <b>차지철</b> 실장의 <r>세작</r>이었다는 것을 알게 된다.',
                          name: ''),
                    ),
                    IndexedStackChild(
                      child: const StatementSceneWidget(
                          statement:
                              '유동훈의 목적은 프랑스 주재 한국대사와 짜고 프랑스로 <b>김형욱</b>을 유인하여 현지에서 <r>암살</r>하는 것이었다.',
                          name: ''),
                    ),
                  ]),
            ),
            IgnorePointer(
              ignoring: _isIgnore,
              child: GestureDetector(
                onTap: () async {
                  Get.log('IgnorePointer tapped...');
                  await _player.stop();
                  Get.offAndToNamed('/act1-6');
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
