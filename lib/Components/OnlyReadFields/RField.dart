import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Theme/ThemeTextStyle.dart';

class RField extends StatelessWidget {
  final String title;
  final String content;
  final Color? color;

  const RField({
    required this.title,
    required this.content,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 0),
      height: 80,
      width: 420,
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
            content,
            style: TextStyle(
                color: color ?? Colors.black,
                //Font color
                fontSize: 18,
                //font size on dropdown button
                fontWeight: FontWeight.w500,
                fontFamily: RainbowTextStyle.fontFamily),
          )),
          const SizedBox(
            height: 18,
          ),
          Container(
            color: Colors.grey[200],
            height: 2,
          )
        ],
      ),
    );
  }
}
