import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';

import '../../Theme/ThemeTextStyle.dart';

class InputField extends StatelessWidget {
  final String title;
  final String hint;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? keyboardType;
  final double? width;
  final Color? color;
  const InputField(
      {Key? key,
      required this.title,
      required this.hint,
      this.controller,
      this.widget,
      this.keyboardType,
      this.width,
      this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: RainbowTextStyle.fontFamily),
          ),
          Container(
            height: 52,
            width: width,
            margin: const EdgeInsets.only(top: 8.0, bottom: 10.0),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(
                  color: color ?? RainbowColor.primary_1, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    keyboardType: keyboardType,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontFamily: RainbowTextStyle.fontFamily),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: RainbowTextStyle.fontFamily),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                        width: 0,
                      )),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                        width: 0,
                      )),
                    ),
                  ),
                ),
                widget == null
                    ? Container()
                    : Container(
                        child: widget,
                      )
              ],
            ),
          )
        ],
      ),
    );
  }
}
