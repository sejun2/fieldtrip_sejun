import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../constant.dart';

class Hint2Page extends StatelessWidget {
  const Hint2Page({Key? key}) : super(key: key);

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
                const Align(
                    child: Text(
                      '도청장치 실행 메뉴얼\nUSER\'S GUIDE',
                      style: questionTextStyle,
                    ),
                    alignment: Alignment.center),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: 'THIS DEVICE CAN BE USED IN A ',
                      style: questionTextStyle),
                  TextSpan(text: 'j', style: hintTextStyle),
                  TextSpan(text: 'ACKET.', style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: 'IN ', style: questionTextStyle),
                  TextSpan(text: 'a', style: hintTextStyle),
                  TextSpan(text: 'DDITION, IT IS .', style: questionTextStyle),
                  TextSpan(text: 'm', style: hintTextStyle),
                  TextSpan(text: 'ADE SMALL AND CAN B', style: questionTextStyle),
                  TextSpan(text: 'e', style: hintTextStyle),
                  TextSpan(text: ' USED IN', style: questionTextStyle)
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(
                      text: 'COMBINATION WITH ANY OBJECT.',
                      style: questionTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: 'PLEA', style: questionTextStyle),
                  TextSpan(text: 's', style: hintTextStyle),
                  TextSpan(text: 'E USE IT CA', style: questionTextStyle),
                  TextSpan(text: 'r', style: hintTextStyle),
                  TextSpan(text: 'EFULL', style: questionTextStyle),
                  TextSpan(text: 'y', style: hintTextStyle),
                ])),
                RichText(
                    text: const TextSpan(children: [
                  TextSpan(text: 'RECORDING TIME IS ', style: questionTextStyle),
                  TextSpan(text: 'u', style: hintTextStyle),
                  TextSpan(text: 'P TO 24 HOURS.', style: questionTextStyle),
                ])),
                Align(
                  child: GestureDetector(
                    onTap: (){
                      Get.back();
                    },
                    child: Image.asset(
                      'assets/background/icon_ok.png',
                      width: 50,
                      height: 50,
                    ),
                  ),
                ),
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
