import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_controller.dart';

class Question1Page extends StatefulWidget {
  const Question1Page({Key? key}) : super(key: key);

  @override
  _Question1PageState createState() => _Question1PageState();
}

class _Question1PageState extends State<Question1Page> {

  final progressService = Get.put(ProgressService());

  @override
  void initState() {
    super.initState();
    progressService.resetProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
