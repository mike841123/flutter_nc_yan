import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/response/home_page_response/advertise_response.dart';
import '../../../../domain/response/home_page_response/announcement_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(const HomeState());

  void init() {
    getAdvertise();
    getAnnouncement();
  }

  /// 首頁輪播圖
  void getAdvertise() async {
    AdvertiseResponse response = await getIt<ApiService>().getAdvertise(1, "CN");
    emit(state.copyWith(advertiseResponse: response));
  }

  /// 首頁公告
  void getAnnouncement() async {
    AnnouncementResponse response = await getIt<ApiService>().getAnnouncement(1, 6, "CN");
    emit(state.copyWith(announcementResponse: response));
  }
}
