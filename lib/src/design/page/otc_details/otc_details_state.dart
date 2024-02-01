part of 'otc_details_cubit.dart';

class OtcDetailsState extends Equatable {
  const OtcDetailsState({
    this.otcOrderPreResponse,
  });

  final OtcOrderPreResponse? otcOrderPreResponse;

  OtcDetailsState copyWith({
    OtcOrderPreResponse? otcOrderPreResponse,
  }) {
    return OtcDetailsState(
      otcOrderPreResponse: otcOrderPreResponse ?? this.otcOrderPreResponse,
    );
  }

  @override
  List<Object> get props => [
        otcOrderPreResponse ?? OtcOrderPreResponse(),
      ];
}
