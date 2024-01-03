class InsuranceRegisterRequest {
  final int insurancePayCountryId;
  final int exchangeCountryId;
  final int insuranceInformationId;
  final int deductibleAssetTypeId;
  final int insuranceAmount;
  final double exchangeAmount;
  final double deductibleRate;
  final double deductibleAmount;
  final String insuranceFileName;
  final int insuranceFileType;
  final String paymentFileName;
  final int paymentFileType;
  final String startDate;
  final String endDate;

  InsuranceRegisterRequest({
    this.insurancePayCountryId = 0,
    this.exchangeCountryId = 0,
    this.insuranceInformationId = 0,
    this.deductibleAssetTypeId = 0,
    this.insuranceAmount = 0,
    this.exchangeAmount = 0.0,
    this.deductibleRate = 0.0,
    this.deductibleAmount = 0.0,
    this.insuranceFileName = "",
    this.insuranceFileType = 0,
    this.paymentFileName = "",
    this.paymentFileType = 0,
    this.startDate = "",
    this.endDate = "",
  });
}
