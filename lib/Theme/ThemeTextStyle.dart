class RainbowTextStyle {
  static int? styleIndex = 0;

  RainbowTextStyle(int index) {
    RainbowTextStyle.styleIndex = index;
  }

  static String fontFamily = styleIndex == 0
      ? "Open Sans"
      : styleIndex == 1
          ? "Raleway"
          : "Montserrat";
}
