import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/money_management_response/invested_record_response.dart';
import 'package:yan_demo_fcm/domain/response/public_response/normal_response.dart';

import '../../../../domain/request/money_management_record_page_request/invested_record_request.dart';

import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'money_management_record_state.dart';

class MoneyManagementRecordCubit extends Cubit<MoneyManagementRecordState> {
  MoneyManagementRecordCubit() : super(const MoneyManagementRecordState());

  void init() {
    getInvestedRecord(InvestedRecordRequest(pageNo: 1, pageSize: 10));
  }

  // 贖回
  void investedRedeem(int id, int status) async {
    NormalResponse response = await getIt<ApiService>().investedRedeem(id, status);
    if(response.code == 0) {
      // 贖回成功刷新列表
      getInvestedRecord(
        InvestedRecordRequest(
          pageNo: 1,
          pageSize: state.total, // 刷新全部
          // symbol: selectedCoin == null ? null : selectedCoin!.unit,
          // type: selectedOpType == null ? null : selectedOpType!.label.type,
          // startTime: firstDate.text.isEmpty ? null : firstDate.text,
          // endTime: lastDate.text.isEmpty ? null : lastDate.text,
        )
      );
    }
  }

  void getInvestedRecord(InvestedRecordRequest request, {bool isInit = true}) async {
    if (isInit) {
      emit(state.copyWith(
        total: 0,
        page: 1,
      ));
      InvestedRecordResponse response = await getIt<ApiService>().getInvestedRecord(request);
      emit(state.copyWith(
        investedRecordList: response.data!.content,
        page: 1,
        total: response.data?.totalElements,
        status: MoneyManagementRecordStatus.success,
      ));
    } else {
      InvestedRecordResponse response = await getIt<ApiService>().getInvestedRecord(request);
      emit(state.copyWith(
        investedRecordList: List.of(state.investedRecordList as Iterable<Content>)..addAll(response.data!.content),
        page: state.page + 1,
        total: response.data?.totalElements,
      ));
    }
  }

  String getInvestedRecordType(int type) {
    switch (type) {
      case 1:
        return "有效";
      case 2:
        return "到期自動贖回";
      case 3:
        return "手動贖回";
      case 4:
        return "立即贖回";
      default:
        return "";
    }
  }
}
