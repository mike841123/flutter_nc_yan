// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otc_advertise_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtcAdvertiseResponse _$OtcAdvertiseResponseFromJson(
        Map<String, dynamic> json) =>
    OtcAdvertiseResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : OtcAdvertiseResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$OtcAdvertiseResponseToJson(
        OtcAdvertiseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

OtcAdvertiseResult _$OtcAdvertiseResultFromJson(Map<String, dynamic> json) =>
    OtcAdvertiseResult(
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$OtcAdvertiseResultToJson(OtcAdvertiseResult instance) =>
    <String, dynamic>{
      'content': instance.content,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      totalElements: json['totalElements'] as int? ?? 0,
      id: json['id'] as int? ?? 0,
      advertiseType: json['advertiseType'] as int? ?? 0,
      member: json['member'] == null
          ? null
          : Member.fromJson(json['member'] as Map<String, dynamic>),
      maxLimit: (json['maxLimit'] as num?)?.toDouble() ?? 0,
      minLimit: (json['minLimit'] as num?)?.toDouble() ?? 0,
      remainAmount: (json['remainAmount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'totalElements': instance.totalElements,
      'id': instance.id,
      'advertiseType': instance.advertiseType,
      'minLimit': instance.minLimit,
      'maxLimit': instance.maxLimit,
      'remainAmount': instance.remainAmount,
      'member': instance.member,
    };

Member _$MemberFromJson(Map<String, dynamic> json) => Member(
      email: json['email'] as String? ?? "",
    );

Map<String, dynamic> _$MemberToJson(Member instance) => <String, dynamic>{
      'email': instance.email,
    };
