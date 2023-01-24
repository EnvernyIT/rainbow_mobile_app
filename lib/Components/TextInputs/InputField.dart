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
  final TextAlign? textAlign;

  const InputField({
    Key? key,
    required this.title,
    required this.hint,
    this.controller,
    this.widget,
    this.keyboardType,
    this.width,
    this.color,
    this.textAlign,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 3.0),
      child: Container(
          height: 40,
          // width: width,
          margin: const EdgeInsets.only(
              top: 5.0, bottom: 15.0, left: 15.0, right: 10),
          // padding: const EdgeInsets.only(left: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            textDirection: TextDirection.ltr,
            children: [
              Text(
                title,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                    fontFamily: RainbowTextStyle.fontFamily),
              ),
              SizedBox(
                  width: 260,
                  child: Row(children: [
                    Expanded(
                      child: TextFormField(
                        keyboardType: keyboardType,
                        readOnly: widget == null ? false : true,
                        autofocus: false,
                        controller: controller,
                        textAlign: textAlign ?? TextAlign.start,
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                            fontStyle: FontStyle.italic,
                            fontFamily: RainbowTextStyle.fontFamily),
                        decoration: InputDecoration(
                          hintText: hint,
                          hintStyle: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w400,
                              color: Colors.black,
                              fontFamily: RainbowTextStyle.fontFamily),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: RainbowColor.primary_1,
                            width: 1,
                          )),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                            color: RainbowColor.primary_1,
                            width: 1,
                          )),
                        ),
                      ),
                    ),
                    widget == null
                        ? Container()
                        : Container(
                            child: widget,
                          )
                  ]))
            ],
            // ),
          )),
    );
  }
}
