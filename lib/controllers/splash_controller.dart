import 'package:get/get.dart';

class SplashController extends GetxController{
  var currentStep = 0;

  incrementCurrentStep() {
    Get.log('incrementCurrentStep...');
    currentStep ++;
    update();
  }
}