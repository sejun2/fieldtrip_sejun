import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constant.dart';

class Hint4Page extends StatelessWidget {
  Hint4Page({Key? key}) : super(key: key);

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {return Future(() => false);},
      child: Scaffold(
        body: Stack(
          children: [
            Image.asset(
              'assets/background/questionbackground.png',
              width: Get.width,
              height: Get.height,
              fit: BoxFit.fill,
            ),
            _buildContent(),
          ],
        ),
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
                    children: [
                      Image.asset(
                        'assets/background/hint15.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                        'assets/background/hint24.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                        'assets/background/hint33.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                        'assets/background/hint24.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                        'assets/background/hint15.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                        'assets/background/hint6.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                        'assets/background/hint7.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                      Image.asset(
                        'assets/background/hint8.png',
                        width: 40,
                        height: 40,
                        fit: BoxFit.fitWidth,
                      ),
                    ]
                        .map((e) => Padding(
                              padding: const EdgeInsets.all(8),
                              child: Stack(
                                children: [
                                  e,
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8),
                                    child: Text(
                                      '${getNumber(index++)}',
                                      style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                    ),
                                  )
                                ],
                              ),
                            ))
                        .toList(),
                  ),
                ),
                Align(
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: Image.asset(
                      'assets/background/icon_ok.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
                //정답 입력 위젯
              ].map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 18, bottom: 8, right: 18),
                  child: e,
                );
              }).toList(),
            ),
          ),
        ));
  }

  int getNumber(int num) {
    var result = 0;

    switch (num) {
      case 0:
        result = 1;
        break;
      case 1:
        result =  9;
        break;
      case 2:
        result =7;
        break;
      case 3:
        result =9;
        break;
      case 4:
        result =1;
        break;
      case 5:
        result =5;
        break;
      case 6:
        result= 2;
        break;
      case 7:
        result = 6;
        break;
      default : return 0;
    }
    return result;
  }
}
