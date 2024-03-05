import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/announcement_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'announcement_state.dart';

class AnnouncementCubit extends Cubit<AnnouncementState> {
  AnnouncementCubit() : super(const AnnouncementState());

  void init() {
    getAnnouncement();
  }

  void getAnnouncement() async {
    emit(state.copyWith(status: AnnouncementStatus.initial));
    AnnouncementResponse response = await getIt<ApiService>().getAnnouncement(1, 100, "CN");
    emit(state.copyWith(
      contentList: response.data?.content,
      status: response.code == 0 ? AnnouncementStatus.success : AnnouncementStatus.failure,
    ));
  }
}
