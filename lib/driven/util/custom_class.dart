import '../../src/design/page/otc/otc_cubit.dart';

/// 將自定義類別集中此處管理

/// 導航欄類
class BarItem {
  String assetName;
  String label;

  BarItem({
    required this.assetName,
    required this.label,
  });
}

/// otc交易傳入參數類
class OtcTradeArguments {
  final OtcAdvertiseType type;
  final int id;
  final int coinId;
  final String unit;

  OtcTradeArguments({
    required this.type,
    required this.id,
    required this.coinId,
    required this.unit,
  });
}

/// 消息詳情頁傳入參數類
class DetailsArguments {
  final DetailsType type;
  final int id;

  DetailsArguments({
    required this.type,
    required this.id,
  });
}

enum DetailsType {
  announcement,
  help;

  const DetailsType();
}

/// 充幣頁傳入參數類
class RechargeArguments {
  final String unit;
  final String qrImg;
  final double minAmount;
  final String address;

  RechargeArguments({
    required this.unit,
    required this.qrImg,
    required this.minAmount,
    required this.address,
  });
}
