import 'package:get/get.dart';

class ProgressService extends GetxService{

  RxInt progress = 0.obs;
  int lastProgress = -99;
  var isDone = false.obs;

  init() async{
    Get.log('init progressController...');
    await 2.delay();
    return this;

  }
  incrementProgress() async{
    Get.log('incrementProgress called...');
    Get.log('current lastProcess : $lastProgress');
    if(progress.value == lastProgress){
      isDone.value = true;
      return;
    }
    progress.value++;
  }
  resetProgress() async {
    Get.log('resetProgress called...');
    progress.value = 0;
    lastProgress = -99;
    isDone.value = false;
  }
}

