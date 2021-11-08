import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/statement_scene_widget.dart';
import 'package:proste_indexed_stack/proste_indexed_stack.dart';

//기본틀로 이 페이지 사용하면 될듯?
class Act1_2Page extends StatefulWidget {
  const Act1_2Page({Key? key}) : super(key: key);

  @override
  _Act1_2PageState createState() => _Act1_2PageState();
}

class _Act1_2PageState extends State<Act1_2Page> with TickerProviderStateMixin {
  late AnimationController backgroundController;
  late Animation backgroundAnimation;

  late AnimationController statementContainerController;
  late Animation statementContainerAnimation;

  final progressService = Get.put(ProgressService());

  double _backgroundOpacity = 0.0;

  void _initResources() {
    progressService.isDone.listen((value) {
      if(value){
      Future.delayed(const Duration(milliseconds: 2500), () async {
       await progressService.resetProgress();
        Get.log('isDone::true...');
        Get.offNamed('/act1-3');
      });}
    });
  }

  void _initAnimation() {
    backgroundController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3));
    backgroundAnimation =
        CurvedAnimation(parent: backgroundController, curve: Curves.linear);

    statementContainerController =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    statementContainerAnimation = Tween<double>(begin: 0, end: 0.7).animate(statementContainerController);

    backgroundAnimation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        progressService.incrementProgress();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    progressService.lastProgress = 1;
    _initAnimation();
    _initResources();
    Timer(const Duration(seconds: 2), () {
      backgroundController.forward(from: 0.0);
      statementContainerController.forward(from: 0.0);
    });
  }

  @override
  void dispose() {
    backgroundController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
            animation: backgroundAnimation,
            builder: (BuildContext context, Widget? child) {
              return Opacity(
                opacity: backgroundAnimation.value,
                child: Image.asset(
                  'assets/background/bluehouse2.png',
                  width: Get.width,
                  height: Get.height,
                  fit: BoxFit.fill,
                ),
              );
            },
          ),
          AnimatedBuilder(
            animation: statementContainerAnimation,
            builder: (BuildContext context, Widget? child) {
              return Positioned(
                bottom: 50,
                child: AnimatedOpacity(
                  duration: const Duration(seconds: 3),
                  opacity: statementContainerAnimation.value,
                  child: Container(
                    width: Get.width,
                    height: Get.height * 2 / 5,
                    padding: const EdgeInsets.all(8),
                    color: Colors.black,
                  ),
                ),
              );
            },
          ),
          Obx(() {
            return ProsteIndexedStack(
              index: progressService.progress.value,
              children: [
                IndexedStackChild(
                  child: Container(),
                ),
                IndexedStackChild(
                    child: const StatementSceneWidget(
                  name: '나레이션',
                  statement: '미국의 소식을 듣게 된 김재규는 대통령을 만나기 위해 청와대로 향한다 .',
                  leftPerson: null,
                  rightPerson: null,
                )),
              ],
            );
          })
        ],
      ),
    );
  }
}
