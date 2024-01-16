import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/request/asset_flow_page_request/asset_flow_request.dart';
import 'package:yan_demo_fcm/domain/response/api_response.dart';
import 'package:yan_demo_fcm/domain/response/invested_rate_response.dart';

import '../../../../domain/response/asset_flow_page_response/asset_flow_response.dart';
import '../../../../domain/response/asset_flow_page_response/withdraw_coin_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'money_management_state.dart';

class MoneyManagementCubit extends Cubit<MoneyManagementState> {
  MoneyManagementCubit() : super(const MoneyManagementState());

  void init() {
    getInvestedRate();
  }

  void getInvestedRate() async {
    ApiResponse response = await getIt<ApiService>().getInvestedRate();
    emit(state.copyWith(
      investedRateResponse: response,
    ));
  }
}
