import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/request/asset_flow_page_request/asset_flow_request.dart';

import '../../../../domain/response/asset_flow_page_response/asset_flow_response.dart';
import '../../../../domain/response/asset_flow_page_response/withdraw_coin_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'asset_flow_state.dart';

class AssetFlowCubit extends Cubit<AssetFlowState> {
  AssetFlowCubit() : super(const AssetFlowState());

  void init() {
    getAssetFlow(AssetFlowRequest(pageNo: 1, pageSize: 10));
    getWithdrawCoin();
  }

  void getAssetFlow(AssetFlowRequest assetFlowRequest, {bool isInit = true}) async {
    if (isInit) {
      emit(state.copyWith(
        status: AssetFlowStatus.initial,
        total: 0,
        page: 1,
      ));
      AssetFlowResponse response = await getIt<ApiService>().getAsset(assetFlowRequest);
      emit(state.copyWith(
        assetFlowList: response.data!.content,
        page: 1,
        total: response.data?.totalElements,
        status: AssetFlowStatus.success,
      ));
    } else {
      AssetFlowResponse response = await getIt<ApiService>().getAsset(assetFlowRequest);
      emit(state.copyWith(
        assetFlowList: List.of(state.assetFlowList as Iterable<Content>)..addAll(response.data!.content),
        page: state.page + 1,
        total: response.data?.totalElements,
      ));
    }
  }

  void getWithdrawCoin() async {
    WithdrawCoinResponse response = await getIt<ApiService>().getWithdrawCoin();
    emit(state.copyWith(
      withdrawCoinResponse: response,
    ));
  }
}
