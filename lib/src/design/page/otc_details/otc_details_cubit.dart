import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/otc_trade_request.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_pre_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/normal_response.dart';
import 'package:yan_demo_fcm/src/design/page/otc/otc_cubit.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'otc_details_state.dart';

class OtcDetailsCubit extends Cubit<OtcDetailsState> {
  OtcDetailsCubit() : super(const OtcDetailsState());

  void init(int id) {
    getOtcCoin(id);
  }

  void getOtcCoin(int id) async {
  }
}
