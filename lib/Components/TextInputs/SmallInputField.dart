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

  const SmallInputField({
    Key? key,
    required this.title,
    this.hint,
    this.initialValue,
    this.controller,
    this.widget,
    this.keyboardType,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          const EdgeInsets.only(top: 5.0, bottom: 15.0, left: 0.0, right: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          title.isNotEmpty
              ? Text(
                  title,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      fontFamily: RainbowTextStyle.fontFamily),
                )
              : const SizedBox(
                  width: 0,
                  height: 0,
                ),
          Container(
            height: 40,
            width: width ?? 150,
            margin: title.isNotEmpty
                ? const EdgeInsets.only(
                    left: 37.0,
                  )
                : const EdgeInsets.only(left: 0),
            padding: title.isNotEmpty
                ? const EdgeInsets.only(left: 14)
                : const EdgeInsets.only(left: 0),
            // decoration: BoxDecoration(
            //   border: Border.all(color: RainbowColor.primary_1, width: 1.0),
            //   borderRadius: BorderRadius.circular(12),
            // ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    textAlign: TextAlign.left,
                    textAlignVertical: TextAlignVertical.center,
                    // validator: (input) {
                    //   if (int.parse(input!) >= 24) {
                    //     return AppLocalizations.of(context)!.tooManyHours;
                    //   }
                    //   return null;
                    // },
                    initialValue: initialValue,
                    keyboardType: keyboardType,
                    readOnly: widget == null ? false : true,
                    autofocus: false,
                    controller: controller,
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
                      enabledBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                        color: RainbowColor.hint,
                        width: 1,
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
