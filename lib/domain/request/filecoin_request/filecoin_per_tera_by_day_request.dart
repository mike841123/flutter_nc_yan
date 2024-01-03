class FilecoinPerTeraByDayRequest {
  final int sourceType;
  final String cid;
  final int page;
  final int size;

  FilecoinPerTeraByDayRequest({
    required this.sourceType,
    required this.cid,
    required this.page,
    required this.size,
  });
}
