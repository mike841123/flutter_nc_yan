// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'upload_image_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UploadImageResponse _$UploadImageResponseFromJson(Map<String, dynamic> json) =>
    UploadImageResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] as String?,
      extend: json['extend'],
    );

Map<String, dynamic> _$UploadImageResponseToJson(
        UploadImageResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

UploadImageResult _$UploadImageResultFromJson(Map<String, dynamic> json) =>
    UploadImageResult(
      result: json['result'] as String? ?? "",
    );

Map<String, dynamic> _$UploadImageResultToJson(UploadImageResult instance) =>
    <String, dynamic>{
      'result': instance.result,
    };
