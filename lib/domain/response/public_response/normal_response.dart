import 'package:json_annotation/json_annotation.dart';
import '../api_response.dart';

part 'normal_response.g.dart';

@JsonSerializable()
class NormalResponse extends ApiResponse<String> {
  NormalResponse({String message = "", int code = 1, String? data, dynamic extend}) : super(message: message, code: code, data: data, extend: extend);

  factory NormalResponse.fromJson(Map<String, dynamic> json) => _$NormalResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NormalResponseToJson(this);
}
