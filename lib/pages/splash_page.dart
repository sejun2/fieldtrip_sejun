import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/controllers/splash_controller.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = Get.put(SplashController());

  void doAnimationWork() {
    controller.currentStep = 0;
    Timer.periodic(const Duration(milliseconds: 300), (t) {
      controller.incrementCurrentStep();
      Get.log('${controller.currentStep}');
      if (controller.currentStep == 8) {
        t.cancel();
      }
    });
  }

  @override
  void initState() {
    doAnimationWork();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: _buildAndroid(),
        onWillPop: () {
          return Future(() => false);
        });
  }

  Container _buildAndroid() {
    return Container(
      color: Colors.white,
      width: Get.width,
      height: Get.height,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(child: LayoutBuilder(
            builder: (context, constraints) {
              return Image.asset('assets/background/startbackground.png',
                  width: constraints.maxWidth, fit: BoxFit.fill);
            },
          )),
          Positioned(
            child: Padding(
              padding: const EdgeInsets.only(left: 28),
              child: Image.asset(
                'assets/background/logo.png',
                width: Get.width / 4,
              ),
            ),
            top: Get.height * 1 / 11,
          ),
          Positioned(
              bottom: Get.height / 5,
              child: const TextButton(
                onPressed: null,
                child: Text(
                  'TechOh',
                  style: TextStyle(color: Colors.brown),
                ),
              )),
          Positioned(
              bottom: Get.height / 3,
              child: GetBuilder<SplashController>(
                builder: (controller) {
                  ///Show only play icon for fast testing
                  if (controller.currentStep != 8) {
                    return CircularStepProgressIndicator(
                      totalSteps: 8,
                      currentStep: controller.currentStep,
                      width: 35,
                      height: 35,
                      selectedColor: Colors.brown,
                      unselectedColor: const Color.fromRGBO(216, 136, 30, 0.4),
                    );
                  } else {
                    return GestureDetector(
                        onTap: () {
                          Get.offNamed('/select');
                        },
                        child: const Icon(
                          Icons.play_circle_filled_rounded,
                          size: 45,
                          color: Colors.brown,
                        ));
                  }
                },
              )),
        ],
      ),
    );
  }
}
