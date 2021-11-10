
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:history_game_project/widgets/title_container_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

class Act1_4Page extends StatefulWidget {
  const Act1_4Page({Key? key}) : super(key: key);

  @override
  _Act1_4PageState createState() => _Act1_4PageState();
}

class _Act1_4PageState extends State<Act1_4Page> with TickerProviderStateMixin {

  late AnimationController backgroundController;
  late Animation backgroundAnimation;

  late AnimationController statementController;
  late Animation statementAnimation;

  late AnimationController titleController;
  late Animation titleAnimation;

  bool isTitleDisappear = false;

  final progressService = Get.put(ProgressService());

  bool _isIgnore = true;

  late AudioPlayer _player;
  final String soundPath = 'BGM/serious_sound.mp3';

  _initResources()async {
    progressService.lastProgress = 1;

   _player= await AudioCache().play(soundPath);

    progressService.isDone.listen((value) {
      if (value) {
        Get.log('isDone : $value');
        if(mounted) {
          setState(() {
            _isIgnore = false;
          });
        }
      }
    });
  }

  _initAnimation() {
    backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    backgroundAnimation =
        CurvedAnimation(parent: backgroundController, curve: Curves.linear);

    titleController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    titleAnimation =
        CurvedAnimation(parent: titleController, curve: Curves.linear);

    statementController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    statementAnimation =
        Tween<double>(begin: 0, end: 0.7).animate(statementController);
    backgroundController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        titleController.forward(from: 0.0);
      }
    });
    titleController.addStatusListener((status) {
      if (status == AnimationStatus.reverse) {
        statementController.forward(from: 0.0);
        progressService.progress.value = 1;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    statementController.dispose();
    backgroundController.dispose();
    titleController.dispose();
  }

  @override
  void initState() {
    _initAnimation();
    _initResources();
    backgroundController.forward(from: 0.0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
              animation: backgroundAnimation,
              builder: (context, widget) {
                return GestureDetector(
                  onTap: () {
                    Get.log('onTap...');
                    if (!isTitleDisappear) {
                      Get.log('isTitleDisappear : $isTitleDisappear');
                      isTitleDisappear = true;
                      titleController.reverse(from: 1.0);
                      statementController.forward(from: 0.0);
                      progressService.progress.value = 1;
                    }
                    if (progressService.isDone.value) {}
                  },
                  child: Opacity(
                      opacity: backgroundAnimation.value,
                      child: Image.asset(
                        'assets/background/informationinstitution.png',
                        width: Get.width,
                        height: Get.height,
                        fit: BoxFit.fill,
                      )),
                );
              }),
          AnimatedBuilder(
            animation: titleAnimation,
            builder: (container, widget) {
              return Positioned(
                right: 0,
                left: 0,
                bottom: 40,
                child: Opacity(
                  opacity: titleAnimation.value,
                  child: const TitleContainerWidget(
                    text: '남산 중앙정보부',
                  ),
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: statementAnimation,
            builder: (BuildContext context, Widget? child) {
              return Positioned(
                bottom: 50,
                child: IgnorePointer(
                  ignoring: !_isIgnore,
                  child: Opacity(
                    opacity: statementAnimation.value,
                    child: Container(
                      width: Get.width,
                      height: Get.height * 2 / 5,
                      padding: const EdgeInsets.all(8),
                      color: Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
          Obx(
            () => ProsteIndexedStack(
                index: progressService.progress.value,
                children: [
                  IndexedStackChild(child: Container()),
                  IndexedStackChild(
                    child: const StatementSceneWidget(
                        statement:
                            '김재규는 수행 비서를 시켜 자신을 도청하던 어떤 대학 교수를 중앙정보부로 끌고 와 심문하게 된다.',
                        name: '나레이션'),
                  ),
                ]),
          ),
          IgnorePointer(
            ignoring: _isIgnore,
            child: GestureDetector(
              onTap: () async {
                  Get.log('clicked...');
                  progressService.resetProgress();
                  await _player.stop();
                  Get.offNamed('/act1/question2');
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
