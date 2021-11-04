import 'package:animated_text_kit/animated_text_kit.dart';
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

  var content1 = AnimatedTextKit(
    isRepeatingAnimation: false,
    animatedTexts: [
      TyperAnimatedText(
          '1977년부터 1979년까지의 대한민국\n역사를 토대로 제작되었으며,\n1980년 광주 민주화 운동이 일어나게\n된 계기가 된 역사적 사건들을\n시나리오로 각색한 것입니다.',
          textStyle: const TextStyle(color: Colors.white, fontSize: 35))
    ],
    onFinished: () {
      Get.log('onFinished...');
    },
  );
  var emptyContent = AnimatedTextKit(
      onFinished: () {
        Get.log('onFinished...');
      },
      animatedTexts: [
        TyperAnimatedText('', textStyle: const TextStyle(color: Colors.white))
      ]);

  @override
  void initState() {
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
        _isClickable = true;
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
                ),
              ),
            ),
            Positioned(
              bottom: 40,
              right: 40,
              child: AnimatedOpacity(
                onEnd: () {
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
                  '그 날의\n총성',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 45,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.center,
                child: _canRun ? content1 : Container())
          ],
        ),
      ),
    );
  }
}
