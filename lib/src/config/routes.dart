import 'package:flutter/cupertino.dart';
import 'package:yan_demo_fcm/src/design/page/asset_flow/asset_flow_provider.dart';
import 'package:yan_demo_fcm/src/design/page/help_center/help_center_provider.dart';
import 'package:yan_demo_fcm/src/design/page/my_advertisement/my_advertisement_provider.dart';
import 'package:yan_demo_fcm/src/design/page/otc_details/otc_details_provider.dart';
import 'package:yan_demo_fcm/src/design/page/otc_trade/otc_trade_provider.dart';
import '../design/page/advertise_ad/advertise_ad_provider.dart';
import '../design/page/announcement/announcement_provider.dart';
import '../design/page/chat_content_page/chat_content_provider.dart';
import '../design/page/details/details_provider.dart';
import '../design/page/lobby/lobby.dart';
import '../design/page/login/login_provider.dart';
import '../design/page/money_management/money_management_provider.dart';
import '../design/page/money_management_record/money_management_record_provider.dart';
import '../design/page/my_assets/my_assets_provider.dart';
import '../design/page/otc_list/otc_list_provider.dart';

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
      otcTrade = '/otcTrade',
      otcDetails = '/otcDetails',
      otcList = '/otcList',
      advertiseAd = '/advertiseAd',
      helpCenter = '/helpCenter',
      details = '/details',
      announcement = '/announcement',
      myAsset = '/myAsset';

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
    Routes.otcDetails: (BuildContext context) => const OtcDetailsProvider(),
    Routes.otcList: (BuildContext context) => const OtcListProvider(),
    Routes.advertiseAd: (BuildContext context) => const AdvertiseAdProvider(),
    Routes.helpCenter: (BuildContext context) => const HelpCenterProvider(),
    Routes.details: (BuildContext context) => const DetailsProvider(),
    Routes.announcement: (BuildContext context) => const AnnouncementProvider(),
    Routes.myAsset: (BuildContext context) => const MyAssetProvider(),
  };
}
