part of 'market_cubit.dart';

class MarketState extends Equatable {
  const MarketState({
    this.securitySettingResponse,
    this.promotionResponse,
  });

  final SecuritySettingResponse? securitySettingResponse;
  final PromotionResponse? promotionResponse;

  MarketState copyWith({
    SecuritySettingResponse? securitySettingResponse,
    PromotionResponse? promotionResponse,
  }) {
    return MarketState(
      securitySettingResponse: securitySettingResponse ?? this.securitySettingResponse,
      promotionResponse: promotionResponse ?? this.promotionResponse,
    );
  }

  @override
  List<Object> get props => [
        securitySettingResponse ?? SecuritySettingResponse(),
        promotionResponse ?? PromotionResponse(),
      ];
}
