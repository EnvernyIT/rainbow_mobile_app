import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../Theme/ThemeColor.dart';
import '../../Theme/ThemeTextStyle.dart';

class RButtonTextField extends StatelessWidget {
  final String title;
  final String? data;
  final Color? color;
  final double? fontSize;
  final String? buttonTitle;
  final Widget? buttonIcon;
  final Color? buttonColor;
  final double? buttonFontSize;

  const RButtonTextField({
    Key? key,
    required this.title,
    this.data,
    this.color,
    this.fontSize,
    this.buttonTitle,
    this.buttonIcon,
    this.buttonColor,
    this.buttonFontSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
        Row(children: [
          Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(bottom: 7),
              child: Text(
                (data ?? ""),
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: fontSize,
                    fontFamily: RainbowTextStyle.fontFamily),
              )),
          Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 7, left: 5),
            child: buttonIcon != null
                ? TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      backgroundColor: RainbowColor.primary_1,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {},
                    icon: buttonIcon!,
                    label: Text(
                      buttonTitle!,
                      style: TextStyle(
                          color: RainbowColor.secondary,
                          fontFamily: RainbowTextStyle.fontFamily,
                          fontSize: buttonFontSize,
                          height: 1,
                          fontWeight: FontWeight.w600),
                    ))
                : TextButton(
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(left: 12, right: 12),
                      backgroundColor: RainbowColor.primary_1,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () {},
                    child: Text(
                      buttonTitle ?? "Button",
                      style: TextStyle(
                          color: RainbowColor.secondary,
                          fontFamily: RainbowTextStyle.fontFamily,
                          fontSize: buttonFontSize,
                          height: 1,
                          fontWeight: FontWeight.w600),
                    )),
          ),
        ])
      ],
    );
  }
}
