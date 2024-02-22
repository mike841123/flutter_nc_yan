class OtcOrderRequest {
  final int pageNo;
  final int pageSize;
  final int status;

  OtcOrderRequest({
    required this.pageNo,
    required this.pageSize,
    required this.status,
  });
}
