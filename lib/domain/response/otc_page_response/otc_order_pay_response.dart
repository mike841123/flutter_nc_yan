import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'otc_order_pay_response.g.dart';

@JsonSerializable()
class OtcOrderPayResponse extends ApiResponse<OtcOrderResult> {
  OtcOrderPayResponse({String message = "", int code = 1, OtcOrderResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory OtcOrderPayResponse.fromJson(Map<String, dynamic> json) => _$OtcOrderPayResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OtcOrderPayResponseToJson(this);
}

@JsonSerializable()
class OtcOrderResult {
  OtcOrderResult({
    this.orderSn,
  });

  final String? orderSn;

  factory OtcOrderResult.fromJson(Map<String, dynamic> json) => _$OtcOrderResultFromJson(json);

  Map<String, dynamic> toJson() => _$OtcOrderResultToJson(this);
}
