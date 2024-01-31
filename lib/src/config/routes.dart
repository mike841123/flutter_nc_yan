import 'package:flutter/cupertino.dart';
import 'package:yan_demo_fcm/src/design/page/asset_flow/asset_flow_provider.dart';
import 'package:yan_demo_fcm/src/design/page/my_advertisement/my_advertisement_provider.dart';
import 'package:yan_demo_fcm/src/design/page/otc_trade/otc_trade_provider.dart';
import '../design/page/chat_content_page/chat_content_provider.dart';
import '../design/page/lobby/lobby.dart';
import '../design/page/login/login_provider.dart';
import '../design/page/money_management/money_management_provider.dart';
import '../design/page/money_management_record/money_management_record_provider.dart';

class Routes {
  static String home = '/home',
      login = '/login',
      market = '/market',
      transaction = '/transaction',
      otc = '/otc',
      member = '/member',
      myAdvertisement = '/myAdvertisement',
      assetFlow = '/assetFlow',
      chatContent = '/chatContent',
      moneyManagement = '/moneyManagement',
      moneyManagementRecord = '/moneyManagementRecord',
      otcTrade = '/otcTrade';

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
    Routes.chatContent: (BuildContext context) => const ChatContentProvider(),
    Routes.moneyManagement: (BuildContext context) => const MoneyManagementProvider(),
    Routes.moneyManagementRecord: (BuildContext context) => const MoneyManagementRecordProvider(),
    Routes.otcTrade: (BuildContext context) => const OtcTradeProvider(),
  };
}
