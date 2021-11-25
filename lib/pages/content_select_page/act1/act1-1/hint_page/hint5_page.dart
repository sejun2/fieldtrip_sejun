import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../constant.dart';

class Hint5Page extends StatefulWidget {
  const Hint5Page({Key? key}) : super(key: key);

  @override
  _Hint5PageState createState() => _Hint5PageState();
}

class _Hint5PageState extends State<Hint5Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/background/questionbackground.png',
              width: Get.width, height: Get.height, fit: BoxFit.fill),
          _buildContent(),
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
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '1. ', style: questionTextStyle),
                  TextSpan(text: '희', style: hintTextStyle),
                  TextSpan(text: '대의 변절자가 된 현 정부의 대통령', style: questionTextStyle)
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '2, 희', style: questionTextStyle),
                  TextSpan(text: '망', style: hintTextStyle),
                  TextSpan(text: '을 짓밟고 지키는 권력욕', style: questionTextStyle)
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '3. 이 책', style: questionTextStyle),
                  TextSpan(text: '은', style: hintTextStyle),
                  TextSpan(
                      text: ' 일본에서 출간된 현 정부의 치부를 고발하는 나의 회고록이며,',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '4. 현 청와', style: questionTextStyle),
                  TextSpan(text: '대', style: hintTextStyle),
                  TextSpan(
                      text: ' 주변에는 탱크가 순찰을 돌며 공포심 조장을 하고 있으며,',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '5. 최측근을 ', style: questionTextStyle),
                  TextSpan(text: '통', style: hintTextStyle),
                  TextSpan(text: '해 스위스 비밀 계좌를 관리하고 있다.', style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '6. 신임 보안사', style: questionTextStyle),
                  TextSpan(text: '령', style: hintTextStyle),
                  TextSpan(
                      text: '관에 의해 나의 회고록 원고가 유출되었지만, 나는.',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '7. 부정 및 비리 등', style: questionTextStyle),
                  TextSpan(text: '을', style: hintTextStyle),
                  TextSpan(text: ' 폭로하기 위해 청문회에 참석하였다.', style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '8. 사람을 남산으로 ', style: questionTextStyle),
                  TextSpan(text: '끌', style: hintTextStyle),
                  TextSpan(
                      text: '고 와 고문을 자행하는 등, 독재자의 모습을 취하고 있다.',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '9. 두번의 임기 후 심지', style: questionTextStyle),
                  TextSpan(text: '어', style: hintTextStyle),
                  TextSpan(
                      text: ' 연임을 위해 3선 개헌을 밀어 붙이고자 하였다.',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '10. 스위스 비밀계좌 관련 ', style: questionTextStyle),
                  TextSpan(text: '내', style: hintTextStyle),
                  TextSpan(
                      text: '용이 상세히 적힌 이 회고록을 작성하였다. 그는.',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '11. 미국 하원에 로비를 한 코', style: questionTextStyle),
                  TextSpan(text: '리', style: hintTextStyle),
                  TextSpan(
                      text: '아게이트 사건을 둘러싼 청문회로 인해 정국이 시끄러운 틈을 타.',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '12. 막강한 권력의 중앙정보부', style: questionTextStyle),
                  TextSpan(text: '는', style: hintTextStyle),
                  TextSpan(
                      text: ' 군사 쿠데타로 시작된 정권의 장기집권을 위한 도구가 되었으며.',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: '13. 최고 권력자를 믿었으나 모든 ', style: questionTextStyle),
                  TextSpan(text: '것', style: hintTextStyle),
                  TextSpan(
                      text: '은 감시당했고, 그는 2인자를 살려두지 않았었다.',
                      style: questionTextStyle),
                ])),
                Align(
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.check_circle_outline,
                      color: Colors.white,
                      size: 35,
                    ),
                  ),
                )
              ].map((e) {
                return Padding(
                  padding: const EdgeInsets.only(left: 12, bottom: 8, right: 12),
                  child: e,
                );
              }).toList(),
            ),
          ),
        ));
  }
}
