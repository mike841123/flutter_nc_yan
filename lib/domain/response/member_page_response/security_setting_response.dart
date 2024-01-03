import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'security_setting_response.g.dart';

@JsonSerializable()
class SecuritySettingResponse extends ApiResponse<SecuritySettingResult> {
  SecuritySettingResponse({String message = "", int code = 1, SecuritySettingResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory SecuritySettingResponse.fromJson(Map<String, dynamic> json) => _$SecuritySettingResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SecuritySettingResponseToJson(this);
}

@JsonSerializable()
class SecuritySettingResult {
  SecuritySettingResult({
    this.username,
    this.id,
    this.createTime,
    this.realVerified,
    this.emailVerified,
    this.phoneVerified,
    this.loginVerified,
    this.fundsVerified,
    this.realAuditing,
    this.accountVerified,
    this.mobilePhone,
    this.email,
    this.realName,
    this.avatar,
  });

  String? username;
  int? id;
  String? createTime;
  int? realVerified;
  int? emailVerified;
  int? phoneVerified;
  int? loginVerified;
  int? fundsVerified;
  int? realAuditing;
  int? accountVerified;
  String? mobilePhone;
  String? email;
  String? realName;
  String? avatar;

  factory SecuritySettingResult.fromJson(Map<String, dynamic> json) => _$SecuritySettingResultFromJson(json);

  Map<String, dynamic> toJson() => _$SecuritySettingResultToJson(this);
}
