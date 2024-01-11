import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'otc_advertise_response.g.dart';

@JsonSerializable()
class OtcAdvertiseResponse extends ApiResponse<OtcAdvertiseResult> {
  OtcAdvertiseResponse({String message = "", int code = 1, OtcAdvertiseResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory OtcAdvertiseResponse.fromJson(Map<String, dynamic> json) => _$OtcAdvertiseResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$OtcAdvertiseResponseToJson(this);
}

@JsonSerializable()
class OtcAdvertiseResult {
  OtcAdvertiseResult({this.content = const []});

  List<Content> content;

  factory OtcAdvertiseResult.fromJson(Map<String, dynamic> json) => _$OtcAdvertiseResultFromJson(json);

  Map<String, dynamic> toJson() => _$OtcAdvertiseResultToJson(this);
}

@JsonSerializable()
class Content {
  Content({
    this.totalElements = 0,
    this.id = 0,
    this.advertiseType = 0,
    this.member,
    this.maxLimit = 0,
    this.minLimit = 0,
    this.remainAmount = 0,
  });

  int totalElements;
  int id;
  int advertiseType;
  double minLimit;
  double maxLimit;
  double remainAmount;
  Member? member;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}

@JsonSerializable()
class Member {
  Member({
    this.email = "",
  });

  String email;

  factory Member.fromJson(Map<String, dynamic> json) => _$MemberFromJson(json);

  Map<String, dynamic> toJson() => _$MemberToJson(this);
}
