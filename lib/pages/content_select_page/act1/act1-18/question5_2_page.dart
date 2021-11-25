import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';

import '../../../../constant.dart';

class Question5_2Page extends StatefulWidget {
  const Question5_2Page({Key? key}) : super(key: key);

  @override
  _Question5_2PageState createState() => _Question5_2PageState();
}

class _Question5_2PageState extends State<Question5_2Page>
    with TickerProviderStateMixin {

  bool _isIgnored = true;
  bool _isIgnored2 = true;
  bool _isIgnored3 = true;
  late TextEditingController answerTextController;

  late AnimationController answerController;
  late Animation answerAnimation;

  late AnimationController notAnswerController;
  late Animation notAnswerAnimation;

  late AnimationController hintController;
  late Animation hintAnimation;
  late AnimationController hint2Controller;
  late Animation hint2Animation;
  late AnimationController hint3Controller;
  late Animation hint3Animation;

  late AudioPlayer _player;
  final String questionSoundPath = 'BGM/question_sound.mp3';

  bool isHintClickable = false;
  bool isHint2Clickable = false;
  bool isHint3Clickable = false;
  final hintList = [
    '1번분제 Hint. 1\n★은 하나의 연산기호가 아닙니다.\n★의 앞/뒤 숫자의 관계를 생각하세요.',
    '1번문제 Hint. 2\n★의 앞 숫자를 포함한 차례대로 연속되는 숫자들을\n뒤 숫자들의 개수만큼 더하는 관계입니다.',
    '1번문제 Hint. 3\n5★2 = 5+6 = 11',
    '1번문제 Hint. 4\n8★4 = ◆ = 38',
  ];

  final hint2List = [
    '2번문제 Hint. 1\n+는 단순히 앞/뒤 숫자를 더하는 연산이 아니라\n 더하기 연산이 포함됨',
    '2번문제 Hint. 2\n앞 자리에는 두 숫자의 차,\n뒤 자리에는 두 숫자의 합',
    '2번문제 Hint. 3\n5 + 1 = (5-1)(5+1) = 45',
    '2번문제 Hint. 4\n7 + 1 = ● = 68'
  ];

  final hint3List = [
    '3번문제 Hint. 1\n각각의 연산을 통해 숫자를 찾아내세요.',
    '3번문제 Hint. 2\n치환법을 이용한 문제입니다.\n1-3+4 = 2, 4-6+9 = 7, 2-6+7 = 3',
    '3번문제 Hint. 3\n2 = 100, 7 = 999, 3 = 879, 3-3+6 = 6, 7-3+2 = 6',
    '3번문제 Hint. 4\n 3 - 3 + 6 = 7 - 3 + 2\n=999 - 879 + 100 = ■ = 220',
  ];
  int _hintIndex = 0;
  int _hint2Index = 0;
  int _hint3Index = 0;

  bool _checkAnswerMutex = true;

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
    hint2Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    hint2Animation =
        CurvedAnimation(parent: hint2Controller, curve: Curves.linear);
    hint3Controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    hint3Animation =
        CurvedAnimation(parent: hint3Controller, curve: Curves.linear);
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
          // _hintIndex = 0;
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

    hint2Animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (_hint2Index != 3) {
          _hint2Index++;
        } else {
          // _hint2Index = 0;
        }
      }
      if (status == AnimationStatus.forward) {
        isHint2Clickable = true;
        setState(() {
          _isIgnored2 = false;
        });
      }
      if (status == AnimationStatus.reverse) {
        isHint2Clickable = false;
        setState(() {
          _isIgnored2 = true;
        });
      }
    });

    hint3Animation.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        if (_hint3Index != 3) {
          _hint3Index++;
        } else {
          // _hint3Index = 0;
        }
      }
      if (status == AnimationStatus.forward) {
        isHint3Clickable = true;
        setState(() {
          _isIgnored3 = false;
        });
      }
      if (status == AnimationStatus.reverse) {
        isHint3Clickable = false;
        setState(() {
          _isIgnored3 = true;
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
    hint2Controller.dispose();
    hint3Controller.dispose();
    // progressService.isDone.close();
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
    return WillPopScope(
      onWillPop: () {return Future(() => false);},
      child: Scaffold(
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/background/questionbackground.png',
                  fit: BoxFit.fill,
                ),
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
              //Hint1 위젯
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
              //Hint2 위젯
              AnimatedBuilder(
                builder: (BuildContext context, Widget? child) {
                  return Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        ignoring: _isIgnored2,
                        child: GestureDetector(
                          onTap: () {
                            if (isHint2Clickable) {
                              hint2Controller.reverse(from: 1.0);
                            }
                          },
                          child: Opacity(
                            opacity: hint2Animation.value,
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
                                  hint2List[_hint2Index],
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
                animation: hint2Animation,
              ),

              //Hint3 위젯
              AnimatedBuilder(
                builder: (BuildContext context, Widget? child) {
                  return Positioned(
                      top: 0,
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        ignoring: _isIgnored3,
                        child: GestureDetector(
                          onTap: () {
                            if (isHint3Clickable) {
                              hint3Controller.reverse(from: 1.0);
                            }
                          },
                          child: Opacity(
                            opacity: hint3Animation.value,
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
                                  hint3List[_hint3Index],
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
                animation: hint3Animation,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
      child: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 50, bottom: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                    child: Text(
                      '금고 문제',
                      style: questionTextStyle,
                    ),
                    alignment: Alignment.center),
                const SizedBox(
                  height: 20,
                ),
                const Align(
                  child: Text('금고의 비번 : ◆ ● ■', style: questionTextStyle),
                  alignment: Alignment.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Wrap(
                  children: [
                    //첫 칼럼
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        const Text(
                          '5 ★ 2 = 11',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '2 ★ 4 = 14',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '3 ★ 2 = 7',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '4 ★ 5 = 30',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '8 ★ 4 = ◆',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        GestureDetector(
                            onTap: () {
                              hintController.forward();
                            },
                            child: Image.asset(
                              'assets/background/icon_hint.png',
                              width: 50,
                            )),
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Container(
                          color: Colors.black,
                          width: 2,
                          height: Get.height * 6 / 7,
                        )
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        const Text(
                          '5 + 1 = 46',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '6 + 4 = 210',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '8 + 7 = 115',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '7 + 1 = ●',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        GestureDetector(
                            onTap: () {
                              hint2Controller.forward();
                            },
                            child: Image.asset(
                              'assets/background/icon_hint.png',
                              width: 50,
                            )),
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        Container(
                          color: Colors.black,
                          width: 2,
                          height: Get.height * 6 / 7,
                        )
                      ],
                    ),
                    Wrap(
                      direction: Axis.vertical,
                      children: [
                        const Text(
                          '1 – 3 + 4 = 100',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '4 – 6 + 9 = 999',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '2 – 6 + 7 = 879',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '3– 3 + 6 = ■',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        const Text(
                          '',
                          style: TextStyle(
                              fontSize: 30, color: Colors.black, height: 2),
                        ),
                        GestureDetector(
                            onTap: () {
                              hint3Controller.forward();
                            },
                            child: Image.asset(
                              'assets/background/icon_hint.png',
                              width: 50,
                            )),
                      ],
                    ),
                  ],
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
                            if (_checkAnswerMutex) {
                              _checkAnswerMutex = false;
                              Future.delayed(const Duration(milliseconds: 2500),
                                  () {
                                _checkAnswerMutex = true;
                              });
                              print('check icon clicked...');
                              checkAnswer();
                            }
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
                  padding:
                      const EdgeInsets.only(left: 45, bottom: 8, right: 45),
                  child: e,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  void checkAnswer() async {
    if (answerTextController.text.replaceAll(' ', '').trim() ==
        '3868220'.trim()) {
      answerController.forward(from: 0.0);
      await _player.stop();
      Timer(const Duration(milliseconds: 600), () {
        Get.offNamed('/act1-21');
      });
    } else {
      notAnswerController.forward(from: 0.0);
    }
  }
}
