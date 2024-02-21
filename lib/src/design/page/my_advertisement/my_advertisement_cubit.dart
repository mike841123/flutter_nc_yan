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

  void getOtcAdvertise(int pageNo) async {
    OtcAdvertiseResponse response = await getIt<ApiService>().getOtcAdvertise(pageNo, 10);
    emit(state.copyWith(
      otcAdvertiseResponse: response,
    ));
  }

}
