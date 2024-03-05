part of 'my_assets_cubit.dart';

enum MyAssetsStatus { initial, success, failure }

class MyAssetsState extends Equatable {
  const MyAssetsState({
    this.status = MyAssetsStatus.initial,
    this.assetWalletResponse,
  });

  final MyAssetsStatus status;
  final AssetWalletResponse? assetWalletResponse;

  MyAssetsState copyWith({
    MyAssetsStatus? status,
    AssetWalletResponse? assetWalletResponse,
  }) {
    return MyAssetsState(
      assetWalletResponse: assetWalletResponse ?? this.assetWalletResponse,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props =>
      [
        assetWalletResponse ?? AssetWalletResponse(),
        status,
      ];
}
