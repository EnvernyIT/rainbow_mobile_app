import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';

import '../../Theme/ThemeTextStyle.dart';

class MultiLineInputField extends StatelessWidget {
  final String title;
  final TextEditingController? controller;
  final Widget? widget;
  final double? width;

  const MultiLineInputField(
      {Key? key,
      required this.title,
      this.controller,
      this.widget,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        LayoutBuilder(builder: ((context, constraints) {
          return Container(
            margin: const EdgeInsets.only(top: 8.0, bottom: 10.0),
            padding: const EdgeInsets.only(left: 14),
            width: width ?? 350,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(4, 8),
                )
              ],
            ),
            child: SizedBox(
              height: 130,
              child: TextField(
                expands: true,
                maxLines: null,
                autofocus: false,
                controller: controller,
                textAlign: TextAlign.start,
                textAlignVertical: TextAlignVertical.top,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                    fontFamily: RainbowTextStyle.fontFamily),
                decoration: InputDecoration(
                  hintText: title,
                  hintStyle: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[500],
                      fontFamily: RainbowTextStyle.fontFamily),
                  border: InputBorder.none,
                ),
              ),
            ),
          );
        }))
      ],
    );
  }
}
