class BankCardUpdateRequest {
   final int wrId;
   final String newCard;
   final String tradePwd;

   BankCardUpdateRequest({
    this.wrId = 0,
    this.newCard = "",
    this.tradePwd = "",
  });
}
