import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:history_game_project/widgets/content_select_list_item.dart';

import '../../constant.dart';

class ContentSelectPage extends StatefulWidget {
  const ContentSelectPage({Key? key}) : super(key: key);

  @override
  _ContentSelectPageState createState() => _ContentSelectPageState();
}

class _ContentSelectPageState extends State<ContentSelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: defaultPadding,
        child: ListView.separated(
          itemCount: 2,
          itemBuilder: (context, index) {
            switch (index) {
              case 0:
                return const ContentSelectListItem('assets/background/gun.png',
                    'MainTitle', 'subTitle', true, 'content');
              case 1:
                return const ContentSelectListItem('assets/background/gun.png',
                    'MainTitle', 'subTitle', true, 'content');
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
    );
  }
}
