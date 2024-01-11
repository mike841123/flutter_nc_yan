import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/public_response/upload_image_response.dart';
import 'package:yan_demo_fcm/src/config/app_config.dart';

import '../../../../domain/response/member_page_response/security_setting_response.dart';
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
