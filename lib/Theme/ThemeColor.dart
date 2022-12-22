import 'package:flutter/material.dart';

class RainbowColor {
  static int? colorIndex = 0;

  RainbowColor(int index) {
    RainbowColor.colorIndex = index;
  }

  static Color primary_1 = colorIndex == 0
      ? Colors.blueAccent
      : colorIndex == 1
          ? Colors.green
          : Colors.black;

  static Color? variant = colorIndex == 0
      ? Colors.lightBlue[100]
      : colorIndex == 1
          ? Colors.greenAccent
          : Colors.grey;

  static Color primary_2 = colorIndex == 0
      ? Colors.blueAccent
      : colorIndex == 1
          ? Colors.lightGreen
          : Colors.black;

  static Color dark_primary = colorIndex == 0
      ? const Color.fromARGB(255, 5, 102, 182)
      : colorIndex == 1
          ? const Color.fromARGB(255, 98, 177, 8)
          : Colors.black;

  static const Color secondary = Colors.white;

  static const Color hint = Colors.grey;

  static const Color letter = Colors.black;

  static const String fontFamilyPrimary = 'Roboto';
}
