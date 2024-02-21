import 'package:flutter/cupertino.dart';
import 'package:flutter_easylogger/flutter_logger.dart';

import '../app_color.dart';

class LightColor {
  LightColor() {
    Logger.d("Light Style init");

    AppColor.bgColor1 = const Color(0xff2e2e2e);

  }
}
