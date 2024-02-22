part of 'otc_details_cubit.dart';

class OtcDetailsState extends Equatable {
  const OtcDetailsState({
    this.otcOrderDetailResult,
  });

  final OtcOrderDetailResult? otcOrderDetailResult;

  OtcDetailsState copyWith({
    OtcOrderDetailResult? otcOrderDetailResult,
  }) {
    return OtcDetailsState(
      otcOrderDetailResult: otcOrderDetailResult ?? this.otcOrderDetailResult,
    );
  }

  @override
  List<Object> get props => [
        otcOrderDetailResult ?? OtcOrderDetailResult(),
      ];
}
