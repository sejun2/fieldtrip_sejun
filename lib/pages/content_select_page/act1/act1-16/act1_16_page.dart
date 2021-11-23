import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_16Page extends StatefulWidget {
  const Act1_16Page({Key? key}) : super(key: key);

  @override
  _Act1_16PageState createState() => _Act1_16PageState();
}

class _Act1_16PageState extends State<Act1_16Page> {
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
    progressService.lastProgress = 34;
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
                      leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '분위기가 무르익어 가는 만찬장.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        statement: '요새 김부장이 좀 기운이 빠진 것 같아 위로 차 불렀어. 여긴 김 부장을 위한 자리다.',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '박정희가 직접 술을 따라 주지만 김재규 부장의 표정은 밝지 않다.',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '우리 김부장이 술은 잘 알아.',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '분위기가 무르익자 박 대통령도 기분이 좋은 듯 흥얼거리는 와중.',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '김재규 부장은 반 쯤 취해서 박 대통령에게 술잔을 따라주는데, 양주를 크리스탈 잔 가득 채우고도 멈추지 않아서 잔이 넘친다.',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '박 대통령과 차지철 실장이 당혹한 표정을 짓는 사이, 김재규 부장은 5.16 군사정변 당시의 추억을 얘기한다.',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '각하, 기억하십니까? 그날 새벽, 각하를 모시고 한강 다리 중간쯤 건너는데 저기 딱, 헌병대 저지선이 보이는 겁니다. 각하를 따라서 지프에서 내려서 뚜벅뚜벅 한강 다리를 건너는데..',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '\'슈웅~!\' 총알이 날아왔지. 막 깜깜해서 보이지도 않는데, 귓볼에 총알 날아가는 소리가 스쳤지.',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '그때 각하가 제게 물으셨죠. \'김 대령, 어떻게할까?\'',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '김재규'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '\'사나이 가는 길 앞에 웃음만이 있을쏘냐, 결심하고 가는 길 가로막는 폭풍우, 어이 없으라. 각하! 가시지요!\' 라고 김부장이 그랬지.',
                        leftPerson: 'assets/character/kimjaegyu1.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '박정희'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '아, 그 때는 배포가 있었어요. 근데 요즘 영 쪼그라들어서..',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '차지철'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '(말을 끊으며) 그 때 만약, 그 다리를.. 건너지 않았더라면..',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '이 때부터 이야기를 받아주던 박 대통령의 표정은 미묘하게 바뀌고, 김재규 부장은 모든 것을 내려놓은 듯 행동에 거리낌이 없어진다.',

                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',

                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '양주를 자기가 가져가 한 잔을 가득 채워 김형욱을 위한 음복주라며 놓아 두고, 한 잔 더 스스로 따라 한입에 털어 넣어 버린다.',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '주도 상으로는 윗사람에게 엄청나게 실례되는 행동들 투성이다.',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '왜 다들, 음복 모르십니까? 이렇게 마시면서 귀신과 한 몸이 되는 거요. 박 부장과 우리가 원래 한 몸 아니었습니까? 안 그렇습니까, 각하?',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '아! 죽고 싶나?',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '차지철'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '(차지철을 가리키며) 이 딴 버러지같은 새끼를 옆에 끼고 정치를 하시니까! 나라가 이 모양 이 꼴 아닙니까?',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '아니, 김부장! 왜 이래?',
                        leftPerson: 'assets/character/kimgyewon.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '김계원'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '지금 뭐 하자는 거야?',
                        leftPerson: 'assets/character/kimgyewon.png',
                        rightPerson: 'assets/character/parkjunghee1.png',
                        name: '박정희'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '각하! 이제 그만하시고 하야하십시오!',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '야!',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '차지철'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '각하! 하야하십시오!',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '(일어서서 김재규의 멱살을 잡으며) 이 새끼가..!',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '차지철'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '가만히 있어!! (담배를 꺼내며) 야 김부장! 내가 너를 왜 그 자리에 앉힌 줄 알아? 지 친구도 죽인 놈이! 어디서 고고한 척을 하고 있어? 제발, 네 일이나 똑바로 해!',
                        leftPerson: 'assets/character/parkjunghee1.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '박정'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '각하! 왜 혁명을 하셨습니까? 왜 우리가 목숨을 걸고, 혁명을 했습니까? 100만, 200만 탱크로 밀어서 죽여버리겠다고? 제발 각하! 정신 좀 차리십시오!',
                        leftPerson: 'assets/character/parkjunghee1.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '(다시금 멱살을 잡으며)이 개새끼가 미쳤나!',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '차지철'),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '(호주머니에서 총을 꺼내며) 넌 너무 건방져. 이 새끼야!',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '(당황하며 손으로 앞을 가린다)왜 이래?!',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '차지철'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '김재규가 차지철을 향해 총을 쏘고, 팔꿈치를 맞은 차지철이 피를 흘리며 쓰러진다.',
                        leftPerson: 'assets/character/chajichul.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: ''),
                  ),

                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '김재규가 곧바로 총구를 박 대통령에게 돌린다.',
                        leftPerson: 'assets/character/parkjunghee1.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: ''),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '뭐 하는 짓이야!!',
                        leftPerson: 'assets/character/parkjunghee1.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '박정희'),
                  ), IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement: '.. 너도 죽어 봐!',
                        leftPerson: 'assets/character/parkjunghee1.png',
                        rightPerson: 'assets/character/kimjaegyu1.png',
                        name: '김재규'),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: () async {
                await _player.stop();
                progressService.resetProgress();
                Get.offNamed('/act1-17');
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
