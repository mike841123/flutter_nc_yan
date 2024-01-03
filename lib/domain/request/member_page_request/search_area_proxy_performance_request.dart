class SearchAreaProxyPerformanceRequest {
  final int id;
  final int page;
  final int limit;
  final int? status;
  final String? endTime;
  final String productName;

  SearchAreaProxyPerformanceRequest({
    this.id = 0,
    this.page = 0,
    this.limit = 0,
    this.status = 0,
    this.endTime = "",
    this.productName = "",
  });
}
