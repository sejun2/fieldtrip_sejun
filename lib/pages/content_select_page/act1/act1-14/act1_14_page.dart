import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../constant.dart';

class Act1_14Page extends StatefulWidget {
  const Act1_14Page({Key? key}) : super(key: key);

  @override
  _Act1_14PageState createState() => _Act1_14PageState();
}

class _Act1_14PageState extends State<Act1_14Page> {

  double _chapterOpacity = 0;
  final _chapterSoundPath = 'BGM/chapter_sound.mp3';
  late AudioPlayer _chapterPlayer;

  void _initResources() async{
    _chapterPlayer = await AudioCache().play(_chapterSoundPath);
      setState(() {
        _chapterOpacity =1.0;
      });
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
        child:   //chapter 화면
        AnimatedOpacity(
          opacity: _chapterOpacity,
          duration: const Duration(seconds: 2),
          child: GestureDetector(
            onTap: () async {
              setState(() {
                _chapterOpacity = 0.0;
              });
              await _chapterPlayer.stop();
              Timer(const Duration(seconds: 2), () async {
                await _chapterPlayer.stop();
                Get.offNamed('/act1-15');
              });
            },
            child: Container(
              width: Get.width,
              height: Get.height,
              color: Colors.black,
              child: const Center(
                child: Text(
                  'CHAPTER. 2\n그날 밤,',
                  style: chapterTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
