part of 'otc_trade_cubit.dart';

class OtcTradeState extends Equatable {
  const OtcTradeState({
    this.otcOrderPreResponse,
  });

  final OtcOrderPreResponse? otcOrderPreResponse;

  OtcTradeState copyWith({
    OtcOrderPreResponse? otcOrderPreResponse,
  }) {
    return OtcTradeState(
      otcOrderPreResponse: otcOrderPreResponse ?? this.otcOrderPreResponse,
    );
  }

  @override
  List<Object> get props => [
        otcOrderPreResponse ?? OtcOrderPreResponse(),
      ];
}
