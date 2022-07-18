import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:rainbow_app/Theme/ThemeColor.dart';

import '../../Theme/ThemeTextStyle.dart';

class RTitle extends StatelessWidget {
  final String title;
  final String? subTitle;

  const RTitle({Key? key, required this.title, this.subTitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 10),
      margin: const EdgeInsets.only(bottom: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: RainbowColor.primary_1,
                fontSize: 26.0,
                fontFamily: RainbowTextStyle.fontFamily),
          ),
          Text(
            subTitle ?? "",
            style: TextStyle(
                color: Colors.black,
                fontSize: 17.0,
                fontFamily: RainbowTextStyle.fontFamily),
          )
        ],
      ),
    );
  }
}
