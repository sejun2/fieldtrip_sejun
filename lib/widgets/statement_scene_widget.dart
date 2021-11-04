import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';
import 'package:history_game_project/controllers/base_controller.dart';
import 'package:history_game_project/controllers/progress_controller.dart';

class StatementSceneWidget extends StatefulWidget {
  const StatementSceneWidget({
    Key? key,
    required this.statement,
    required this.name,
    this.leftPerson,
    this.rightPerson,
  }) : super(key: key);

  /**
   * @Property statement 대사
   * @Property name 말하는 사람
   * @Property leftPerson 왼쪽에 표시될 인물 초상화
   * @Property rightPerson 오른쪽에 표시될 인물 초상화
   */

  final String statement;
  final String name;
  final String? leftPerson;
  final String? rightPerson;

  // final BaseController controller;

  @override
  _StatementSceneWidgetState createState() => _StatementSceneWidgetState();
}

class _StatementSceneWidgetState extends State<StatementSceneWidget> {
  final progressService = Get.put(ProgressController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      color: Colors.transparent,
      height: Get.height,
      child: Stack(
        children: [
          ///왼쪽 인물 Widget
          widget.leftPerson != null
              ? Positioned(
                  child: Image.asset(
                    '${widget.leftPerson}',
                    fit: BoxFit.fitHeight,
                    height: (Get.height - Get.height * 2 / 5) * 2 / 5,
                  ),
                  top: 70,
                  left: 60,
                )
              : Container(),

          ///오른쪽 인물 Widget
          widget.rightPerson != null
              ? Positioned(
                  top: 70,
                  right: 60,
                  child: Image.asset(
                    '${widget.rightPerson}',
                    fit: BoxFit.fitHeight,
                    height: (Get.height - Get.height * 2 / 5) * 2 / 5,
                  ))
              : Container(),

          Positioned(
            bottom: 50,
            child: Container(
              width: Get.width,
              height: Get.height * 2 / 5,
              padding: const EdgeInsets.all(8),
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: statementTextStyle,
                  ),
                  AnimatedTextKit(
                    displayFullTextOnTap: true,
                    isRepeatingAnimation: false,
                    onFinished: () {
                      Get.log('onFinished...');
                      progressService.incrementProgress();
                      Get.log('progress : ${progressService.progress.value}');
                    },
                    animatedTexts: [
                      TyperAnimatedText(widget.statement,
                          speed: const Duration(milliseconds: 80),
                          textStyle: statementTextStyle),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
