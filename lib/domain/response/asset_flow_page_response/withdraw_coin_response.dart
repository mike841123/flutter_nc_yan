import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'withdraw_coin_response.g.dart';

@JsonSerializable()
class WithdrawCoinResponse extends ApiResponse<List<WithdrawCoinItem>> {
  WithdrawCoinResponse({String message = "", int code = 1, List<WithdrawCoinItem>? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory WithdrawCoinResponse.fromJson(Map<String, dynamic> json) => _$WithdrawCoinResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$WithdrawCoinResponseToJson(this);
}

@JsonSerializable()
class WithdrawCoinItem {
  WithdrawCoinItem({
    this.unit = "",
  });

  String unit;

  factory WithdrawCoinItem.fromJson(Map<String, dynamic> json) => _$WithdrawCoinItemFromJson(json);

  Map<String, dynamic> toJson() => _$WithdrawCoinItemToJson(this);
}