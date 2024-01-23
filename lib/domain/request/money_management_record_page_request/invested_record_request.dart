class InvestedRecordRequest {
  final int? pageNo;
  final int? pageSize;
  final String? startTime;
  final String? endTime;
  final String? coinUnit;
  final String? optionType;
  final String? status;

  InvestedRecordRequest({
    this.pageNo,
    this.pageSize,
    this.startTime = "",
    this.endTime = "",
    this.coinUnit = "",
    this.optionType = "",
    this.status = "",
  });
}
