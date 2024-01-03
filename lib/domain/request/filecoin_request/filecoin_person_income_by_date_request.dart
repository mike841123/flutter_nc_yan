class FilecoinPersonIncomeByDateRequest {
  final int sourceType;
  final String? hexKey;
  final String cid;
  final int page;
  final int size;
  final String startDate;
  final String endDate;

  FilecoinPersonIncomeByDateRequest({
    required this.sourceType,
    this.hexKey = "",
    required this.cid,
    required this.page,
    required this.size,
    required this.startDate,
    required this.endDate,
  });
}
