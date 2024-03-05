import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'details_response.g.dart';

@JsonSerializable()
class DetailsResponse extends ApiResponse<DetailsResult> {
  DetailsResponse({String message = "", int code = 1, DetailsResult? data, dynamic extend}) : super(message: message, code: code, data: data, extend: extend);

  factory DetailsResponse.fromJson(Map<String, dynamic> json) => _$DetailsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DetailsResponseToJson(this);
}

@JsonSerializable()
class DetailsResult {
  DetailsResult({
    this.title = "",
    this.createTime = "",
    this.content = "",
  });

  String title;
  String createTime;
  String content;

  factory DetailsResult.fromJson(Map<String, dynamic> json) => _$DetailsResultFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsResultToJson(this);
}
