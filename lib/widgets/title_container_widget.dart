import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/constant.dart';

class TitleContainerWidget extends StatelessWidget {
  const TitleContainerWidget({Key? key, required this.text}) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      width: Get.width / 2,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: chapterTextStyle,
      ),
    );
  }
}
