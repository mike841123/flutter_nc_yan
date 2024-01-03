class FilecoinEarningsDetailRequest {
  final int sourceType;
  final String cid;
  final int page;
  final int? size;

  FilecoinEarningsDetailRequest({
    required this.sourceType,
    required this.cid,
    required this.page,
    this.size,
  });
}