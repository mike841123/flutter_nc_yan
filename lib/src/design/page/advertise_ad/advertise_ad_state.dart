part of 'advertise_ad_cubit.dart';

class AdvertiseAdState extends Equatable {
  const AdvertiseAdState({
    this.otcAdvertiseList = const [],
  });

  final List<Content>? otcAdvertiseList;

  AdvertiseAdState copyWith({
    List<Content>? otcAdvertiseList,
  }) {
    return AdvertiseAdState(
      otcAdvertiseList: otcAdvertiseList ?? this.otcAdvertiseList,
    );
  }

  @override
  List<Object> get props => [otcAdvertiseList ?? []];
}
