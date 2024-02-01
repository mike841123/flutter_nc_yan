part of 'otc_trade_cubit.dart';

class OtcTradeState extends Equatable {
  const OtcTradeState({
    this.otcOrderPreResponse,
    this.otcTradeResponse,
  });

  final OtcOrderPreResponse? otcOrderPreResponse;
  final NormalResponse? otcTradeResponse;

  OtcTradeState copyWith({
    OtcOrderPreResponse? otcOrderPreResponse,
    NormalResponse? otcTradeResponse,
  }) {
    return OtcTradeState(
      otcOrderPreResponse: otcOrderPreResponse ?? this.otcOrderPreResponse,
      otcTradeResponse: otcTradeResponse ?? this.otcTradeResponse,
    );
  }

  @override
  List<Object> get props => [
        otcOrderPreResponse ?? OtcOrderPreResponse(),
        otcTradeResponse ?? NormalResponse(),
      ];
}
