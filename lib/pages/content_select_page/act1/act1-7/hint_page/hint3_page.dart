import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constant.dart';

class Hint3Page extends StatelessWidget {
  const Hint3Page({Key? key}) : super(key: key);

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
                Align(
                    child: RichText(
                      text: const TextSpan(children: [
                        TextSpan(text: '수지 박 톰슨 포섭', style: TextStyle(color: Colors.black,fontSize: 35 )),
                        TextSpan(
                          text: '2486 = ',
                          style: questionTextStyle,
                        ),
                        TextSpan(
                          text: 'ㅇ\n',
                          style: hintTextStyle,
                        ),
                        TextSpan(
                          text: '7894163 = ',
                          style: questionTextStyle,
                        ),
                        TextSpan(
                          text: 'ㅠ\n',
                          style: hintTextStyle,
                        ),
                        TextSpan(
                          text: '2486 = ',
                          style: questionTextStyle,
                        ),
                        TextSpan(
                          text: 'ㅇ\n',
                          style: hintTextStyle,
                        ),
                        TextSpan(
                          text: '963 = ',
                          style: questionTextStyle,
                        ),
                        TextSpan(
                          text: 'ㅣ\n',
                          style: hintTextStyle,
                        ),
                        TextSpan(
                          text: '74123 = ',
                          style: questionTextStyle,
                        ),
                        TextSpan(
                          text: 'ㄴ\n',
                          style: hintTextStyle,
                        ),
                      ]),
                    ),
                    alignment: Alignment.center),
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
}
