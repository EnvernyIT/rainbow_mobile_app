import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../Theme/ThemeTextStyle.dart';

class RTextField extends StatelessWidget {
  final String title;
  final String? data_1;
  final String? data_2;
  final String? data_3;
  final Color? color_1;
  final Color? color_2;
  final Color? color_3;
  final double? fontSize;
  final MainAxisAlignment? mainAxisAlignment;

  const RTextField({
    Key? key,
    required this.title,
    this.data_1,
    this.data_2,
    this.data_3,
    this.color_1,
    this.color_2,
    this.color_3,
    this.fontSize,
    this.mainAxisAlignment,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
      children: [
        Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 7),
            child: Text(
              title + ": ",
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: Colors.black,
                  fontSize: fontSize,
                  fontFamily: RainbowTextStyle.fontFamily),
            )),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: [
          Container(
              margin: const EdgeInsets.only(bottom: 7, left: 5),
              child: Text(
                data_1 ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: color_1 ?? Colors.black,
                    fontSize: fontSize,
                    fontFamily: RainbowTextStyle.fontFamily),
              )),
          const SizedBox(
            width: 3,
          ),
          Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: Text(
                data_2 ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: color_2 ?? Colors.black,
                    fontSize: fontSize,
                    fontFamily: RainbowTextStyle.fontFamily),
              )),
          Container(
              margin: const EdgeInsets.only(bottom: 7),
              child: Text(
                data_3 ?? "",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: color_3 ?? Colors.black,
                    fontSize: fontSize,
                    fontFamily: RainbowTextStyle.fontFamily),
              )),
        ])
      ],
    );
  }
}
