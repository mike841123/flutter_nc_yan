import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_pre_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'otc_trade_state.dart';

class OtcTradeCubit extends Cubit<OtcTradeState> {
  OtcTradeCubit() : super(const OtcTradeState());

  void init(int id) {
    getOtcCoin(id);
  }

  void getOtcCoin(int id) async {
    OtcOrderPreResponse response = await getIt<ApiService>().getOrderPre(id);
    emit(state.copyWith(
      otcOrderPreResponse: response,
    ));
  }
}
