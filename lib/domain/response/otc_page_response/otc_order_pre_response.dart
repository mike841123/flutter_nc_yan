import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'otc_order_pre_response.g.dart';

@JsonSerializable()
class OtcOrderPreResponse extends ApiResponse<OtcOrderPreResult> {
  OtcOrderPreResponse({String message = "", int code = 1, OtcOrderPreResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory OtcOrderPreResponse.fromJson(Map<String, dynamic> json) => _$OtcOrderPreResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OtcOrderPreResponseToJson(this);
}

@JsonSerializable()
class OtcOrderPreResult {
  OtcOrderPreResult({
    this.username,
    this.emailVerified,
    this.phoneVerified,
    this.idCardVerified,
    this.transactions,
    this.otcCoinId,
    this.unit,
    this.price,
    this.number,
    this.payMode,
    this.minLimit,
    this.maxLimit,
    this.timeLimit,
    this.country,
    this.advertiseType,
    this.remark,
    this.maxTradableAmount,
  });

  String? username;
  int? emailVerified;
  int? phoneVerified;
  int? idCardVerified;
  double? transactions;
  int? otcCoinId;
  String? unit;
  double? price;
  double? number;
  String? payMode;
  double? minLimit;
  double? maxLimit;
  int? timeLimit;
  String? country;
  int? advertiseType;
  String? remark;
  double? maxTradableAmount;

  factory OtcOrderPreResult.fromJson(Map<String, dynamic> json) => _$OtcOrderPreResultFromJson(json);

  Map<String, dynamic> toJson() => _$OtcOrderPreResultToJson(this);
}
