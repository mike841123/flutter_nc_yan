import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/response/my_advertisement_page_response/otc_advertise_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'advertise_ad_state.dart';

class AdvertiseAdCubit extends Cubit<AdvertiseAdState> {
  AdvertiseAdCubit() : super(const AdvertiseAdState());

  void init() {
  }
}
