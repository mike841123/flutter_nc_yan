import 'dart:async';

import 'package:flutter_easylogger/flutter_logger.dart';

class Awaiter {
  /// 直到達成條件或計數次數才結束
  /// [conditionFunction] 條件函式
  /// [resultFunction] 為真時執行函式
  /// [milliseconds] 等待間隔
  /// [count] 計數次數
  static until(Function() conditionFunction, Function() resultFunction, {int milliseconds = 400, int count = 999}) {
    Future<bool> future() async {
      return conditionFunction();
    }

    return future().then((value) async => {
          if (value)
            {
              resultFunction(),
            }
          else
            {
              if (count > 0)
                {
                  await Future.delayed(Duration(milliseconds: milliseconds)),
                  until(conditionFunction, resultFunction, milliseconds: milliseconds, count: --count),
                }
              else
                {
                  Logger.e("count is return to zero"),
                }
            }
        });
  }
}
