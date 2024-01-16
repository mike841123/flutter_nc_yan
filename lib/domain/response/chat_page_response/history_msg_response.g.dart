// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_msg_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryMsgResponse _$HistoryMsgResponseFromJson(Map<String, dynamic> json) =>
    HistoryMsgResponse(
      totalCount: json['totalCount'] as int?,
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => HistoryMsgResult.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$HistoryMsgResponseToJson(HistoryMsgResponse instance) =>
    <String, dynamic>{
      'totalCount': instance.totalCount,
      'data': instance.data,
    };

HistoryMsgResult _$HistoryMsgResultFromJson(Map<String, dynamic> json) =>
    HistoryMsgResult(
      sendTimeStr: json['sendTimeStr'] as String? ?? "",
      nameFrom: json['nameFrom'] as String? ?? "",
      content: json['content'] as String? ?? "",
    );

Map<String, dynamic> _$HistoryMsgResultToJson(HistoryMsgResult instance) =>
    <String, dynamic>{
      'sendTimeStr': instance.sendTimeStr,
      'nameFrom': instance.nameFrom,
      'content': instance.content,
    };
