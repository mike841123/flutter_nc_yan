// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'symbol_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SymbolResponse _$SymbolResponseFromJson(Map<String, dynamic> json) =>
    SymbolResponse(
      symbol: json['symbol'] as String? ?? "",
      usdRate: (json['usdRate'] as num?)?.toDouble() ?? 0,
      chg: (json['chg'] as num?)?.toDouble() ?? 0,
      volume: (json['volume'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$SymbolResponseToJson(SymbolResponse instance) =>
    <String, dynamic>{
      'symbol': instance.symbol,
      'usdRate': instance.usdRate,
      'chg': instance.chg,
      'volume': instance.volume,
    };
