import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/announcement_details_response.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import '../../../../domain/response/home_page_response/details_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit() : super(const DetailsState());

  void init(DetailsArguments arguments) {
    getDetails(arguments);
  }

  void getDetails(DetailsArguments arguments) async {
    emit(state.copyWith(status: DetailsStatus.initial));
    switch (arguments.type) {
      case DetailsType.help:
        DetailsResponse response = await getIt<ApiService>().getDetails("CN", arguments.id);
        if (response.code == 0) {
          emit(state.copyWith(status: DetailsStatus.success, detailsResponse: response));
        }
      case DetailsType.announcement:
        AnnouncementDetailsResponse response = await getIt<ApiService>().getAnnouncementMore(arguments.id, "CN");
        if (response.code == 0) {
          emit(state.copyWith(status: DetailsStatus.success, announcementDetailsResponse: response));
        }
    }
  }
}
