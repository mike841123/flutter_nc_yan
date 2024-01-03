class ChainWithdrawRequest {
  final String? address;
  final int? assetTypeId;
  final String? chainType;
  final String? payPassword;
  final String? remarks;
  final double? size;
  final int? transType;
  final String? uid;

  ChainWithdrawRequest({
    this.address,
    this.assetTypeId,
    this.chainType,
    this.payPassword,
    this.remarks,
    this.size,
    this.transType,
    this.uid,
  });
}
