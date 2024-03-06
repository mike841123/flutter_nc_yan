import 'package:json_annotation/json_annotation.dart';
import '../api_response.dart';

part 'asset_wallet_response.g.dart';

@JsonSerializable()
class AssetWalletResponse extends ApiResponse<List<AssetWalletResult>> {
  AssetWalletResponse({String message = "", int code = 1, List<AssetWalletResult>? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory AssetWalletResponse.fromJson(Map<String, dynamic> json) => _$AssetWalletResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssetWalletResponseToJson(this);
}

@JsonSerializable()
class AssetWalletResult {
  AssetWalletResult({
    this.id = 0,
    this.balance = 0,
    this.frozenBalance = 0,
    this.toReleased = 0,
    this.coin,
    this.address = "",
  });

  int id;
  double balance;
  double frozenBalance;
  double toReleased;
  Coin? coin;
  String address;

  factory AssetWalletResult.fromJson(Map<String, dynamic> json) => _$AssetWalletResultFromJson(json);

  Map<String, dynamic> toJson() => _$AssetWalletResultToJson(this);
}

@JsonSerializable()
class Coin {
  Coin({
    this.unit = "",
    this.usdRate = 0,
    this.cnyRate = 0,
    this.infolink = "",
    this.minRechargeAmount = 0,
  });

  String unit;
  double cnyRate;
  double usdRate;
  String infolink;
  double minRechargeAmount;

  factory Coin.fromJson(Map<String, dynamic> json) => _$CoinFromJson(json);

  Map<String, dynamic> toJson() => _$CoinToJson(this);
}
