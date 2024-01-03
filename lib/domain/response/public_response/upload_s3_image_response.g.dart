// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_s3_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadS3ImageResponse _$UploadS3ImageResponseFromJson(
        Map<String, dynamic> json) =>
    UploadS3ImageResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : UploadS3ImageResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$UploadS3ImageResponseToJson(
        UploadS3ImageResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

UploadS3ImageResult _$UploadS3ImageResultFromJson(Map<String, dynamic> json) =>
    UploadS3ImageResult(
      filename: json['filename'] as String? ?? "",
      imageUrl: json['imageUrl'] as String? ?? "",
    );

Map<String, dynamic> _$UploadS3ImageResultToJson(
        UploadS3ImageResult instance) =>
    <String, dynamic>{
      'filename': instance.filename,
      'imageUrl': instance.imageUrl,
    };
