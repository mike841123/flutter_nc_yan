import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/request/otc_page_request/asset_flow_request.dart';
import '../../../../domain/response/otc_page_response/advertise_unit_response.dart';
import '../../../../domain/response/otc_page_response/otc_coin_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'otc_state.dart';

class OtcCubit extends Cubit<OtcState> {
  OtcCubit() : super(const OtcState());

  void init() {
    getOtcCoin();
    getAdvertiseUnit(AdvertiseUnitRequest(pageNo: 1, pageSize: 10, advertiseType: 1, unit: "USDT"));
  }

  void updateSwitchBtn(int value, int tabSelectedIndex) {
    getAdvertiseUnit(
      AdvertiseUnitRequest(
        pageNo: 1,
        pageSize: 10,
        advertiseType: value,
        unit: state.otcCoinResponse!.data![tabSelectedIndex].unit,
      ),
    );
    emit(state.copyWith(
      advertiseType: value,
    ));
  }

  void getAdvertiseUnit(AdvertiseUnitRequest advertiseUnitRequest, {bool isInit = true}) async {
    if (isInit) {
      emit(state.copyWith(
        status: OtcStatus.initial,
        total: 0,
        page: 1,
      ));
      AdvertiseUnitResponse response = await getIt<ApiService>().getAdvertiseUnit(advertiseUnitRequest);
      emit(state.copyWith(
        advertiseUnitList: response.data!.context,
        page: 1,
        total: response.data?.totalElements,
        status: OtcStatus.success,
      ));
    } else {
      AdvertiseUnitResponse response = await getIt<ApiService>().getAdvertiseUnit(advertiseUnitRequest);
      emit(state.copyWith(
        advertiseUnitList: List.of(state.advertiseUnitList as Iterable<Context>)..addAll(response.data!.context),
        page: state.page + 1,
        total: response.data?.totalElements,
      ));
    }
  }

  void getOtcCoin() async {
    OtcCoinResponse response = await getIt<ApiService>().getOtcCoin();
    emit(state.copyWith(
      otcCoinResponse: response,
    ));
  }

  List<String> getPayModeList(String payModeReturn) {
    String payMode = payModeReturn;
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
