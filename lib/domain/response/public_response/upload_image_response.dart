import 'package:json_annotation/json_annotation.dart';
import '../api_response.dart';
import '../api_special_response.dart';
part 'upload_image_response.g.dart';

@JsonSerializable()
class UploadImageResponse extends ApiSpecialResponse<UploadImageResult> {
  UploadImageResponse({String message = "", int code = 1, String? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory UploadImageResponse.fromJson(Map<String, dynamic> json) => _$UploadImageResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UploadImageResponseToJson(this);
}

@JsonSerializable()
class UploadImageResult {
  UploadImageResult({this.result = ""});

  String result;

  factory UploadImageResult.fromJson(Map<String, dynamic> json) => _$UploadImageResultFromJson(json);

  Map<String, dynamic> toJson() => _$UploadImageResultToJson(this);
}
