part of 'otc_list_cubit.dart';

class OtcListState extends Equatable {
  const OtcListState({
    this.otcOrderPreResponse,
  });

  final OtcOrderPreResponse? otcOrderPreResponse;

  OtcListState copyWith({
    OtcOrderPreResponse? otcOrderPreResponse,
  }) {
    return OtcListState(
      otcOrderPreResponse: otcOrderPreResponse ?? this.otcOrderPreResponse,
    );
  }

  @override
  List<Object> get props => [
        otcOrderPreResponse ?? OtcOrderPreResponse(),
      ];
}
