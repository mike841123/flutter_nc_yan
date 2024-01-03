// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'security_setting_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SecuritySettingResponse _$SecuritySettingResponseFromJson(
        Map<String, dynamic> json) =>
    SecuritySettingResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : SecuritySettingResult.fromJson(
              json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$SecuritySettingResponseToJson(
        SecuritySettingResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

SecuritySettingResult _$SecuritySettingResultFromJson(
        Map<String, dynamic> json) =>
    SecuritySettingResult(
      username: json['username'] as String?,
      id: json['id'] as int?,
      createTime: json['createTime'] as String?,
      realVerified: json['realVerified'] as int?,
      emailVerified: json['emailVerified'] as int?,
      phoneVerified: json['phoneVerified'] as int?,
      loginVerified: json['loginVerified'] as int?,
      fundsVerified: json['fundsVerified'] as int?,
      realAuditing: json['realAuditing'] as int?,
      accountVerified: json['accountVerified'] as int?,
      mobilePhone: json['mobilePhone'] as String?,
      email: json['email'] as String?,
      realName: json['realName'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$SecuritySettingResultToJson(
        SecuritySettingResult instance) =>
    <String, dynamic>{
      'username': instance.username,
      'id': instance.id,
      'createTime': instance.createTime,
      'realVerified': instance.realVerified,
      'emailVerified': instance.emailVerified,
      'phoneVerified': instance.phoneVerified,
      'loginVerified': instance.loginVerified,
      'fundsVerified': instance.fundsVerified,
      'realAuditing': instance.realAuditing,
      'accountVerified': instance.accountVerified,
      'mobilePhone': instance.mobilePhone,
      'email': instance.email,
      'realName': instance.realName,
      'avatar': instance.avatar,
    };
