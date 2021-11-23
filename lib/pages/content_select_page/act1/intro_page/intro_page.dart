import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  _IntroPageState createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  double op1 = 0;
  double op2 = 0;
  double op3 = 0;

  bool _isClickable = false;
  bool _canRun = false;

  late AudioPlayer _player;
  final String _typingSoundPath = 'BGM/typing_sound.mp3';

  late AnimatedTextKit content1;
  var emptyContent = AnimatedTextKit(
      onFinished: () {
        Get.log('onFinished...');
      },
      animatedTexts: [
        TyperAnimatedText('', textStyle: const TextStyle(color: Colors.white))
      ]);

  var _isIgnore = true;

  void _initResources() async {
    content1 = AnimatedTextKit(
      isRepeatingAnimation: false,
      animatedTexts: [
        TyperAnimatedText(
            '1977년부터 1979년까지의 대한민국\n역사를 토대로 제작되었으며,\n1980년 광주 민주화 운동이 일어나게\n된 계기가 된 역사적 사건들을\n시나리오로 각색한 것입니다.',
            textStyle: const TextStyle(color: Colors.white, fontSize: 35))
      ],
      onFinished: () async {
        Get.log('onFinished...');
        setState(() {
          Get.log('setState...');
          if (mounted) {
            Get.log('mounted...');
            _isIgnore = false;
            _isClickable = true;
          }
        });
        //타이핑 소리 멈춤
        await _player.stop();
      },
    );

    Timer(const Duration(seconds: 6), () async {
      _player = (await AudioCache().play(_typingSoundPath));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    _initResources();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        op1 = 1;
      });
    });
    Future.delayed(const Duration(milliseconds: 3500), () {
      setState(() {
        op2 = 1;
      });
    });
    Future.delayed(const Duration(milliseconds: 6500), () {
      setState(() {
        op1 = 0;
        op2 = 0.00001;
        op3 = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          children: [
            AnimatedOpacity(
              opacity: op1,
              duration: const Duration(seconds: 3),
              child: GestureDetector(
                onTap: () {
                  if (_isClickable) {
                    Get.toNamed('/act1');
                  }
                },
                child: Image.asset(
                  'assets/background/gun.png',
                  width: Get.width,
                  height: Get.height,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: AnimatedOpacity(
                onEnd: () async {
                  if (op2 == 0.00001) {
                    setState(() {
                      if (_canRun != true) {
                        _canRun = true;
                      }
                    });
                  }
                },
                duration: const Duration(seconds: 3),
                opacity: op2,
                child: const Text(
                  '그 날의 총성',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: _canRun ? content1 : Container()),
            IgnorePointer(
              ignoring: _isIgnore,
              child: GestureDetector(
                onTap: () {
                  Get.offNamed('/act1');
                },
                child: Container(
                  width: Get.width,
                  height: Get.height,
                  color: Colors.transparent,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
