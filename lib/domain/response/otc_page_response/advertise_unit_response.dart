import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'advertise_unit_response.g.dart';

@JsonSerializable()
class AdvertiseUnitResponse extends ApiResponse<AdvertiseUnitResult> {
  AdvertiseUnitResponse({String message = "", int code = 1, AdvertiseUnitResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory AdvertiseUnitResponse.fromJson(Map<String, dynamic> json) => _$AdvertiseUnitResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvertiseUnitResponseToJson(this);
}

@JsonSerializable()
class AdvertiseUnitResult {
  AdvertiseUnitResult({
    this.context = const [],
    this.totalElements = 0,
    this.totalPages = 0,
  });

  List<Context> context;
  int totalElements;
  int totalPages;

  factory AdvertiseUnitResult.fromJson(Map<String, dynamic> json) => _$AdvertiseUnitResultFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertiseUnitResultToJson(this);
}

@JsonSerializable()
class Context {
  Context({
    this.advType = 0,
    this.advertiseId = 0,
    this.advertiseType = 0,
    this.avatar = "",
    this.transactions = 0,
    this.price = "",
    this.remainAmount = 0,
    this.maxLimit = 0,
    this.minLimit = 0,
    this.memberName = "",
    this.coinId = 0,
    this.unit = "",
  });

  int advType;
  int advertiseId;
  int advertiseType;
  String avatar;
  int transactions;
  String price;
  double remainAmount;
  double maxLimit;
  double minLimit;
  String memberName;
  int coinId;
  String unit;

  factory Context.fromJson(Map<String, dynamic> json) => _$ContextFromJson(json);

  Map<String, dynamic> toJson() => _$ContextToJson(this);
}
