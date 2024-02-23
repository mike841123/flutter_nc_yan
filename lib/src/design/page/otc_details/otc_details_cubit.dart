import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_detail_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/normal_response.dart';
import '../../../../domain/response/otc_page_response/otc_order_pay_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'otc_details_state.dart';

class OtcDetailsCubit extends Cubit<OtcDetailsState> {
  OtcDetailsCubit() : super(const OtcDetailsState());

  void init(String id) {
    getOtcOrderDetails(id);
  }

  void getOtcOrderDetails(String id) async {
    OtcOrderDetailResponse response = await getIt<ApiService>().getOctOrderDetail(int.parse(id));
    emit(state.copyWith(
      otcOrderDetailResult: response.data,
    ));
  }

  void otcOrderCancel(String id, Function completedFunc) async {
    NormalResponse response = await getIt<ApiService>().otcOrderCancel(int.parse(id));
    if (response.code == 0) {
      completedFunc();
      getOtcOrderDetails(id);
    }
  }

  void otcOrderPay(String id, Function completedFunc) async {
    OtcOrderPayResponse response = await getIt<ApiService>().otcOrderPay(int.parse(id));
    if (response.code == 0) {
      completedFunc();
      getOtcOrderDetails(id);
    }
  }

  String getOrderTypeText(int type) {
    switch (type) {
      case 1:
        return "未付款";
      case 2:
        return "已付款";
      case 3:
        return "已完成";
      case 0:
        return "已取消";
      case 4:
        return "申訴中";
      default:
        return "";
    }
  }
}
