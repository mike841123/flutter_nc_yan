import 'package:json_annotation/json_annotation.dart';
part 'symbol_response.g.dart';

@JsonSerializable()
class SymbolResponse {
  SymbolResponse({
    this.symbol = "",
    this.usdRate = 0,
    this.chg = 0,
    this.volume = 0,
  });

  String symbol;
  double usdRate;
  double chg;
  double volume;

  factory SymbolResponse.fromJson(Map<String, dynamic> json) => _$SymbolResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SymbolResponseToJson(this);
}
