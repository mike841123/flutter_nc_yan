import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/otc_order_request.dart';
import 'package:yan_demo_fcm/domain/response/otc_page_response/otc_order_pre_response.dart';
import '../../../../domain/response/otc_page_response/otc_order_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'otc_list_state.dart';

class OtcListCubit extends Cubit<OtcListState> {
  OtcListCubit() : super(const OtcListState());

  void init() {
    getOtcOrder(OtcOrderRequest(
      pageNo: 1,
      pageSize: 10,
      status: OrderStatus.unpaid.value,
    ));
  }

  void getOtcOrder(OtcOrderRequest request, {bool isInit = true}) async {
    if (isInit) {
      emit(state.copyWith(
        status: OtcListStatus.initial,
        total: 0,
        page: 0,
      ));
      OtcOrderResponse response = await getIt<ApiService>().getOtcOrder(request);
      emit(state.copyWith(
        otcOrderList: response.data?.content,
        page: 0,
        total: response.data?.totalElements,
        status: OtcListStatus.success,
      ));
    } else {
      OtcOrderResponse response = await getIt<ApiService>().getOtcOrder(request);
      emit(state.copyWith(
        otcOrderList: List.of(state.otcOrderList as Iterable<Content>)..addAll(response.data!.content),
        page: state.page + 1,
        total: response.data?.totalElements,
      ));
    }
  }

  String getOrderStatusText(OrderStatus status) {
    switch (status) {
      case OrderStatus.unpaid:
        return "未付款";
      case OrderStatus.paid:
        return "已付款";
      case OrderStatus.finish:
        return "已完成";
      case OrderStatus.cancel:
        return "已取消";
      case OrderStatus.appeal:
        return "申訴中";
    }
  }
}
