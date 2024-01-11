// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_flow_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetFlowResponse _$AssetFlowResponseFromJson(Map<String, dynamic> json) =>
    AssetFlowResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : AssetFlowResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$AssetFlowResponseToJson(AssetFlowResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

AssetFlowResult _$AssetFlowResultFromJson(Map<String, dynamic> json) =>
    AssetFlowResult(
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
    );

Map<String, dynamic> _$AssetFlowResultToJson(AssetFlowResult instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      createTime: json['createTime'] as String? ?? "",
      fee: (json['fee'] as num?)?.toDouble() ?? 0,
      realFee: json['realFee'] as String? ?? "",
      discountFee: json['discountFee'] as String? ?? "",
      symbol: json['symbol'] as String? ?? "",
      flag: json['flag'] as int? ?? 0,
      type: json['type'] as int? ?? 0,
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'amount': instance.amount,
      'createTime': instance.createTime,
      'fee': instance.fee,
      'realFee': instance.realFee,
      'discountFee': instance.discountFee,
      'symbol': instance.symbol,
      'flag': instance.flag,
      'type': instance.type,
    };
