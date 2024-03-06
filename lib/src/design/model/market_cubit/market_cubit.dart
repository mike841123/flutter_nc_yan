import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/api_response.dart';

import '../../../../domain/response/home_page_response/symbol_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'market_state.dart';

///Market Cubit
class MarketCubit extends Cubit<MarketState> {
  MarketCubit() : super(const MarketState());

  void getMarketSymbolList() async {
    List<SymbolResponse> response = await getIt<ApiService>().getMarketSymbolList();
    emit(state.copyWith(symbolList: response));
  }

  void getUsdtCnyRate() async {
    ApiResponse<double> response = await getIt<ApiService>().getUsdtCnyRate();
    emit(state.copyWith(usdtCnyRate: response.data ?? 0));
  }

  /// 清除資料
  void clean() => emit(const MarketState(
        symbolList: [],
      ));
}
