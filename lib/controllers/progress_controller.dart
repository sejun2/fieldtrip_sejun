import 'package:get/get.dart';

class ProgressController extends GetxService{
  init() async{
    Get.log('init progressController...');
    await 2.delay();
    return this;
  }

  RxInt progress = 0.obs;
  int lastProgress = -99;
  var isDone = false.obs;

  void incrementProgress(){
    if(progress.value == lastProgress){
      isDone.value = true;
      return;
    }
    progress.value++;
  }
  void resetProgress(){
    progress.value = 0;
    lastProgress = -99;
    isDone.value = false;
  }
}