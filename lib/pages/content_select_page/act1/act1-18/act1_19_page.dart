import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Act1_19Page extends StatefulWidget {
  const Act1_19Page({Key? key}) : super(key: key);

  @override
  _Act1_19PageState createState() => _Act1_19PageState();
}

class _Act1_19PageState extends State<Act1_19Page> {
  bool _isIgnore = true;
  final String _typingSoundPath = 'BGM/typing_sound.mp3';
  late AudioPlayer _player;

  _initResources() async {
    _player = await AudioCache().play(_typingSoundPath);
  }
  @override
  void dispose() {
    super.dispose();
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
        width: Get.width,
        height: Get.height,
        color: Colors.black,
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: AnimatedTextKit(
              isRepeatingAnimation: false,
              animatedTexts: [
                TyperAnimatedText(
                    '김재규는 육군본부에서 체포되어\n대통령 시해 사건의 범인으로\n교수형이 처해졌다.',
                    textStyle:
                        const TextStyle(color: Colors.white, fontSize: 35))
              ],
              onFinished: (){
                setState(() {
                  if(mounted){
                    _isIgnore = false;
                  }
                });
              },
            ),
          ),
          IgnorePointer(
            child: GestureDetector(
              onTap: ()async {
                await _player.stop();
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
