part of 'market_cubit.dart';

class MarketState extends Equatable {
  const MarketState({
    this.symbolList = const [],
    this.usdtCnyRate = 1,
  });

  final List<SymbolResponse> symbolList;
  final double usdtCnyRate;

  MarketState copyWith({
    List<SymbolResponse>? symbolList,
    double? usdtCnyRate,
  }) {
    return MarketState(
      symbolList: symbolList ?? this.symbolList,
      usdtCnyRate: usdtCnyRate ?? this.usdtCnyRate,
    );
  }

  @override
  List<Object> get props => [symbolList, usdtCnyRate];
}
