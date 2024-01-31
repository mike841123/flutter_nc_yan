// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otc_order_pre_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtcOrderPreResponse _$OtcOrderPreResponseFromJson(Map<String, dynamic> json) =>
    OtcOrderPreResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : OtcOrderPreResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$OtcOrderPreResponseToJson(
        OtcOrderPreResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

OtcOrderPreResult _$OtcOrderPreResultFromJson(Map<String, dynamic> json) =>
    OtcOrderPreResult(
      username: json['username'] as String?,
      emailVerified: json['emailVerified'] as int?,
      phoneVerified: json['phoneVerified'] as int?,
      idCardVerified: json['idCardVerified'] as int?,
      transactions: (json['transactions'] as num?)?.toDouble(),
      otcCoinId: json['otcCoinId'] as int?,
      unit: json['unit'] as String?,
      price: (json['price'] as num?)?.toDouble(),
      number: (json['number'] as num?)?.toDouble(),
      payMode: json['payMode'] as String?,
      minLimit: (json['minLimit'] as num?)?.toDouble(),
      maxLimit: (json['maxLimit'] as num?)?.toDouble(),
      timeLimit: json['timeLimit'] as int?,
      country: json['country'] as String?,
      advertiseType: json['advertiseType'] as int?,
      remark: json['remark'] as String?,
      maxTradableAmount: (json['maxTradableAmount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$OtcOrderPreResultToJson(OtcOrderPreResult instance) =>
    <String, dynamic>{
      'username': instance.username,
      'emailVerified': instance.emailVerified,
      'phoneVerified': instance.phoneVerified,
      'idCardVerified': instance.idCardVerified,
      'transactions': instance.transactions,
      'otcCoinId': instance.otcCoinId,
      'unit': instance.unit,
      'price': instance.price,
      'number': instance.number,
      'payMode': instance.payMode,
      'minLimit': instance.minLimit,
      'maxLimit': instance.maxLimit,
      'timeLimit': instance.timeLimit,
      'country': instance.country,
      'advertiseType': instance.advertiseType,
      'remark': instance.remark,
      'maxTradableAmount': instance.maxTradableAmount,
    };
