import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'assets_wallet_response.g.dart';

@JsonSerializable()
class AssetsWalletResponse extends ApiResponse<List<AssetsWalletResult>> {
  AssetsWalletResponse({String message = "", int code = 1, List<AssetsWalletResult>? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory AssetsWalletResponse.fromJson(Map<String, dynamic> json) => _$AssetsWalletResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssetsWalletResponseToJson(this);
}

@JsonSerializable()
class AssetsWalletResult {
  AssetsWalletResult({
    this.id = 0,
    this.balance = 0,
    this.frozenBalance = 0,
    this.toReleased = 0,
  });

  int id;
  double balance;
  double frozenBalance;
  double toReleased;

  factory AssetsWalletResult.fromJson(Map<String, dynamic> json) => _$AssetsWalletResultFromJson(json);

  Map<String, dynamic> toJson() => _$AssetsWalletResultToJson(this);
}
