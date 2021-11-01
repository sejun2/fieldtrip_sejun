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
    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
              flex: 2,
              child: Container(
                  color: Colors.blue,
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.asset(assetPath, fit: BoxFit.fitHeight,)))),
          Expanded(
            flex:3,
            child: Container(
              color: Colors.red,
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    mainTitle,
                  ),
                  Text(subTitle),
                  Text(isFree == true ? '무료' : '유료'),
                  Text(content)
                ]
              )
            ),
          ),
        ],
      ),
    );
  }
}