import 'package:flutter/cupertino.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import '../app_color.dart';

class DarkColor {
  DarkColor() {
    Logger.d("Dark Style init");

    AppColor.bgColor1 = const Color(0xff2e2e2e);
    AppColor.bgColor2 = const Color(0xff00cfbe);
    AppColor.bgColor3 = const Color(0xffefefef);
    AppColor.bgColor4 = const Color(0xff000000);
    AppColor.bgColor5 = const Color(0xffffffff);
    AppColor.bgColor6 = const Color(0xfff15057);
    AppColor.bgColor7 = const Color(0xffd9d9d9);
    AppColor.bgColor8 = const Color(0xff00b676);

    AppColor.textColor1 = const Color(0xffffffff);
    AppColor.textColor2 = const Color(0xff00cfbe);
    AppColor.textColor3 = const Color(0xffcccccc);
    AppColor.textColor4 = const Color(0xffefefef);
    AppColor.textColor5 = const Color(0xff999999);
    AppColor.textColor6 = const Color(0xff00b676);
    AppColor.textColor7 = const Color(0xffd0392e);
    AppColor.textColor8 = const Color(0xff000000);
  }
}
