class AssetFlowRequest {
  final int? pageNo;
  final int? pageSize;
  final String? startTime;
  final String? endTime;
  final int? memberId;
  final String? symbol;
  final int? type;

  AssetFlowRequest({
    this.pageNo,
    this.pageSize,
    this.startTime,
    this.endTime,
    this.memberId,
    this.symbol,
    this.type,
  });
}
