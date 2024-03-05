// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetsWalletResponse _$AssetsWalletResponseFromJson(
        Map<String, dynamic> json) =>
    AssetsWalletResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AssetsWalletResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      extend: json['extend'],
    );

Map<String, dynamic> _$AssetsWalletResponseToJson(
        AssetsWalletResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

AssetsWalletResult _$AssetsWalletResultFromJson(Map<String, dynamic> json) =>
    AssetsWalletResult(
      id: json['id'] as int? ?? 0,
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      frozenBalance: (json['frozenBalance'] as num?)?.toDouble() ?? 0,
      toReleased: (json['toReleased'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AssetsWalletResultToJson(AssetsWalletResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'frozenBalance': instance.frozenBalance,
      'toReleased': instance.toReleased,
    };
