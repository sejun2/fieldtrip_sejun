import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_21Page extends StatefulWidget {
  const Act1_21Page({Key? key}) : super(key: key);

  @override
  _Act1_21PageState createState() => _Act1_21PageState();
}

class _Act1_21PageState extends State<Act1_21Page> {
  final ProgressService progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  final String _typingSoundPath = 'BGM/typing_sound.mp3';
  late AudioPlayer _player;

  initResources() async {
    _player = await AudioCache().play(_typingSoundPath);
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
    progressService.lastProgress = 4;
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
                        rightPerson: 'assets/character/jundohwan.png',
                        statement: '바로 보안사령관 <r>전두환</r>.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/jundohwan.png',
                        statement:
                            '스위스 은행 비밀 계좌 서류들을 보며 대통령의 <r>금고</r>를 뒤져 돈과 금괴를 모조리 자신이 들고 온 더플백에 챙겨서 대통령 집무실을 나가려다',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/jundohwan.png',
                        statement:
                            '그 순간, 아직 불이 켜져 있는 청와대 집무실의 <r>옥좌</r> 책상을 의미심장하게 바라본다.',
                        name: ''),
                  ),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        rightPerson: 'assets/character/jundohwan.png',
                        statement:
                            '이 후, 신 군부 독재가 시행되고, 이는 <r>광주 5.18 민주화 운동</r> 의 시발점이 되게 되는데..',
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
                Get.offNamed('/act1/ending');
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
