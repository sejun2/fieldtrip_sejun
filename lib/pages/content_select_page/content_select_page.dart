import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/services/progress_service.dart';
import 'package:history_game_project/widgets/content_select_list_item.dart';

import '../../constant.dart';

class ContentSelectPage extends StatefulWidget {
  const ContentSelectPage({Key? key}) : super(key: key);

  @override
  _ContentSelectPageState createState() => _ContentSelectPageState();
}

class _ContentSelectPageState extends State<ContentSelectPage> {



  _init() async{
    //Get.reset(clearRouteBindings: true);
    await Get.put(ProgressService()).resetProgress();
  }

  @override
  void initState() {
    _init();
    super.initState();

  }

  @override
  void deactivate() {
    print('deactivate called... content select page');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {return Future(() => false);},
      child: Scaffold(
        body: Container(
          width: Get.width,
          padding: defaultPadding,
          child: ListView.separated(
            itemCount: 1,
            itemBuilder: (context, index) {
              switch (index) {
                case 0:
                  return const ContentSelectListItem('assets/background/gun.png',
                      '전국(온라인)', '그날의 총성', true, '5.18 민주화 운동의 시작이 된 사건을 체험하라.');
                default:
                  return const ContentSelectListItem('assets/background/gun.png',
                      'MainTitle', 'subTitle', true, 'content');
              }
            },
            separatorBuilder: (context, index) {
              return Container(
                height: 1,
                color: Colors.grey,
              );
            },
          ),
        ),
      ),
    );
  }
}
