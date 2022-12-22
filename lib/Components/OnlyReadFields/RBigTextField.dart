import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';

import '../../Theme/ThemeTextStyle.dart';

class RBigTextField extends StatelessWidget {
  final String title;
  final String? data;
  final Color? color;
  final double? fontSize;

  const RBigTextField({
    Key? key,
    required this.title,
    this.data,
    this.color,
    this.fontSize,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
        spacing: 5.0,
        runSpacing: 5.0,
        direction: Axis.vertical, // main axis (rows or columns)
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
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
              Column(children: [
                Container(
                    padding: const EdgeInsets.all(4),
                    margin: const EdgeInsets.only(bottom: 7, left: 5),
                    child: SizedBox(
                        height: 200,
                        width: 250,
                        child: Text(
                          data ?? "",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              color: color ?? Colors.black,
                              fontSize: fontSize,
                              fontFamily: RainbowTextStyle.fontFamily),
                          maxLines: null,
                          // overflow: TextOverflow.ellipsis,
                        ))),
              ])
            ],
          )
        ]);
  }
}
