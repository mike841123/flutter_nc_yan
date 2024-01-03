class BankHkWithdrawRequest {
  final String cashsum;
  final String tradePwd;
  final String phonecode;
  final String bankcard;
  final String englishName;
  final String? phoneCN;
  final String mobile;
  final String wdTrueMoney;

  BankHkWithdrawRequest({
    this.cashsum = "",
    this.tradePwd = "",
    this.phonecode = "",
    this.bankcard = "",
    this.englishName = "",
    this.phoneCN,
    this.mobile = "",
    this.wdTrueMoney = "",
  });
}
