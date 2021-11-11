import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ContentSelectListItem extends StatelessWidget {
  final String assetPath;
  final String mainTitle;
  final String subTitle;
  final bool isFree;
  final String content;

  const ContentSelectListItem(
      this.assetPath, this.mainTitle, this.subTitle, this.isFree, this.content,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.toNamed('/act1/intro');
      },
      child: IntrinsicHeight(
        child: Row(
          children: [
            Expanded(
                flex: 2,
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(12),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(assetPath, fit: BoxFit.fitHeight,)))),
            Expanded(
              flex:3,
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.all(12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      mainTitle,style: const TextStyle(color: Colors.black45, fontSize: 14),
                    ),
                    Text(subTitle, style: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                    Text(isFree == true ? '무료' : '유료', style: const TextStyle(color: Colors.black45, fontSize: 14)),
                    Text(content, softWrap: true,style: const TextStyle(color: Colors.black45, fontSize: 14))
                  ]
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}