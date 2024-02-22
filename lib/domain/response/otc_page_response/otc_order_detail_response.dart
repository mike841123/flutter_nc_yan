import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'otc_order_detail_response.g.dart';

@JsonSerializable()
class OtcOrderDetailResponse extends ApiResponse<OtcOrderDetailResult> {
  OtcOrderDetailResponse({String message = "", int code = 1, OtcOrderDetailResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory OtcOrderDetailResponse.fromJson(Map<String, dynamic> json) => _$OtcOrderDetailResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OtcOrderDetailResponseToJson(this);
}

@JsonSerializable()
class OtcOrderDetailResult {
  final String? orderSn;
  final int? type;
  final String? unit;
  final int? status;
  final double? price;
  final double? money;
  final double? amount;
  final PayInfo? payInfo;
  final String? createTime;
  final String? payTime;
  final int? timeLimit;
  final String? otherSide;
  final int? myId;
  final int? hisId;
  final String? memberMobile;

  OtcOrderDetailResult({
    this.orderSn,
    this.type,
    this.unit,
    this.status,
    this.price,
    this.money,
    this.amount,
    this.payInfo,
    this.createTime,
    this.payTime,
    this.timeLimit,
    this.otherSide,
    this.myId,
    this.hisId,
    this.memberMobile,
  });

  factory OtcOrderDetailResult.fromJson(Map<String, dynamic> json) => _$OtcOrderDetailResultFromJson(json);

  Map<String, dynamic> toJson() => _$OtcOrderDetailResultToJson(this);
}

@JsonSerializable()
class PayInfo {
  final String? realName;
  final Alipay? alipay;
  final WechatPay? wechatPay;
  final BankInfo? bankInfo;

  PayInfo({
    this.realName,
    this.alipay,
    this.wechatPay,
    this.bankInfo,
  });

  factory PayInfo.fromJson(Map<String, dynamic> json) =>
      _$PayInfoFromJson(json);

  Map<String, dynamic> toJson() => _$PayInfoToJson(this);
}

@JsonSerializable()
class Alipay {
  final String? aliNo;
  final String? qrCodeUrl;

  Alipay({
    this.aliNo,
    this.qrCodeUrl,
  });

  factory Alipay.fromJson(Map<String, dynamic> json) =>
      _$AlipayFromJson(json);

  Map<String, dynamic> toJson() => _$AlipayToJson(this);
}

@JsonSerializable()
class WechatPay {
  final String? wechat;
  final String? qrWeCodeUrl;

  WechatPay({
    this.wechat,
    this.qrWeCodeUrl,
  });

  factory WechatPay.fromJson(Map<String, dynamic> json) =>
      _$WechatPayFromJson(json);

  Map<String, dynamic> toJson() => _$WechatPayToJson(this);
}

@JsonSerializable()
class BankInfo {
  final String? bank;
  final String? branch;
  final String? cardNo;

  BankInfo({
    this.bank,
    this.branch,
    this.cardNo,
  });

  factory BankInfo.fromJson(Map<String, dynamic> json) =>
      _$BankInfoFromJson(json);

  Map<String, dynamic> toJson() => _$BankInfoToJson(this);
}