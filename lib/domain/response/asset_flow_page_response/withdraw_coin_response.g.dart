// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'withdraw_coin_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WithdrawCoinResponse _$WithdrawCoinResponseFromJson(
        Map<String, dynamic> json) =>
    WithdrawCoinResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WithdrawCoinItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      extend: json['extend'],
    );

Map<String, dynamic> _$WithdrawCoinResponseToJson(
        WithdrawCoinResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

WithdrawCoinItem _$WithdrawCoinItemFromJson(Map<String, dynamic> json) =>
    WithdrawCoinItem(
      unit: json['unit'] as String? ?? "",
    );

Map<String, dynamic> _$WithdrawCoinItemToJson(WithdrawCoinItem instance) =>
    <String, dynamic>{
      'unit': instance.unit,
    };
