// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'help_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HelpResponse _$HelpResponseFromJson(Map<String, dynamic> json) => HelpResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => HelpItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      extend: json['extend'],
    );

Map<String, dynamic> _$HelpResponseToJson(HelpResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

HelpItem _$HelpItemFromJson(Map<String, dynamic> json) => HelpItem(
      cate: json['cate'] as String? ?? "",
      titleCN: json['titleCN'] as String? ?? "",
      titleEN: json['titleEN'] as String? ?? "",
      title: json['title'] as String? ?? "",
      createTime: json['createTime'] as String? ?? "",
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HelpItemToJson(HelpItem instance) => <String, dynamic>{
      'cate': instance.cate,
      'titleCN': instance.titleCN,
      'titleEN': instance.titleEN,
      'content': instance.content,
      'title': instance.title,
      'createTime': instance.createTime,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      id: json['id'] as int? ?? 0,
      title: json['title'] as String? ?? "",
      createTime: json['createTime'] as String? ?? "",
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'createTime': instance.createTime,
    };
