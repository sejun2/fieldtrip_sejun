import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';
import 'package:history_game_project/services/progress_service.dart';

class Question1Page extends StatefulWidget {
  const Question1Page({Key? key}) : super(key: key);

  @override
  _Question1PageState createState() => _Question1PageState();
}

//TODO: Notification 때문에 클릭영역 문제있음. Notification이 입력 및 확인버튼 클릭 영역 침범
class _Question1PageState extends State<Question1Page>
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

  final questionSoundPath = 'BGM/question_sound.mp3';
  late AudioPlayer _player;

  bool isHintClickable = false;
  final hintList = [
    'Hint.1\n각 문장의 숫자에 주목하세요.',
    'Hint.2\n각 문장의 숫자에 해당하는 n번째 글자에 주목하세요.\n(ex. 1의 첫번째 글자)',
    'Hint.3\n각 문장에서 문장의 숫자에 해당하는 글자를\n 숫자에 맞게 배열하세요.',
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
          Get.toNamed('act1/hint5');
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

  void _stopAudioPlayer() async {
    await _player.stop();
  }

  @override
  void dispose() {
    hintController.dispose();
    answerController.dispose();
    notAnswerController.dispose();
    answerTextController.dispose();
    _stopAudioPlayer();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _initResources();
    _initAnimation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/background/questionbackground.png',
                    fit: BoxFit.fill,
                    width: Get.width,
                    height: Get.height,
                  ),
                ),

            _buildContent(),
            /*   Positioned(
              right: 30,
              bottom: 30,
              child: GestureDetector(
                onTap: () {
                  answerController.forward();
                },
                child: const Icon(
                  Icons.check_circle_outline,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ),*/
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
                                opacity: 0.6,
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
      ),
    );
  }

  Widget _buildContent() {
    return Positioned(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 24, bottom: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('1. 희대의 변절자가 된 현 정부의 대통령', style: questionTextStyle),
                  const Text('2. 희망을 짓밟고 지키는 권력욕', style: questionTextStyle),
                  const Text(
                    "13. 최고 권력자를 믿었으나 모든 것은 감시당했고, 그는 2인자를 살려두지 않았었다.",
                    style: questionTextStyle,
                  ),
                  const Text('3. 이 책은 일본에서 출간된 현 정부의 치부를 고발하는 나의 회고록이며,',
                      style: questionTextStyle),
                  const Text('10. 스위스 비밀계좌 관련 내용이 상세히 적힌 이 회고록을 작성해였다. 그는,',
                      style: questionTextStyle),
                  const Text('5. 최측근을 통해 스위스 비밀 계좌를 관리하고 있다.',
                      style: questionTextStyle),
                  const Text('4. 현 청와대 주변에는 탱크가 순찰을 돌며 공포심 조장을 하고 있으며,',
                      style: questionTextStyle),
                  const Text('8. 사람을 남산으로 끌고 와 고문을 자행하는 등, 독재자의 모습을 취하고 있다.',
                      style: questionTextStyle),
                  const Text('12. 막강한 권력의 중앙정보부는 군사 쿠데타로 시작된 정권의 장기집권을 위한 도구가 되었으며,',
                      style: questionTextStyle),
                  const Text('9. 두번의 임기 후 심지어 연임을 위해 3선 개헌을 밀어 붙이고자 하였다.',
                      style: questionTextStyle),
                  const Text('6. 신임 보안사령관에 의해 나의 회고록 원고가 유출되었지만, 나는,',
                      style: questionTextStyle),
                  const Text('11. 미국 하원에 로비를 한 코리아게이트 사건을 둘러싼 청문회로 인해 정국이 시끄러운 틈을 타,',
                      style: questionTextStyle),
                  const Text(
                    '. 부정 및 비리 등을 폭로하기 위해 청문회에 참석하였다.',
                    style: questionTextStyle,
                  ),
                  const Align(
                    child: Text(
                      "김형욱의 일기에서 숨겨져 있는 메시지를 확인하세요",
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
                    padding: const EdgeInsets.only(left: 45, bottom: 8, right: 45),
                    child: e,
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }

  void checkAnswer() {
    if (answerTextController.text.trim() == '희망은대통령을끌어내리는것') {
      answerController.forward();
      Timer(const Duration(milliseconds: 800), () async {
        await _player.stop();
        Get.offNamed('/act1-2');
      });
    } else {
      notAnswerController.forward();
    }
  }
}
