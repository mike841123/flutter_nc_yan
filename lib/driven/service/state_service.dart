import 'package:flutter/material.dart';

/// Widget State 的服務
class StateService {
  /// 與 MaterialApp 的 key 依賴
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  /// 與 MaterialApp 下 Scaffold 的 key 依賴
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  NavigatorState get navigatorState => navigatorKey.currentState!;
  BuildContext get navigatorContext => navigatorKey.currentContext!;
  ScaffoldState get scaffoldState => scaffoldKey.currentState!;
  BuildContext get scaffoldContext => scaffoldKey.currentContext!;
}