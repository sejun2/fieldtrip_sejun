import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/custom_animated_text_widget.dart';

/// 대사 및 인물 사진 위젯
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
  final progressService = Get.put(ProgressService());

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
                    height: (Get.height - Get.height * 2 / 5) *3/5 ,
                    width: (Get.width) * 2/5,
                  ),
                  left: 20,
            bottom: Get.height* 5 / 7 - 65,
                )
              : Container(),

          ///오른쪽 인물 Widget
          widget.rightPerson != null
              ? Positioned(
              bottom: Get.height* 5 / 7 - 65,
              right: 20,
                  child: Image.asset(
                    '${widget.rightPerson}',
                    width: Get.width * 2/5,
                    fit: BoxFit.fitHeight,
                    height: (Get.height - Get.height * 2 / 5)*3/5 ,
                  ))
              : Container(),

          Positioned(
            top: Get.height * 3/ 7,
            child: Container(
              padding: const EdgeInsets.only(top: 14, right: 8, left: 8, bottom: 8),
              width: Get.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.name,
                    style: statementTextStyle,
                  ),
                  CustomAnimatedTextWidget(
                      text: widget.statement,
                      onFinished: () {
                        Get.log('onFinished...');
                        progressService.incrementProgress();
                        Get.log('progress : ${progressService.progress.value}');
                      }),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
