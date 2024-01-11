part of 'my_advertisement_cubit.dart';

class MyAdvertisementState extends Equatable {
  const MyAdvertisementState({
    this.otcAdvertiseResponse,
  });

  final OtcAdvertiseResponse? otcAdvertiseResponse;

  MyAdvertisementState copyWith({
    OtcAdvertiseResponse? otcAdvertiseResponse,
  }) {
    return MyAdvertisementState(otcAdvertiseResponse: otcAdvertiseResponse ?? this.otcAdvertiseResponse);
  }

  @override
  List<Object> get props => [otcAdvertiseResponse ?? OtcAdvertiseResponse()];
}
