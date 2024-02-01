class OtcTradeRequest {
  final int id;
  final int coinId;
  final double price;
  final double money;
  final double amount;

  OtcTradeRequest({
    this.id = 0,
    this.coinId = 0,
    this.price = 0,
    this.money = 0,
    this.amount = 0,
  });
}
