import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'login_response.g.dart';

@JsonSerializable()
class LoginResponse extends ApiResponse<LoginResult>{
  LoginResponse({String message = "", int code = 1, LoginResult? data, dynamic extend}) : super(message: message, code: code, data: data, extend: extend);

  factory LoginResponse.fromJson(Map<String, dynamic> json) => _$LoginResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class LoginResult {
  LoginResult({this.token});

  String? token;

  factory LoginResult.fromJson(Map<String, dynamic> json) => _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
