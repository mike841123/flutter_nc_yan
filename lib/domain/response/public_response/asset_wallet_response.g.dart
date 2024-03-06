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
      id: json['id'] as int? ?? 0,
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      frozenBalance: (json['frozenBalance'] as num?)?.toDouble() ?? 0,
      toReleased: (json['toReleased'] as num?)?.toDouble() ?? 0,
      coin: json['coin'] == null
          ? null
          : Coin.fromJson(json['coin'] as Map<String, dynamic>),
      address: json['address'] as String? ?? "",
    );

Map<String, dynamic> _$AssetWalletResultToJson(AssetWalletResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'balance': instance.balance,
      'frozenBalance': instance.frozenBalance,
      'toReleased': instance.toReleased,
      'coin': instance.coin,
      'address': instance.address,
    };

Coin _$CoinFromJson(Map<String, dynamic> json) => Coin(
      unit: json['unit'] as String? ?? "",
      usdRate: (json['usdRate'] as num?)?.toDouble() ?? 0,
      cnyRate: (json['cnyRate'] as num?)?.toDouble() ?? 0,
      infolink: json['infolink'] as String? ?? "",
      minRechargeAmount: (json['minRechargeAmount'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$CoinToJson(Coin instance) => <String, dynamic>{
      'unit': instance.unit,
      'cnyRate': instance.cnyRate,
      'usdRate': instance.usdRate,
      'infolink': instance.infolink,
      'minRechargeAmount': instance.minRechargeAmount,
    };
