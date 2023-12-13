import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yan_demo_fcm/src/config/shared_preferences_key.dart';

class AppConfig {
  static bool isTestEnv = true; // 是否為測試環境

  static String scheme = "https"; // 應用協定

  static String domain = "php-robot-api.mxkjtw.com/api"; // 正式站域名

  static final RouteObserver<ModalRoute<void>> routeObserver = RouteObserver<ModalRoute<void>>(); // 路由觀察者

  static String get token {
    return sharedPreferences.getString(SPKey.ACCESS_TOKEN) ?? "";
  } // 獲取 api 所需 token

  static set token(String value) {
    sharedPreferences.setString(SPKey.ACCESS_TOKEN, value);
  }

  static late SharedPreferences sharedPreferences; // 保存本地參數
}
