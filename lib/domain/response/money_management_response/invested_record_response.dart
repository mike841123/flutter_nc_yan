import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'invested_record_response.g.dart';

@JsonSerializable()
class InvestedRecordResponse extends ApiResponse<InvestedRecordResult> {
  InvestedRecordResponse({String message = "", int code = 1, InvestedRecordResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory InvestedRecordResponse.fromJson(Map<String, dynamic> json) => _$InvestedRecordResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InvestedRecordResponseToJson(this);
}

@JsonSerializable()
class InvestedRecordResult {
  InvestedRecordResult({
    this.content = const [],
    this.totalElements = 0,
    this.totalPages = 0,
    this.number = 0,
  });

  List<Content> content;
  int totalElements;
  int totalPages;
  int number;

  factory InvestedRecordResult.fromJson(Map<String, dynamic> json) => _$InvestedRecordResultFromJson(json);

  Map<String, dynamic> toJson() => _$InvestedRecordResultToJson(this);
}

@JsonSerializable()
class Content {
  Content({
    this.id = 0,
    this.investedAmount = 0,
    this.annualRate = 0,
    this.totalInterestAmount = "",
    this.status = 0,
    this.coinUnit = "",
    this.optionType = 0,
    this.orderId = "",
    this.legalDays = 0,
    this.createTime = "",
    this.redeemDate = "",
    this.startDate = "",
    this.endDate = "",
  });

  int id;
  double investedAmount;
  double annualRate;
  String totalInterestAmount;
  int status;
  String coinUnit;
  int optionType;
  String orderId;
  int legalDays;
  String startDate;
  String redeemDate;
  String createTime;
  String endDate;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
