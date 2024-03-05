part of 'home_cubit.dart';

class HomeState extends Equatable {
  final AdvertiseResponse? advertiseResponse;
  final AnnouncementResponse? announcementResponse;
  final List<SymbolResponse> symbolList;

  const HomeState({
    this.advertiseResponse,
    this.announcementResponse,
    this.symbolList = const [],
  });

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
