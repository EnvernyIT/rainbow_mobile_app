import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../Theme/ThemeTextStyle.dart';

class SmallInputField extends StatelessWidget {
  final String title;
  final String? hint;
  final String? initialValue;
  final TextEditingController? controller;
  final Widget? widget;
  final TextInputType? keyboardType;
  final double? width;

  const SmallInputField(
      {Key? key,
      required this.title,
      this.hint,
      this.initialValue,
      this.controller,
      this.widget,
      this.keyboardType,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 3.0),
      padding: const EdgeInsets.all(4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontFamily: RainbowTextStyle.fontFamily),
          ),
          Container(
            height: 40,
            width: width,
            margin: const EdgeInsets.only(
              left: 15.0,
            ),
            padding: const EdgeInsets.only(left: 14),
            decoration: BoxDecoration(
              border: Border.all(color: RainbowColor.primary_1, width: 1.0),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    validator: (input) {
                      if (int.parse(input!) >= 24) {
                        return AppLocalizations.of(context)!.tooManyHours;
                      }
                      return null;
                    },
                    initialValue: initialValue,
                    keyboardType: keyboardType,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                        fontStyle: FontStyle.italic,
                        fontFamily: RainbowTextStyle.fontFamily),
                    decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontFamily: RainbowTextStyle.fontFamily),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: Colors.white,
                        width: 0,
                      )),
                      enabledBorder: const UnderlineInputBorder(
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
                        alignment: Alignment.center,
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
