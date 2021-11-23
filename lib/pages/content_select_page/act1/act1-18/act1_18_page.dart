import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_18Page extends StatefulWidget {
  const Act1_18Page({Key? key}) : super(key: key);

  @override
  _Act1_18PageState createState() => _Act1_18PageState();
}

class _Act1_18PageState extends State<Act1_18Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String audioPath = 'BGM/inside_car_sound.wav';

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
    progressService.lastProgress = 10;
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
              'assets/background/inside_car.jpg',
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
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '이 후 김재규 부장의 심복들이 궁정동의 인원들을 제압하는데 성공하고 김재규 부장은 그 모습들을 확인한 후,',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '난리통에 당황한 육군참모총장과 자신의 심복들과 함께 차에 타 엄지 손가락을 들어올리는 제스처를 취하려다 버벅거리면서',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '각하가 저격당하셨다. 조치를 취해야 한다. 남산으로 가자!',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '김재규 부장은 심하게 긴장한 듯 평정심을 되찾지 못하고, 차량에 구비된 사탕을 씹어먹으면서 육군참모총장에게도 사탕을 권유한다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '참모총장은 얼떨떨해하는 와중에 사탕을 몰래 차 바닥에 버려 버린다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '그 때, 겨우 정신이 든 김재규 부장은 무언가 이물감에 아래를 바라보는데, 난리통에 구두를 신지도 않고 나와 젖어있는 양말 차림의 발을 보게 된다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '상념에 빠졌는지 김재규 부장은 잠시 멍하게 있고,',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '병력 동원의 수월성 등도 있고 하니, 남산이 아니라 차라리 육군본부에 가는게 어떠십니까?',
                        name: '육군참모총장'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '(잠시 생각하다가) ... 그렇게 하지.',
                        name: '김재규'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                      //TODO : 대사 수정
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        leftPerson: 'assets/character/jungseunghwa.png',
                        statement:
                        '결국 그들을 태운 차량은 비참한 운명이 기다리고 있는 육군본부로 향하게 된다.',
                        name: ''),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: ()async {
                await _player.stop();
                progressService.resetProgress();
                Get.offNamed('/act1-19');
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
