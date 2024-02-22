import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'otc_order_response.g.dart';

@JsonSerializable()
class OtcOrderResponse extends ApiResponse<OtcOrderResult> {
  OtcOrderResponse({String message = "", int code = 1, OtcOrderResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory OtcOrderResponse.fromJson(Map<String, dynamic> json) => _$OtcOrderResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OtcOrderResponseToJson(this);
}

@JsonSerializable()
class OtcOrderResult {
  OtcOrderResult({
    this.content = const [],
    this.totalElements = 0,
    this.totalPages = 0,
  });

  List<Content> content;
  int totalElements;
  int totalPages;

  factory OtcOrderResult.fromJson(Map<String, dynamic> json) => _$OtcOrderResultFromJson(json);

  Map<String, dynamic> toJson() => _$OtcOrderResultToJson(this);
}

@JsonSerializable()
class Content {
  Content({
    required this.orderSn,
    required this.type,
    required this.status,
    required this.unit,
    required this.amount,
    required this.name,
    required this.money,
  });

  String orderSn;
  int type;
  int status;
  String unit;
  double amount;
  String name;
  double money;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
