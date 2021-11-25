import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';

class Act1EndingPage extends StatefulWidget {
  const Act1EndingPage({Key? key}) : super(key: key);

  @override
  _Act1EndingPageState createState() => _Act1EndingPageState();
}

class _Act1EndingPageState extends State<Act1EndingPage> {

  _resetAllResources() async{
    final progressService = Get.find<ProgressService>();
    progressService.resetProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          _resetAllResources();
          Get.offAllNamed('/splash');
        },
        child: Container(
          color: Colors.black,
          width: Get.width,
          height: Get.height,
          child: const Center(
            child: Text('플레이 해주셔서 감사합니다.', style: TextStyle(color: Colors.white, fontSize: 35),),
          ),
        ),
      ),
    );
  }
}
