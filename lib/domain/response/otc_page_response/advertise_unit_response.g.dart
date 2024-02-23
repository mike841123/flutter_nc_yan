// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'advertise_unit_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AdvertiseUnitResponse _$AdvertiseUnitResponseFromJson(
        Map<String, dynamic> json) =>
    AdvertiseUnitResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : AdvertiseUnitResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$AdvertiseUnitResponseToJson(
        AdvertiseUnitResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

AdvertiseUnitResult _$AdvertiseUnitResultFromJson(Map<String, dynamic> json) =>
    AdvertiseUnitResult(
      context: (json['context'] as List<dynamic>?)
              ?.map((e) => Context.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      totalElements: json['totalElements'] as int? ?? 0,
      totalPages: json['totalPages'] as int? ?? 0,
    );

Map<String, dynamic> _$AdvertiseUnitResultToJson(
        AdvertiseUnitResult instance) =>
    <String, dynamic>{
      'context': instance.context,
      'totalElements': instance.totalElements,
      'totalPages': instance.totalPages,
    };

Context _$ContextFromJson(Map<String, dynamic> json) => Context(
      advType: json['advType'] as int? ?? 0,
      advertiseId: json['advertiseId'] as int? ?? 0,
      advertiseType: json['advertiseType'] as int? ?? 0,
      avatar: json['avatar'] as String? ?? "",
      transactions: json['transactions'] as int? ?? 0,
      price: json['price'] as String? ?? "",
      remainAmount: (json['remainAmount'] as num?)?.toDouble() ?? 0,
      maxLimit: (json['maxLimit'] as num?)?.toDouble() ?? 0,
      minLimit: (json['minLimit'] as num?)?.toDouble() ?? 0,
      memberName: json['memberName'] as String? ?? "",
      coinId: json['coinId'] as int? ?? 0,
      unit: json['unit'] as String? ?? "",
      payMode: json['payMode'] as String? ?? "",
    );

Map<String, dynamic> _$ContextToJson(Context instance) => <String, dynamic>{
      'advType': instance.advType,
      'advertiseId': instance.advertiseId,
      'advertiseType': instance.advertiseType,
      'avatar': instance.avatar,
      'transactions': instance.transactions,
      'price': instance.price,
      'remainAmount': instance.remainAmount,
      'maxLimit': instance.maxLimit,
      'minLimit': instance.minLimit,
      'memberName': instance.memberName,
      'coinId': instance.coinId,
      'unit': instance.unit,
      'payMode': instance.payMode,
    };
