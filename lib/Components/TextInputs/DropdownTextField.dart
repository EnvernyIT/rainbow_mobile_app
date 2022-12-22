import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';

import '../../Theme/ThemeTextStyle.dart';

class DropdownTextField extends StatefulWidget {
  final String title;
  final List<String> dropdownList;
  final Color? textColor;
  final Color? iconColor;
  final MainAxisAlignment? mainAxisAlignment;
  final double? fontSize;

  const DropdownTextField({
    Key? key,
    required this.title,
    required this.dropdownList,
    this.textColor,
    this.iconColor,
    this.mainAxisAlignment,
    this.fontSize,
  }) : super(key: key);

  @override
  State<DropdownTextField> createState() => _DropdownTextField();
}

class _DropdownTextField extends State<DropdownTextField> {
  String value = "";

  String getValue() {
    return value;
  }

  @override
  void initState() {
    super.initState();
    value = widget.dropdownList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment:
            widget.mainAxisAlignment ?? MainAxisAlignment.spaceBetween,
        children: [
          Container(
              padding: const EdgeInsets.all(4),
              margin: const EdgeInsets.only(bottom: 7, right: 7),
              child: Text(
                widget.title + ": ",
                textAlign: TextAlign.left,
                style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.fontSize,
                    fontFamily: RainbowTextStyle.fontFamily),
              )),
          Container(
            padding: const EdgeInsets.all(0),
            margin: const EdgeInsets.only(bottom: 7),
            child: DropdownButton(
                value: value,
                icon: const Padding(
                    padding: EdgeInsets.only(left: 0),
                    child: Icon(Icons.arrow_circle_down_sharp)),
                iconEnabledColor: RainbowColor.primary_1, //Icon color
                style: TextStyle(
                    color: RainbowColor.primary_1, //Font color
                    fontSize: widget.fontSize, //font size on dropdown button
                    fontFamily: RainbowTextStyle.fontFamily),
                dropdownColor:
                    RainbowColor.secondary, //dropdown background color
                underline: Container(), //remove underline
                isExpanded: false, //make true to make width 100%
                items: widget.dropdownList.map((String items) {
                  return DropdownMenuItem(
                    value: items,
                    child: Text(items,
                        style: TextStyle(
                            fontFamily: RainbowTextStyle.fontFamily,
                            fontSize: (widget.fontSize))),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    value = newValue!;
                  });
                }),
          )
        ]);
  }
}
