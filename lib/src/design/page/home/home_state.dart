part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.advertiseResponse,
    this.announcementResponse,
  });

  final AdvertiseResponse? advertiseResponse;
  final AnnouncementResponse? announcementResponse;

  HomeState copyWith({
    AdvertiseResponse? advertiseResponse,
    AnnouncementResponse? announcementResponse,
  }) {
    return HomeState(
      advertiseResponse: advertiseResponse ?? this.advertiseResponse,
      announcementResponse: announcementResponse ?? this.announcementResponse,
    );
  }

  @override
  List<Object> get props => [
        advertiseResponse ?? AdvertiseResponse(),
        announcementResponse ?? AnnouncementResponse(),
      ];
}
