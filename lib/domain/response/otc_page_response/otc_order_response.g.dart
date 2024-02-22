// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otc_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtcOrderResponse _$OtcOrderResponseFromJson(Map<String, dynamic> json) =>
    OtcOrderResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : OtcOrderResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$OtcOrderResponseToJson(OtcOrderResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

OtcOrderResult _$OtcOrderResultFromJson(Map<String, dynamic> json) =>
    OtcOrderResult(
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
    );

Map<String, dynamic> _$OtcOrderResultToJson(OtcOrderResult instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      orderSn: json['orderSn'] as String,
      type: json['type'] as int,
      status: json['status'] as int,
      unit: json['unit'] as String,
      amount: (json['amount'] as num).toDouble(),
      name: json['name'] as String,
      money: (json['money'] as num).toDouble(),
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'orderSn': instance.orderSn,
      'type': instance.type,
      'status': instance.status,
      'unit': instance.unit,
      'amount': instance.amount,
      'name': instance.name,
      'money': instance.money,
    };
