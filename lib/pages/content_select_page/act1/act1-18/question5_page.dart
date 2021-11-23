import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';

import '../../../../constant.dart';

class Question5Page extends StatefulWidget {
  const Question5Page({key}) : super(key: key);

  @override
  _Question5PageState createState() => _Question5PageState();
}

class _Question5PageState extends State<Question5Page>
    with TickerProviderStateMixin {
  final progressService = Get.put<ProgressService>(ProgressService());

  bool _isIgnored = true;

  late TextEditingController answerTextController;

  late AnimationController answerController;
  late Animation answerAnimation;

  late AnimationController notAnswerController;
  late Animation notAnswerAnimation;

  late AnimationController hintController;
  late Animation hintAnimation;

  late AudioPlayer _player;
  final String questionSoundPath = 'BGM/question_sound.mp3';

  bool isHintClickable = false;
  final hintList = [
    'Hint.1\n숫자 키 패드',
    'Hint.2\n숫자 키 패드의 1~9 테두리 선 내에 존재하는 숫자를 확인',
    'Hint.3\n',
    'Hint.4\n정답 확인'
  ];
  int _hintIndex = 0;

  _initResources() async {
    answerTextController = TextEditingController();
    _player = await AudioCache().play(questionSoundPath);
  }

  _initAnimation() {
    answerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    answerAnimation =
        CurvedAnimation(parent: answerController, curve: Curves.linear);

    notAnswerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));
    notAnswerAnimation =
        CurvedAnimation(parent: notAnswerController, curve: Curves.linear);

    hintController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    hintAnimation =
        CurvedAnimation(parent: hintController, curve: Curves.linear);

    notAnswerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Timer(const Duration(milliseconds: 600), () {
          notAnswerController.reverse(from: 1.0);
          setState(() {
            _isIgnored = false;
          });
        });
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _isIgnored = true;
        });
      }
    });
    answerController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        answerController.reverse(from: 1.0);
        if (mounted) {
          setState(() {
            _isIgnored = false;
          });
        }
      }
      if (status == AnimationStatus.dismissed) {
        setState(() {
          _isIgnored = true;
        });
      }
    });
    hintAnimation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (_hintIndex != 3) {
          _hintIndex++;
        } else {
          Get.toNamed('act1/hint4');
        }
      }
      if (status == AnimationStatus.forward) {
        isHintClickable = true;
        setState(() {
          _isIgnored = false;
        });
      }
      if (status == AnimationStatus.reverse) {
        isHintClickable = false;
        setState(() {
          _isIgnored = true;
        });
      }
    });
  }

  releaseResources() async {
    await _player.stop();
  }

  @override
  void dispose() {
    releaseResources();
    hintController.dispose();
    answerController.dispose();
    notAnswerController.dispose();
    answerTextController.dispose();
    progressService.isDone.close();
    super.dispose();
  }

  @override
  void initState() {
    _initResources();
    _initAnimation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/background/questionbackground.png',
            width: Get.width,
            height: Get.height,
            fit: BoxFit.fill,
          ),

          _buildContent(),
          //정답입니다 위젯
          AnimatedBuilder(
            builder: (BuildContext context, Widget? child) {
              return Positioned(
                  top: 0,
                  bottom: 0,
                  child: IgnorePointer(
                    ignoring: _isIgnored,
                    child: Opacity(
                      opacity: answerAnimation.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: Container(
                              color: Colors.black,
                              width: Get.width,
                              height: Get.height * 2 / 5,
                            ),
                          ),
                          const Text(
                            '정답입니다.',
                            style: statementTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            animation: answerAnimation,
          ),
          //정답이 아닙니다 위젯
          AnimatedBuilder(
            builder: (BuildContext context, Widget? child) {
              return Positioned(
                  top: 0,
                  bottom: 0,
                  child: IgnorePointer(
                    ignoring: _isIgnored,
                    child: Opacity(
                      opacity: notAnswerAnimation.value,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Opacity(
                            opacity: 0.6,
                            child: Container(
                              color: Colors.black,
                              width: Get.width,
                              height: Get.height * 2 / 5,
                            ),
                          ),
                          const Text(
                            '정답이 아닙니다.',
                            style: statementTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ));
            },
            animation: notAnswerAnimation,
          ),
          //Hint 위젯
          AnimatedBuilder(
            builder: (BuildContext context, Widget? child) {
              return Positioned(
                  top: 0,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: IgnorePointer(
                    ignoring: _isIgnored,
                    child: GestureDetector(
                      onTap: () {
                        if (isHintClickable) {
                          hintController.reverse(from: 1.0);
                        }
                      },
                      child: Opacity(
                        opacity: hintAnimation.value,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Opacity(
                              opacity: 0.7,
                              child: Container(
                                color: Colors.black,
                                width: Get.width,
                                height: Get.height * 2 / 5,
                              ),
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  hintList[_hintIndex],
                                  style: statementTextStyle,
                                  softWrap: true,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.visible,
                                ),
                                if (_hintIndex == 2)
                                  Image.asset(
                                    'assets/background/hint3.png',
                                    width: 130,
                                    height: 130,
                                    fit: BoxFit.fitHeight,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
            animation: hintAnimation,
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      left: 0,
      right: 0,
      top: 0,
      bottom: 0,
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Align(
                child: Text(
                  '금고 문',
                  style: questionTextStyle,
                ),
                alignment: Alignment.center),
            const SizedBox(
              height: 25,
            ),
            const Align(
                child: Text(
                  '금고에는 실탄과 권총이 들어있어 복잡한 암호로 잠겨있다.',
                  style: questionTextStyle,
                ),
                alignment: Alignment.centerLeft),
            const SizedBox(
              height: 25,
            ),
            const Align(
                child: Text(
                  '금고의 비번 : ◆ ● ■',
                  style: questionTextStyle,
                ),
                alignment: Alignment.centerLeft),
            const SizedBox(
              height: 25,
            ),
            const Align(
                child: Text(
                  '총 3개의 문제를 통해 금고의 비밀번호를 획득하세요.',
                  style: questionTextStyle,
                ),
                alignment: Alignment.centerLeft),
            const SizedBox(
              height: 25,
            ),
            Align(
              child: GestureDetector(
                  onTap: () {
                    Get.offNamed('act1/question5_2');
                  },
                  child: Image.asset(
                    'assets/background/icon_ok.png',
                    width: 45,
                    alignment: Alignment.center,
                  )),
              alignment: Alignment.center,
            )
          ]
              .map((e) => Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: e,
                  ))
              .toList()),
    );
  }
}
