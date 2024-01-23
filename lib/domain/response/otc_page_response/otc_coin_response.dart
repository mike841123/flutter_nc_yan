import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'otc_coin_response.g.dart';

@JsonSerializable()
class OtcCoinResponse extends ApiResponse<List<OtcCoinItem>> {
  OtcCoinResponse({String message = "", int code = 1, List<OtcCoinItem>? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory OtcCoinResponse.fromJson(Map<String, dynamic> json) => _$OtcCoinResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OtcCoinResponseToJson(this);
}

@JsonSerializable()
class OtcCoinItem {
  OtcCoinItem({
    this.unit = "",
  });

  String unit;

  factory OtcCoinItem.fromJson(Map<String, dynamic> json) => _$OtcCoinItemFromJson(json);

  Map<String, dynamic> toJson() => _$OtcCoinItemToJson(this);
}