// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertise_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertiseResponse _$AdvertiseResponseFromJson(Map<String, dynamic> json) =>
    AdvertiseResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AdvertiseItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      extend: json['extend'],
    );

Map<String, dynamic> _$AdvertiseResponseToJson(AdvertiseResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

AdvertiseItem _$AdvertiseItemFromJson(Map<String, dynamic> json) =>
    AdvertiseItem(
      url: json['url'] as String? ?? "",
    );

Map<String, dynamic> _$AdvertiseItemToJson(AdvertiseItem instance) =>
    <String, dynamic>{
      'url': instance.url,
    };
