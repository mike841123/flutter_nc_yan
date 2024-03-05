import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/domain/response/public_response/asset_wallet_response.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';

part 'my_assets_state.dart';

class MyAssetsCubit extends Cubit<MyAssetsState> {
  MyAssetsCubit() : super(const MyAssetsState());

  void init() {
    getAssetWallet();
  }

  void getAssetWallet() async {
    emit(state.copyWith(status: MyAssetsStatus.initial));
    AssetWalletResponse response = await getIt<ApiService>().getAssetsWallet();
    emit(state.copyWith(
      assetWalletResponse: response,
      status: response.code == 0 ? MyAssetsStatus.success : MyAssetsStatus.failure,
    ));
  }

  double getTotalUsdtAsset() {
    double total = 0;
    for (int i = 0; i < state.assetWalletResponse!.data!.length; i++) {
      total +=
          (state.assetWalletResponse!.data![i].balance + state.assetWalletResponse!.data![i].frozenBalance) * state.assetWalletResponse!.data![i].coin!.usdRate;
    }
    return total;
  }

  double getTotalCnyAsset() {
    double total = 0;
    for (int i = 0; i < state.assetWalletResponse!.data!.length; i++) {
      total +=
          (state.assetWalletResponse!.data![i].balance + state.assetWalletResponse!.data![i].frozenBalance) * state.assetWalletResponse!.data![i].coin!.cnyRate;
    }
    return total;
  }

  void updateIsHideAsset() {
    emit(state.copyWith(isHideAsset: !state.isHideAsset));
  }

  void updateIsHideZeroAsset(bool value) {
    emit(state.copyWith(isHideZeroAsset: value));
  }

  void updateSearchText(String text) {
    emit(state.copyWith(searchText: text));
  }
}
