import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/otc_trade_request.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_pre_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/normal_response.dart';
import 'package:yan_demo_fcm/src/design/page/otc/otc_cubit.dart';
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

  void otcTrade(OtcAdvertiseType type, OtcTradeRequest request) async {
    NormalResponse otcTradeResponse = NormalResponse();
    switch (type) {
      case OtcAdvertiseType.buy:
        otcTradeResponse = await getIt<ApiService>().otcOrderBuy(request);
        break;
      case OtcAdvertiseType.sell:
        otcTradeResponse = await getIt<ApiService>().otcOrderSell(request);
        break;
    }
    if(otcTradeResponse.code == 0) {
      print(otcTradeResponse.data);
      print("跳轉otc detail");
    }
    emit(state.copyWith(
      otcTradeResponse: otcTradeResponse,
    ));
  }

  List<String> getPayModeList() {
    String payMode = state.otcOrderPreResponse?.data?.payMode ?? "";
    List<String> list = payMode.split(",");
    return list;
  }

  String getPayModeImageSrc(String payMode) {
    switch (payMode) {
      case "微信":
        return "wechat";
      case "支付宝":
        return "alipay";
      case "银联":
        return "bank";
      default:
        return "";
    }
  }
}
