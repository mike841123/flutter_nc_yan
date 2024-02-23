import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/response/my_advertisement_page_response/otc_advertise_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'my_advertisement_state.dart';

class MyAdvertisementCubit extends Cubit<MyAdvertisementState> {
  MyAdvertisementCubit() : super(const MyAdvertisementState());

  void init() {
    getOtcAdvertise(1);
  }

  void getOtcAdvertise(int pageNo, {bool isInit = true}) async {
    if (isInit) {
      emit(state.copyWith(
        status: MyAdvertisementStatus.initial,
        total: 0,
        page: 1,
      ));
      OtcAdvertiseResponse response = await getIt<ApiService>().getOtcAdvertise(pageNo, 10);
      emit(state.copyWith(
        otcAdvertiseList: response.data!.content,
        page: 1,
        total: response.data?.totalElements,
        status: MyAdvertisementStatus.success,
      ));
    } else {
      OtcAdvertiseResponse response = await getIt<ApiService>().getOtcAdvertise(pageNo, 10);
      emit(state.copyWith(
        otcAdvertiseList: List.of(state.otcAdvertiseList as Iterable<Content>)..addAll(response.data!.content),
        page: state.page + 1,
        total: response.data?.totalElements,
      ));
    }
  }
}
