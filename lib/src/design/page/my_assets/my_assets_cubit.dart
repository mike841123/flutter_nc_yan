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
}
