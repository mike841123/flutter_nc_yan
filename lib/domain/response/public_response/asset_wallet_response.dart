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
  AssetWalletResult({this.balance = 0});

  double balance;

  factory AssetWalletResult.fromJson(Map<String, dynamic> json) => _$AssetWalletResultFromJson(json);

  Map<String, dynamic> toJson() => _$AssetWalletResultToJson(this);
}
