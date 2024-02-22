// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otc_order_detail_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtcOrderDetailResponse _$OtcOrderDetailResponseFromJson(
        Map<String, dynamic> json) =>
    OtcOrderDetailResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : OtcOrderDetailResult.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$OtcOrderDetailResponseToJson(
        OtcOrderDetailResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

OtcOrderDetailResult _$OtcOrderDetailResultFromJson(
        Map<String, dynamic> json) =>
    OtcOrderDetailResult(
      orderSn: json['orderSn'] as String?,
      type: json['type'] as int?,
      unit: json['unit'] as String?,
      status: json['status'] as int?,
      price: (json['price'] as num?)?.toDouble(),
      money: (json['money'] as num?)?.toDouble(),
      amount: (json['amount'] as num?)?.toDouble(),
      payInfo: json['payInfo'] == null
          ? null
          : PayInfo.fromJson(json['payInfo'] as Map<String, dynamic>),
      createTime: json['createTime'] as String?,
      payTime: json['payTime'] as String?,
      timeLimit: json['timeLimit'] as int?,
      otherSide: json['otherSide'] as String?,
      myId: json['myId'] as int?,
      hisId: json['hisId'] as int?,
      memberMobile: json['memberMobile'] as String?,
    );

Map<String, dynamic> _$OtcOrderDetailResultToJson(
        OtcOrderDetailResult instance) =>
    <String, dynamic>{
      'orderSn': instance.orderSn,
      'type': instance.type,
      'unit': instance.unit,
      'status': instance.status,
      'price': instance.price,
      'money': instance.money,
      'amount': instance.amount,
      'payInfo': instance.payInfo,
      'createTime': instance.createTime,
      'payTime': instance.payTime,
      'timeLimit': instance.timeLimit,
      'otherSide': instance.otherSide,
      'myId': instance.myId,
      'hisId': instance.hisId,
      'memberMobile': instance.memberMobile,
    };

PayInfo _$PayInfoFromJson(Map<String, dynamic> json) => PayInfo(
      realName: json['realName'] as String?,
      alipay: json['alipay'] == null
          ? null
          : Alipay.fromJson(json['alipay'] as Map<String, dynamic>),
      wechatPay: json['wechatPay'] == null
          ? null
          : WechatPay.fromJson(json['wechatPay'] as Map<String, dynamic>),
      bankInfo: json['bankInfo'] == null
          ? null
          : BankInfo.fromJson(json['bankInfo'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PayInfoToJson(PayInfo instance) => <String, dynamic>{
      'realName': instance.realName,
      'alipay': instance.alipay,
      'wechatPay': instance.wechatPay,
      'bankInfo': instance.bankInfo,
    };

Alipay _$AlipayFromJson(Map<String, dynamic> json) => Alipay(
      aliNo: json['aliNo'] as String?,
      qrCodeUrl: json['qrCodeUrl'] as String?,
    );

Map<String, dynamic> _$AlipayToJson(Alipay instance) => <String, dynamic>{
      'aliNo': instance.aliNo,
      'qrCodeUrl': instance.qrCodeUrl,
    };

WechatPay _$WechatPayFromJson(Map<String, dynamic> json) => WechatPay(
      wechat: json['wechat'] as String?,
      qrWeCodeUrl: json['qrWeCodeUrl'] as String?,
    );

Map<String, dynamic> _$WechatPayToJson(WechatPay instance) => <String, dynamic>{
      'wechat': instance.wechat,
      'qrWeCodeUrl': instance.qrWeCodeUrl,
    };

BankInfo _$BankInfoFromJson(Map<String, dynamic> json) => BankInfo(
      bank: json['bank'] as String?,
      branch: json['branch'] as String?,
      cardNo: json['cardNo'] as String?,
    );

Map<String, dynamic> _$BankInfoToJson(BankInfo instance) => <String, dynamic>{
      'bank': instance.bank,
      'branch': instance.branch,
      'cardNo': instance.cardNo,
    };
