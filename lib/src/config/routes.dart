import 'package:flutter/cupertino.dart';
import 'package:yan_demo_fcm/src/design/page/asset_flow/asset_flow_provider.dart';
import 'package:yan_demo_fcm/src/design/page/my_advertisement/my_advertisement_provider.dart';
import '../design/page/lobby/lobby.dart';
import '../design/page/login/login_provider.dart';

class Routes {
  static String home = '/home',
      login = '/login',
      market = '/market',
      transaction = '/transaction',
      otc = '/otc',
      member = '/member',
      myAdvertisement = '/myAdvertisement',
      assetFlow = '/assetFlow';

  static List<String> roots = [
    Routes.login,
    Routes.home,
    Routes.member,
    Routes.otc,
    Routes.transaction,
    Routes.market,
  ]; // 無上一頁根目錄

  static final Map<String, Widget Function(BuildContext)> pages = {
    Routes.home: (BuildContext context) => const Lobby(),
    Routes.login: (BuildContext context) => const LoginProvider(),
    Routes.myAdvertisement: (BuildContext context) => const MyAdvertisementProvider(),
    Routes.assetFlow: (BuildContext context) => const AssetFlowProvider(),
  };
}
