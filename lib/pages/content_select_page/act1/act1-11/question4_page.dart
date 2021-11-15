import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';

import '../../../../constant.dart';

class Question4Page extends StatefulWidget {
  const Question4Page({Key? key}) : super(key: key);

  @override
  _Question4PageState createState() => _Question4PageState();
}

class _Question4PageState extends State<Question4Page>
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
          Positioned.fill(
            child: Image.asset(
              'assets/background/questionbackground.png',
              width: Get.width,
              height: Get.height,
              fit: BoxFit.fill,
            ),
          ),
          Positioned(
            child: GestureDetector(
              onTap: () {
                hintController.forward();
              },
              child: Image.asset('assets/background/icon_hint.png', width: 60, fit: BoxFit.fitWidth,),
            ),
            right: 50,
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
                                if(_hintIndex == 2)
                                Image.asset('assets/background/hint3.png', width: 90, height: 90, fit: BoxFit.fitHeight,),
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                    child: Text(
                      '밀실 잠입',
                      style: questionTextStyle,
                    ),
                    alignment: Alignment.center),
                const SizedBox(
                  height: 12,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Wrap(
                    alignment: WrapAlignment.center,
                    children: [
                      Image.asset('assets/background/hint15.png', width: 40, height:40 , fit: BoxFit.fitWidth,),
                      Image.asset('assets/background/hint24.png', width: 40, height:40 , fit: BoxFit.fitWidth,),
                      Image.asset('assets/background/hint33.png', width:40 , height:40 , fit: BoxFit.fitWidth,),
                      Image.asset('assets/background/hint24.png', width:40 , height:40 , fit: BoxFit.fitWidth,),
                      Image.asset('assets/background/hint15.png', width:40 , height:40 , fit: BoxFit.fitWidth,),
                      Image.asset('assets/background/hint6.png', width:40 , height:40 , fit: BoxFit.fitWidth,),
                      Image.asset('assets/background/hint7.png', width:40 , height:40 , fit: BoxFit.fitWidth,),
                      Image.asset('assets/background/hint8.png', width:40 , height:40 , fit: BoxFit.fitWidth,),
                    ].map((e) => Padding(padding: const EdgeInsets.all(8), child: e,)).toList(),
                  ),
                ),
                const Align(
                    child: Text(
                      '밀실에 잠입하기 위한 비밀번호는 무엇인가?',
                      style: questionTextStyle,
                    ),
                    alignment: Alignment.center),
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
                  padding: const EdgeInsets.only(left: 45, bottom: 8, right: 45),
                  child: e,
                );
              }).toList(),
            ),
          ),
        ));
  }

  void checkAnswer() {
    if (answerTextController.text.replaceAll(' ', '').trim() == '19791526'.trim()) {
      answerController.forward(from: 0.0);
      Timer(const Duration(milliseconds: 600), () async {
        await _player.stop();
        Get.offNamed('/act1-12');
      });
    } else {
      notAnswerController.forward(from: 0.0);
    }
  }
}
