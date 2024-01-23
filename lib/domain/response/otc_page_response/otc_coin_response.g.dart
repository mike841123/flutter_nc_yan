// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otc_coin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtcCoinResponse _$OtcCoinResponseFromJson(Map<String, dynamic> json) =>
    OtcCoinResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => OtcCoinItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      extend: json['extend'],
    );

Map<String, dynamic> _$OtcCoinResponseToJson(OtcCoinResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

OtcCoinItem _$OtcCoinItemFromJson(Map<String, dynamic> json) => OtcCoinItem(
      unit: json['unit'] as String? ?? "",
    );

Map<String, dynamic> _$OtcCoinItemToJson(OtcCoinItem instance) =>
    <String, dynamic>{
      'unit': instance.unit,
    };
