// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invested_record_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InvestedRecordResponse _$InvestedRecordResponseFromJson(
        Map<String, dynamic> json) =>
    InvestedRecordResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : InvestedRecordResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$InvestedRecordResponseToJson(
        InvestedRecordResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

InvestedRecordResult _$InvestedRecordResultFromJson(
        Map<String, dynamic> json) =>
    InvestedRecordResult(
      content: (json['content'] as List<dynamic>?)
              ?.map((e) => Content.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
      number: json['number'] as int? ?? 0,
    );

Map<String, dynamic> _$InvestedRecordResultToJson(
        InvestedRecordResult instance) =>
    <String, dynamic>{
      'content': instance.content,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
      'number': instance.number,
    };

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
      id: json['id'] as int? ?? 0,
      investedAmount: (json['investedAmount'] as num?)?.toDouble() ?? 0,
      annualRate: (json['annualRate'] as num?)?.toDouble() ?? 0,
      totalInterestAmount: json['totalInterestAmount'] as String? ?? "",
      status: json['status'] as int? ?? 0,
      coinUnit: json['coinUnit'] as String? ?? "",
      optionType: json['optionType'] as int? ?? 0,
      orderId: json['orderId'] as String? ?? "",
      legalDays: json['legalDays'] as int? ?? 0,
      createTime: json['createTime'] as String? ?? "",
      redeemDate: json['redeemDate'] as String? ?? "",
      startDate: json['startDate'] as String? ?? "",
      endDate: json['endDate'] as String? ?? "",
    );

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'investedAmount': instance.investedAmount,
      'annualRate': instance.annualRate,
      'totalInterestAmount': instance.totalInterestAmount,
      'status': instance.status,
      'coinUnit': instance.coinUnit,
      'optionType': instance.optionType,
      'orderId': instance.orderId,
      'legalDays': instance.legalDays,
      'startDate': instance.startDate,
      'redeemDate': instance.redeemDate,
      'createTime': instance.createTime,
      'endDate': instance.endDate,
    };
