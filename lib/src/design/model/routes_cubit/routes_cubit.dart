import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../driven/service/state_service.dart';
import '../../../../get_it_service_locator.dart';
import '../../../config/routes.dart';

part 'routes_state.dart';

/// 路由控制Cubit
class RoutesCubit extends Cubit<RoutesState> {
  RoutesCubit({required this.currentPage}) : super(RoutesState(currentPage: currentPage));
  final String currentPage;

  /// 判斷是否為根目錄換頁
  /// [name] 路由名稱
  /// [arguments] 傳送參數
  void changePage(String name, {Object? arguments}) {
    bool isRoots = Routes.roots.contains(name); // 是否為根目錄
    if (isRoots) {
      getIt<StateService>().navigatorState.pushNamedAndRemoveUntil(name, (route) => false, arguments: arguments);
    } else {
      getIt<StateService>().navigatorState.pushNamed(name, arguments: arguments);
    }
  }

  /// 返回上一頁
  void pop() {
    if (!Routes.roots.contains(state.currentPage)) {
      getIt<StateService>().navigatorState.pop(); // 不是根目錄就返回
    } else {
      throw ("已在第一頁");
    }
  }

  /// 更新當前路由，並檢查是否顯示導航欄
  /// [page] 路由名稱
  void updateCurrentRoutes(String? page) {
    print(page);
    emit(state.copyWith(currentPage: page));
  }

  /// 獲取當前路由
  String getCurrentPage() {
    return state.currentPage;
  }

  /// 獲取當前 page state function
  void setPageState(Function pageState) {
    emit(state.copyWith(pageSetState: pageState));
  }

  /// refresh page state
  void refreshPage(String locale) {
    state.pageSetState!(() {});
    emit(state.copyWith(locale: locale));
  }

  /// 是否可返回
  bool canPop() {
    return getIt<StateService>().navigatorState.canPop();
  }

  /// 首頁頁面切換
  /// [page]首頁類型
  /// [backHome] 是否回到首頁
  ///
  void changeLobbyPageWithInt(int page) {
    emit(state.copyWith(currentIndex: page));
  }
}
