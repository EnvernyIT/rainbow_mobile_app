import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';

class IconTextField extends StatelessWidget {
  String title;
  String firstWord;
  String? secondWord;
  Widget? widget;
  IconData? icon;
  Color? textColor;
  Color? iconColor;

  IconTextField({
    Key? key,
    required this.title,
    required this.firstWord,
    this.secondWord,
    this.widget,
    this.icon,
    this.textColor,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 7),
            child: Text(
              title + ": ",
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.black, fontSize: 19.0),
            )),
        SizedBox(
          width: 20,
        ),
        Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 7),
            child: Text(
              firstWord,
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.black, fontSize: 19.0),
            )),
        const SizedBox(
          width: 5,
        ),
        Container(
            padding: const EdgeInsets.all(4),
            margin: const EdgeInsets.only(bottom: 7),
            child: Text(
              secondWord ?? "",
              textAlign: TextAlign.left,
              style: TextStyle(color: textColor, fontSize: 19.0),
            ))
      ]),
      icon != null
          ? InkWell(
              radius: 25,
              onTap: () {},
              child: CircleAvatar(
                child: Icon(
                  icon,
                  color: iconColor,
                ),
                backgroundColor: RainbowColor.secondary,
              ))
          : Container(),
    ]);
  }
}
