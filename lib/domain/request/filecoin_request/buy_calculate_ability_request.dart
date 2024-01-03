class BuyCalculateAbilityRequest {
  final double amount;
  final String poolId;
  final String payPassword;
  final String coinName;
  final int payType;

  BuyCalculateAbilityRequest({
    required this.amount,
    required this.poolId,
    required this.payPassword,
    required this.coinName,
    required this.payType,
  });
}
