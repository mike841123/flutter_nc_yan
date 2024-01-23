import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/api_response.dart';
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

  String getRate(List<dynamic> rateList) {
    if(rateList.length == 1) {
      return "${(rateList.first["annualRate"] * 100).toStringAsFixed(2)}%";
    } else {
      return "${(rateList.first["annualRate"] * 100).toStringAsFixed(2)}% ~ ${(rateList[rateList.length - 1]["annualRate"] * 100).toStringAsFixed(2)}%";
    }
  }
}
