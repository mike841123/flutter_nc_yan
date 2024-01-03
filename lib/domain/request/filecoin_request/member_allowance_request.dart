class MemberAllowanceRequest {
  final int sourceType;
  final String cid;
  final String reportDate;

  MemberAllowanceRequest({
    required this.sourceType,
    required this.cid,
    this.reportDate = "",
  });
}
