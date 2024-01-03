// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'promotion_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PromotionResponse _$PromotionResponseFromJson(Map<String, dynamic> json) =>
    PromotionResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : PromotionResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$PromotionResponseToJson(PromotionResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

PromotionResult _$PromotionResultFromJson(Map<String, dynamic> json) =>
    PromotionResult(
      levelOne: json['levelOne'] as int?,
    );

Map<String, dynamic> _$PromotionResultToJson(PromotionResult instance) =>
    <String, dynamic>{
      'levelOne': instance.levelOne,
    };
