class WithdrawUSDTRequest {
  final double amount;
  final int count;
  final String payPassword;
  final double promptlyRate;

  WithdrawUSDTRequest({
    required this.amount,
    required this.count,
    required this.payPassword,
    required this.promptlyRate,
  });
}
