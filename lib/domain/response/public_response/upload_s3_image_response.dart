import 'package:json_annotation/json_annotation.dart';
import '../api_response.dart';

part 'upload_s3_image_response.g.dart';

@JsonSerializable()
class UploadS3ImageResponse extends ApiResponse<UploadS3ImageResult> {
  UploadS3ImageResponse({String message = "", int code = 1, UploadS3ImageResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory UploadS3ImageResponse.fromJson(Map<String, dynamic> json) => _$UploadS3ImageResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UploadS3ImageResponseToJson(this);
}

@JsonSerializable()
class UploadS3ImageResult {
  UploadS3ImageResult({
    this.filename = "",
    this.imageUrl = "",
  });

  String filename;
  String imageUrl;

  factory UploadS3ImageResult.fromJson(Map<String, dynamic> json) => _$UploadS3ImageResultFromJson(json);

  Map<String, dynamic> toJson() => _$UploadS3ImageResultToJson(this);
}
