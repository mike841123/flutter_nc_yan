part of 'asset_flow_cubit.dart';

class AssetFlowState extends Equatable {
  const AssetFlowState({
    this.assetFlowList = const [],
    this.page = 1,
    this.total = 0,
    this.withdrawCoinResponse,
    this.status = AssetFlowStatus.initial,
  });

  final List<Content>? assetFlowList;
  final int page;
  final int total;
  final WithdrawCoinResponse? withdrawCoinResponse;
  final AssetFlowStatus status;

  AssetFlowState copyWith({
    List<Content>? assetFlowList,
    int? page,
    int? total,
    WithdrawCoinResponse? withdrawCoinResponse,
    AssetFlowStatus? status,
  }) {
    return AssetFlowState(
      assetFlowList: assetFlowList ?? this.assetFlowList,
      page: page ?? this.page,
      total: total ?? this.total,
      withdrawCoinResponse: withdrawCoinResponse ?? this.withdrawCoinResponse,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [assetFlowList ?? [], page, total, withdrawCoinResponse ?? WithdrawCoinResponse(), status];
}

@immutable
class OpTypeLabel {
  const OpTypeLabel(this.label);

  final OpType label;
}

enum OpType {
  recharge("充值", 0),
  cash("提現", 1),
  transfer("轉帳", 2);

  const OpType(this.value, this.type);

  final String value;
  final int type;
}

enum AssetFlowStatus { initial, success, failure }
