import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/widgets/custom_animated_text_widget.dart';

class Act1_19Page extends StatefulWidget {
  const Act1_19Page({Key? key}) : super(key: key);

  @override
  _Act1_19PageState createState() => _Act1_19PageState();
}

class _Act1_19PageState extends State<Act1_19Page> {
  bool _isIgnore = true;
  final String _typingSoundPath = 'BGM/typing_sound.mp3';
  late AudioPlayer _player;


  _initResources() async{
    _player = await AudioCache().play(_typingSoundPath);
  }
  @override
  void initState() {
    _initResources();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(children: [
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: CustomAnimatedTextWidget(
                textStyle: TextStyle(color: Colors.white, fontSize: 35),
                  text: '김재규는 육군본부에서 체포되어\n대통령 시해 사건의 범인으로\n교수형이 처해졌다.',
                  onFinished: () {
                    setState(() {
                      _isIgnore = false;
                    });
                  }),
            ),
          ),
          IgnorePointer(
            child: GestureDetector(
              onTap: (){
                _player.stop();
                Get.offNamed('/act1-20');
              },
            ),
            ignoring: _isIgnore,
          )
        ]),
      ),
    );
  }
}
