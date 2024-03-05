// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DetailsResponse _$DetailsResponseFromJson(Map<String, dynamic> json) =>
    DetailsResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : DetailsResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$DetailsResponseToJson(DetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

DetailsResult _$DetailsResultFromJson(Map<String, dynamic> json) =>
    DetailsResult(
      title: json['title'] as String? ?? "",
      createTime: json['createTime'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$DetailsResultToJson(DetailsResult instance) =>
    <String, dynamic>{
      'title': instance.title,
      'createTime': instance.createTime,
      'content': instance.content,
    };
