part of 'my_assets_cubit.dart';

enum MyAssetsStatus { initial, success, failure }

class MyAssetsState extends Equatable {
  const MyAssetsState({
    this.status = MyAssetsStatus.initial,
    this.assetWalletResponse,
    this.isHideAsset = false,
    this.isHideZeroAsset = false,
    this.searchText = "",
  });

  final MyAssetsStatus status;
  final AssetWalletResponse? assetWalletResponse;
  final bool isHideAsset;
  final bool isHideZeroAsset;
  final String searchText;

  MyAssetsState copyWith({
    MyAssetsStatus? status,
    AssetWalletResponse? assetWalletResponse,
    bool? isHideAsset,
    bool? isHideZeroAsset,
    String? searchText,
  }) {
    return MyAssetsState(
      assetWalletResponse: assetWalletResponse ?? this.assetWalletResponse,
      status: status ?? this.status,
      isHideAsset: isHideAsset ?? this.isHideAsset,
      isHideZeroAsset: isHideZeroAsset ?? this.isHideZeroAsset,
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object> get props => [assetWalletResponse ?? AssetWalletResponse(), status, isHideAsset, isHideZeroAsset, searchText];
}
