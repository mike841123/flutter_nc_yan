class BankCardApplyRequest {
  final String name;
  final String englishName;
  final String idCard;
  final String idCardStart;
  final String idCardEnd;
  final String nation;
  final String occupation;
  final int countrycode;
  final String phone;
  final String birthDay;
  final String email;
  final String residence;
  final String address;
  final String idCardPositive;
  final String idCardOtherSide;
  final String idCardHold;
  final int payType;
  final String sign;
  final String applicateDate;

  BankCardApplyRequest({
    this.name = "",
    this.englishName = "",
    this.idCard = "",
    this.idCardStart = "",
    this.idCardEnd = "",
    this.nation = "",
    this.occupation = "",
    this.countrycode = 0,
    this.phone = "",
    this.birthDay = "",
    this.email = "",
    this.residence = "",
    this.address = "",
    this.idCardPositive = "",
    this.idCardOtherSide = "",
    this.idCardHold = "",
    this.payType = 0,
    this.sign = "",
    this.applicateDate = "",
  });
}
