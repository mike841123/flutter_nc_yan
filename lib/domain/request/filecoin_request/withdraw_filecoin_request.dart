class WithdrawFilecoinRequest {
  final double amount;
  final int count;
  final String chainAddress;
  final String payPassword;

  WithdrawFilecoinRequest({
    required this.amount,
    required this.count,
    required this.chainAddress,
    required this.payPassword,
  });
}
