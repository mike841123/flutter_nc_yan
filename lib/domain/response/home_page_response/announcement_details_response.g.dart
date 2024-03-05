// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_details_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnnouncementDetailsResponse _$AnnouncementDetailsResponseFromJson(
        Map<String, dynamic> json) =>
    AnnouncementDetailsResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : AnnouncementDetailsResult.fromJson(
              json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$AnnouncementDetailsResponseToJson(
        AnnouncementDetailsResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

AnnouncementDetailsResult _$AnnouncementDetailsResultFromJson(
        Map<String, dynamic> json) =>
    AnnouncementDetailsResult(
      info: json['info'] == null
          ? null
          : Info.fromJson(json['info'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AnnouncementDetailsResultToJson(
        AnnouncementDetailsResult instance) =>
    <String, dynamic>{
      'info': instance.info,
    };

Info _$InfoFromJson(Map<String, dynamic> json) => Info(
      createTime: json['createTime'] as String? ?? "",
      title: json['title'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$InfoToJson(Info instance) => <String, dynamic>{
      'content': instance.content,
      'title': instance.title,
      'createTime': instance.createTime,
    };
