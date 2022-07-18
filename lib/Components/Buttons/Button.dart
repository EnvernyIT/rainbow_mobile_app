import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';

import '../../Theme/ThemeTextStyle.dart';

class Button extends StatelessWidget {
  final String label;
  final Function()? onTap;
  final double? width;
  const Button({Key? key, required this.label, required this.onTap, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(7),
          alignment: Alignment.center,
          height: 40,
          width: width != null ? width : 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: RainbowColor.primary_1),
          child: Text(
            label,
            style: TextStyle(
                color: RainbowColor.secondary,
                fontSize: 17,
                fontWeight: FontWeight.bold,
                fontFamily: RainbowTextStyle.fontFamily),
          )),
    );
  }
}
