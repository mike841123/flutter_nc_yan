import 'package:flutter/cupertino.dart';
import 'package:yan_demo_fcm/src/config/colors/light_color.dart';

import 'colors/dark_color.dart';

enum ThemeStyle { dark, light }

class AppColor {
  static late ThemeStyle style;

  AppColor(ThemeStyle themeStyle) {
    style = themeStyle;
    switch (themeStyle) {
      case ThemeStyle.dark:
        DarkColor();
        break;
      case ThemeStyle.light:
        LightColor();
        break;
      default:
        DarkColor();
        break;
    }
  }
  static Color? bgColor1;
  static Color? bgColor2;
  static Color? bgColor3;
  static Color? bgColor4;
  static Color? bgColor5;
  static Color? bgColor6;
  static Color? bgColor7;
  static Color? textColor1;
  static Color? textColor2;
  static Color? textColor3;
  static Color? textColor4;
  static Color? textColor5;
  static Color? textColor6;
  static Color? textColor7;
  static Color? textColor8;
}
