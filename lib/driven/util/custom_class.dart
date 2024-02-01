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
