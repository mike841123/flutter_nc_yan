part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.advertiseResponse,
    this.announcementResponse,
    this.symbolList = const [],
  });

  final AdvertiseResponse? advertiseResponse;
  final AnnouncementResponse? announcementResponse;
  final List<SymbolResponse> symbolList;

  HomeState copyWith({
    AdvertiseResponse? advertiseResponse,
    AnnouncementResponse? announcementResponse,
    List<SymbolResponse>? symbolList,
  }) {
    return HomeState(
      advertiseResponse: advertiseResponse ?? this.advertiseResponse,
      announcementResponse: announcementResponse ?? this.announcementResponse,
      symbolList: symbolList ?? this.symbolList,
    );
  }

  @override
  List<Object> get props => [
        advertiseResponse ?? AdvertiseResponse(),
        announcementResponse ?? AnnouncementResponse(),
        symbolList,
      ];
}
