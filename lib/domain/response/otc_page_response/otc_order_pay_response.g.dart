// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otc_order_pay_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtcOrderPayResponse _$OtcOrderPayResponseFromJson(Map<String, dynamic> json) =>
    OtcOrderPayResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : OtcOrderResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$OtcOrderPayResponseToJson(
        OtcOrderPayResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

OtcOrderResult _$OtcOrderResultFromJson(Map<String, dynamic> json) =>
    OtcOrderResult(
      orderSn: json['orderSn'] as String?,
    );

Map<String, dynamic> _$OtcOrderResultToJson(OtcOrderResult instance) =>
    <String, dynamic>{
      'orderSn': instance.orderSn,
    };
