import 'package:decimal/decimal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:retrofit/retrofit.dart';
import 'package:yan_demo_fcm/domain/response/api_special_response.dart';
import 'package:yan_demo_fcm/src/config/routes.dart';
import '../../../../get_it_service_locator.dart';
import '../../domain/response/api_response.dart';
import '../../src/config/app_config.dart';
import '../../src/design/model/routes_cubit/routes_cubit.dart';
import '../service/state_service.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
/// 金錢格式轉換擴充功能
extension FormatNumber<T> on T {
  /// 錢幣格式轉換
  /// 1000 => 1,000
  /// 1000000 => 1,000,000
  /// [point] 小數點位數
  /// [dot] 是否顯示逗點
  String formatNumber(int point, {bool dot = true}) {
    if (this != null && double.parse(toString()) != 0) {
      String str = double.parse(toString()).toString();
      bool hasMinus = str.contains("-"); // 先過濾負號
      if (hasMinus) str = str.replaceAll("-", "");

      // 分開截取
      List<String> sub = str.split('.');
      // 處理值
      List val = List.from(sub[0].split(''));
      // 處理點
      List<String> points = sub.length > 1 ? List.from(sub[1].split('')) : ['0'];
      // 處理分割符
      for (int index = 0, i = val.length - 1; i >= 0; index++, i--) {
        // 除以三沒有餘數、不等於零並且不等於1 就加個逗號
        if (index % 3 == 0 && index != 0 && dot) val[i] = val[i] + ',';
      }

      // 處理小數點
      // 如果大於長度就截取
      if (points.length > point) {
        // 截取數組
        points = points.sublist(0, point);
      } else {
        int temp = point - points.length; //不能在迴圈運算否則會異步
        for (int i = 0; i < temp; i++) {
          points.add('0');
        }
      }

      // 判斷是否有長度
      if (points.isNotEmpty) {
        return "${hasMinus ? "-" : ""}" '${val.join('')}.${points.join('')}';
      } else {
        return (hasMinus ? "-" : "") + val.join('');
      }
    } else {
      return "0";
    }
  }
}

// /// 金錢格式轉換擴充功能
// extension CurrencyFormat<T> on T {
//   /// 錢幣格式轉換
//   /// 1000 => 1,000
//   /// 1000000 => 1,000,000
//   String currencyFormat() => NumberFormat('#,###').format(this);
// }

/// 精準數值格式轉換擴充功能
extension DecimalEx<T> on T {
  /// 由數值轉為精準數值格式再轉換成字串
  /// 1000.00 => 1000
  /// 100.980 => 100.98
  String toPrecisionString({bool empty = false}) =>
      empty ? (Decimal.parse(toString()).toString() == "0" ? "" : Decimal.parse(toString()).toString()) : Decimal.parse(toString()).toString();

  /// 轉成精準數值簡寫
  Decimal d() => Decimal.parse(toString());
}

/// int 擴充功能
extension IntEx on int {
  /// 整數類型轉成字串並且[count]為字串長度，原先整數長度不足，則在字串前面補 0
  String padZero(int count) => toString().padLeft(count, '0');

  /// 時間戳轉換成時間格式字串
  String millisecondsToTimeString() => DateTime.fromMillisecondsSinceEpoch(this).timeToString();
}

/// DateTime 擴充功能
extension DateFormatExtension on DateTime {
  /// 日期類型轉換字串格式的時間
  String timeToString() => DateFormat('yyyy-MM-dd kk:mm:ss').format(this);

  /// 當前 DateTime 當天的第一個時間戳
  int dayStartMillisecondsSinceEpoch() => DateTime(year, month, day).millisecondsSinceEpoch;
}

/// API 結束後調用函式
/// [replaceFunc] 取代默認的彈窗函式
/// [showSuccessDialog] code 為 0 成功返回時是否要彈出成功提示，默認為是
extension RegisterComplete<T> on T {
  void registerComplete({Function(HttpResponse<dynamic> res)? replaceFunc, bool showSuccessDialog = true}) {
    HttpResponse<dynamic> httpResponse = (this as HttpResponse<dynamic>);
    ApiResponse<dynamic> response = httpResponse.data as ApiResponse<dynamic>;
    if (replaceFunc != null) {
      replaceFunc(httpResponse); // 是否有取代默認的調用函式
    } else {
      if (response.code == 0) {
        if (showSuccessDialog) {
          print("success");
          SmartDialog.showToast(
            response.message,
            displayTime: const Duration(seconds: 2),
          );
          // BlocProvider.of<DialogCubit>(getIt<StateService>().scaffoldContext).updateDialog(DialogType.success, response.msg);
        }
      } else {
        switch (response.code) {
          case 4000:
            // 4000 為 token 過期
            AppConfig.token = "";
            BlocProvider.of<RoutesCubit>(getIt<StateService>().scaffoldContext).changePage(Routes.login);
            break;
          case 2000:
            // 2000 為 api /insure/getSymbolRealTime 成功時返回的 code
            break;
          default:
            // 0 以外，未被特殊處理的 code 皆以錯誤彈窗提示處理
            // BlocProvider.of<DialogCubit>(getIt<StateService>().scaffoldContext).updateDialog(DialogType.warning, response.msg);
            break;
        }
      }
    }
  }
}

/// SpecialAPI 結束後調用函式
/// [replaceFunc] 取代默認的彈窗函式
/// [showSuccessDialog] code 為 0 成功返回時是否要彈出成功提示，默認為是
extension RegisterSpecialComplete<T> on T {
  void registerSpecialComplete({Function(HttpResponse<dynamic> res)? replaceFunc, bool showSuccessDialog = true}) {
    HttpResponse<dynamic> httpResponse = (this as HttpResponse<dynamic>);
    ApiSpecialResponse<dynamic> response = httpResponse.data as ApiSpecialResponse<dynamic>;
    if (replaceFunc != null) {
      replaceFunc(httpResponse); // 是否有取代默認的調用函式
    } else {
      if (response.code == 0) {
        if (showSuccessDialog) {
          print("success");
          // BlocProvider.of<DialogCubit>(getIt<StateService>().scaffoldContext).updateDialog(DialogType.success, response.msg);
        }
      } else {
        switch (response.code) {
          case 403:
          // 403 為 token 過期
          AppConfig.token = "";
          // BlocProvider.of<UserCubit>(getIt<StateService>().scaffoldContext).clean();
          BlocProvider.of<RoutesCubit>(getIt<StateService>().scaffoldContext).changePage(Routes.login);
          // BlocProvider.of<DialogCubit>(getIt<StateService>().scaffoldContext).updateDialog(DialogType.warning, response.msg);
            break;
          case 2000:
          // 2000 為 api /insure/getSymbolRealTime 成功時返回的 code
            break;
          default:
          // 0 以外，未被特殊處理的 code 皆以錯誤彈窗提示處理
          // BlocProvider.of<DialogCubit>(getIt<StateService>().scaffoldContext).updateDialog(DialogType.warning, response.msg);
            break;
        }
      }
    }
  }
}
