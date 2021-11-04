import 'dart:async';

import 'package:flutter/material.dart';
import 'package:history_game_project/constant.dart';

class CustomAnimatedTextWidget extends StatefulWidget {
  CustomAnimatedTextWidget(
      {Key? key,
      required this.text,
      this.intervalDuration = const Duration(milliseconds: 1000 * 6),
      this.textStyle = statementTextStyle,
      required this.onFinished})
      : super(key: key);

  final String text;
  final TextStyle textStyle;
  final OnAnimatedTextFinished onFinished;
  late Duration intervalDuration;
  late Duration originIntervalDuration;

  @override
  _CustomAnimatedTextWidgetState createState() =>
      _CustomAnimatedTextWidgetState();
}

class _CustomAnimatedTextWidgetState extends State<CustomAnimatedTextWidget>
    with TickerProviderStateMixin {
  late Animation _textAnimation;
  late AnimationController _textAnimationController;
  bool isDone = false;
  late Duration interval;
  late Duration fastDuration;
  @override
  void initState() {
    super.initState();
    int res = widget.text.length * 100;
    widget.intervalDuration = Duration(milliseconds: res);
    widget.originIntervalDuration = widget.intervalDuration;
    fastDuration = Duration(milliseconds: res~/3);
    _textAnimationController =
        AnimationController(duration: widget.intervalDuration, vsync: this);
    setState(() {
      _textAnimation = StepTween(begin: 0, end: widget.text.length).animate(
          CurvedAnimation(
              parent: _textAnimationController, curve: Curves.linear));
    });
    _textAnimation.addStatusListener((status) {
      print('textAnimationStatus : $status');
      if (status == AnimationStatus.completed) {
        Timer(const Duration(milliseconds: 1500), () {
          print('function called...');
          widget.onFinished.call();
        });
      }
    });
    print('${widget.text}, ${widget.intervalDuration}');

    _runAnimation();
  }

  _runAnimation() async {
    await _textAnimationController.forward();
  }
@override
  void dispose() {
    _textAnimationController.dispose();
    super.dispose();
  }
  @override
  void didChangeDependencies() {
    print('didChangeDependencies called...');
  }

  //TODO : 1. Tap 할 경우 문자 전부 표시 2. LongPress 할 경우 문자가 나타나는 속도 빠르게 -> intervalDuration 조절 필요

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      builder: (context, child) {
        String currentText = widget.text.substring(0, _textAnimation.value);

        return GestureDetector(
          onTap: () {
            print('onTap called...');
            _textAnimationController.value = widget.text.length as double;
          },
          onLongPress: () {
            print('onLongPress called...');
            _textAnimationController.duration =
                Duration(milliseconds: fastDuration.inMilliseconds);
            if (_textAnimationController.isAnimating) {
              _textAnimationController.forward();
            }
          },
          onLongPressEnd: (_) {
            print('onLongPressEnd called...');
            _textAnimationController.duration = widget.originIntervalDuration;
            if (_textAnimationController.isAnimating) {
              _textAnimationController.forward();
            }
          },
          child: Text(
            currentText,
            style: widget.textStyle,
          ),
        );
      },
      animation: _textAnimation,
    );
  }
}
