import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/api_response.dart';
import 'package:yan_demo_fcm/domain/response/market_response/depth_response.dart';

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

  void getDepthData(String symbol) async {
    DepthResponse response = await getIt<ApiService>().getDepthData(symbol);
    List<DepthItem> ask = response.ask?.items ?? [];
    ask.sort((a, b) => b.amount.compareTo(a.amount)); // 大到小
    List<DepthItem> askList = ask.take(5).toList(); // 取出前五

    List<DepthItem> bid = response.bid?.items ?? [];
    ask.sort((a, b) => a.amount.compareTo(b.amount)); // 小到大
    List<DepthItem> bidList = bid.take(5).toList(); // 取出前五

    emit(state.copyWith(askList: askList, bidList: bidList));
  }

  /// 清除資料
  void clean() => emit(const MarketState(
        symbolList: [],
      ));
}
