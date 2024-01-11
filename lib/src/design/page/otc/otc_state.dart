part of 'otc_cubit.dart';

class OtcState extends Equatable {
  const OtcState({
    this.otcAdvertiseResponse,
  });

  final OtcAdvertiseResponse? otcAdvertiseResponse;

  OtcState copyWith({
    OtcAdvertiseResponse? otcAdvertiseResponse,
  }) {
    return OtcState(otcAdvertiseResponse: otcAdvertiseResponse ?? this.otcAdvertiseResponse);
  }

  @override
  List<Object> get props => [otcAdvertiseResponse ?? OtcAdvertiseResponse()];
}
