class FundPurchaseRequest {
  final int amount;
  final int earningsAmount;
  final double earningsPercent;
  final int fundTypeId;
  final int payCoinId;
  final String payPassword;
  final int purchaseAnnual;

  FundPurchaseRequest({
    this.amount = 0,
    this.earningsAmount = 0,
    this.earningsPercent = 0.0,
    this.fundTypeId = 0,
    this.payCoinId = 0,
    this.payPassword = "",
    this.purchaseAnnual = 0,
  });
}
