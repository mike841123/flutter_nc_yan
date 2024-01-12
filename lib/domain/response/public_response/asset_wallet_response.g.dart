// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_wallet_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetWalletResponse _$AssetWalletResponseFromJson(Map<String, dynamic> json) =>
    AssetWalletResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => AssetWalletResult.fromJson(e as Map<String, dynamic>))
          .toList(),
      extend: json['extend'],
    );

Map<String, dynamic> _$AssetWalletResponseToJson(
        AssetWalletResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

AssetWalletResult _$AssetWalletResultFromJson(Map<String, dynamic> json) =>
    AssetWalletResult(
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$AssetWalletResultToJson(AssetWalletResult instance) =>
    <String, dynamic>{
      'balance': instance.balance,
    };
