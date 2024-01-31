import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/public_response/asset_wallet_response.dart';

import '../../../../domain/response/member_page_response/security_setting_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'user_state.dart';

///使用者資料 Cubit
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(const UserState());

  /// 初始化刷新使用者資料
  void init() async {
    getBalance();
    updateUserData();
  }

  void getBalance() async {
    AssetWalletResponse response = await getIt<ApiService>().getBalance();
    double balance = 0;
    if (response.code == 0) {
      for (int i = 0; i < response.data!.length; i++) {
        balance += response.data![i].balance;
      }
      emit(state.copyWith(balance: balance));
    }
  }

  void updateUserData() async {
    SecuritySettingResponse response = await getIt<ApiService>().getUserInfo();
    emit(state.copyWith(userData: response.data as SecuritySettingResult));
  }

  /// 獲取使用者資料
  SecuritySettingResult? getUser() {
    return state.userData;
  }

  /// 清除資料
  void clean() => emit(UserState(
        balance: 0,
        userData: SecuritySettingResult(),
      ));
}
