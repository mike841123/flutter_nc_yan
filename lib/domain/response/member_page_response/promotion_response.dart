import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'promotion_response.g.dart';

@JsonSerializable()
class PromotionResponse extends ApiResponse<PromotionResult>{
  PromotionResponse({String message = "", int code = 1, PromotionResult? data, dynamic extend}) : super(message: message, code: code, data: data, extend: extend);

  factory PromotionResponse.fromJson(Map<String, dynamic> json) => _$PromotionResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PromotionResponseToJson(this);
}

@JsonSerializable()
class PromotionResult {
  PromotionResult({this.levelOne});

  int? levelOne;

  factory PromotionResult.fromJson(Map<String, dynamic> json) => _$PromotionResultFromJson(json);

  Map<String, dynamic> toJson() => _$PromotionResultToJson(this);
}
