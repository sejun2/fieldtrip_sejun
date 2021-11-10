import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';

import '../../../../constant.dart';

class Question2Page extends StatefulWidget {
  const Question2Page({Key? key}) : super(key: key);

  @override
  _Question2PageState createState() => _Question2PageState();
}

class _Question2PageState extends State<Question2Page>
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

  final String questionSoundPath = 'BGM/question_sound.mp3';
  late AudioPlayer _player;

  bool isHintClickable = false;
  final hintList = [
    'Hint.1\n매뉴얼은 해석하지 않아도 인물 확인이 가능합니다.',
    'Hint.2\n영어 문장에서 차이점이 보이는 것들을 조합하세요.',
    'Hint.3\n소문자들을 순서대로 조합하세요.',
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
          if(mounted) {
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
          Get.toNamed('act1/hint2');
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

  @override
  void dispose() {
    hintController.dispose();
    answerController.dispose();
    notAnswerController.dispose();
    answerTextController.dispose();

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
          Positioned(
            child: GestureDetector(
                onTap: () {
                  hintController.forward();
                },
                child: const Icon(
                  Icons.highlight,
                  size: 40,
                  color: Colors.white,
                )),
            right: 20,
            top: 30,
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
                            Text(
                              hintList[_hintIndex],
                              style: statementTextStyle,
                              softWrap: true,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.visible,
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
                  '도청장치 실행 메뉴얼\nUSER\'S GUIDE',
                  style: questionTextStyle,
                ),
                alignment: Alignment.center),
            const Text('THIS DEVICE CAN BE USED IN A jACKET.',
                style: questionTextStyle),
            const Text('IN aDDITION. IT IS mADE SMALL AND CAN Be USED IN',
                style: questionTextStyle),
            const Text(
              "COMBINATION WITH ANY OBJECT.",
              style: questionTextStyle,
            ),
            const Text('PLEAsE USE IT CArEFULLy.', style: questionTextStyle),
            const Align(
              child: Text(
                "도청 매뉴얼에 숨겨져 있는 인물은 누구인가?",
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
            ),
            //정답 입력 위젯
            SizedBox(
              width: Get.width,
              child: TextFormField(
                controller: answerTextController,
                style: const TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent)),
                  suffixIcon: GestureDetector(
                      onTap: () {
                        print('check icon clicked...');
                        checkAnswer();
                      },
                      child: Image.asset(
                        'assets/background/icon_ok.png',
                        width: 34,
                        height: 34,
                      )),
                  fillColor: Colors.black,
                  hintText: '정답을 입력하세요.',
                ),
              ),
            ),
          ].map((e) {
            return Padding(
              padding: const EdgeInsets.only(left: 18, bottom: 8, right: 18),
              child: e,
            );
          }).toList(),
        ));
  }

  void checkAnswer() {
    if (answerTextController.text == 'jamesryu'.trim()) {
      answerController.forward(from: 0.0);
      Timer(const Duration(milliseconds: 600), () {
        _player.stop();
        Get.offNamed('/act1-5');
      });
    } else {
      notAnswerController.forward(from: 0.0);
    }
  }
}
