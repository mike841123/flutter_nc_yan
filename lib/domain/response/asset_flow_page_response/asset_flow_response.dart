import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'asset_flow_response.g.dart';

@JsonSerializable()
class AssetFlowResponse extends ApiResponse<AssetFlowResult> {
  AssetFlowResponse({String message = "", int code = 1, AssetFlowResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory AssetFlowResponse.fromJson(Map<String, dynamic> json) => _$AssetFlowResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AssetFlowResponseToJson(this);
}

@JsonSerializable()
class AssetFlowResult {
  AssetFlowResult({
    this.content = const [],
    this.totalElements = 0,
    this.totalPages = 0,
  });

  List<Content> content;
  int totalElements;
  int totalPages;

  factory AssetFlowResult.fromJson(Map<String, dynamic> json) => _$AssetFlowResultFromJson(json);

  Map<String, dynamic> toJson() => _$AssetFlowResultToJson(this);
}

@JsonSerializable()
class Content {
  Content({
    this.amount = 0,
    this.createTime = "",
    this.fee = 0,
    this.realFee = "",
    this.discountFee = "",
    this.symbol = "",
    this.flag = 0,
    this.type = 0,
  });

  double amount;
  String createTime;
  double fee;
  String realFee;
  String discountFee;
  String symbol;
  int flag;
  int type;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
