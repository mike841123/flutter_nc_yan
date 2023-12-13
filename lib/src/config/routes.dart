import 'package:flutter/cupertino.dart';

import '../design/page/home/home_provider.dart';
import '../design/page/lobby/lobby.dart';
import '../design/page/market/market_provider.dart';
import '../design/page/member/member_provider.dart';
import '../design/page/otc/otc_provider.dart';
import '../design/page/transaction/transaction_provider.dart';

class Routes {
  static String home = '/home', login = '/login', market = '/market', transaction = '/transaction', otc = '/otc', member = '/member';

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
    // Routes.login: (BuildContext context) => const LoginProvider(),
  };
}
