part of 'market_cubit.dart';

class MarketState extends Equatable {
  const MarketState({
    this.symbolList = const [],
    this.usdtCnyRate = 1,
    this.askList = const [],
    this.bidList = const [],
  });

  final List<SymbolResponse> symbolList;
  final double usdtCnyRate;
  final List<DepthItem> askList;
  final List<DepthItem> bidList;

  MarketState copyWith({
    List<SymbolResponse>? symbolList,
    double? usdtCnyRate,
    List<DepthItem>? askList,
    List<DepthItem>? bidList,
  }) {
    return MarketState(
      symbolList: symbolList ?? this.symbolList,
      usdtCnyRate: usdtCnyRate ?? this.usdtCnyRate,
      askList: askList ?? this.askList,
      bidList: bidList ?? this.bidList,
    );
  }

  @override
  List<Object> get props => [symbolList, usdtCnyRate, askList, bidList];
}
