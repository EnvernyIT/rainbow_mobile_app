import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Theme/ThemeTextStyle.dart';

class RField extends StatelessWidget {
  final String title;
  final String content;
  final String? content_2;
  final Color? color;
  final double? lineWidth;
  final double? bottomSpace;
  final double? height;

  const RField({
    super.key,
    required this.title,
    required this.content,
    this.color,
    this.lineWidth,
    this.bottomSpace,
    this.content_2, this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
      height: height ?? 80,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.grey[500],
                //Font color
                fontSize: 16,
                //font size on dropdown button
                fontWeight: FontWeight.w500,
                fontFamily: RainbowTextStyle.fontFamily),
          ),
          const SizedBox(
            height: 4,
          ),
          Flexible(
              child: Text(
            content + " " + (content_2 ?? ""),
            style: TextStyle(
                color: color ?? Colors.black,
                //Font color
                fontSize: 18,
                //font size on dropdown button
                fontWeight: FontWeight.w500,
                fontFamily: RainbowTextStyle.fontFamily),
          )),
          SizedBox(
            height: bottomSpace ?? 18,
          ),
          Container(
            color: Colors.grey[200],
            height: lineWidth ?? 2,
          )
        ],
      ),
    );
  }
}
