// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'normal_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NormalResponse _$NormalResponseFromJson(Map<String, dynamic> json) =>
    NormalResponse(
      message: json['message'] as String? ?? "",
      code: json['code'] as int? ?? 1,
      data: json['data'] == null
          ? null
          : Result.fromJson(json['data'] as Map<String, dynamic>),
      extend: json['extend'],
    );

Map<String, dynamic> _$NormalResponseToJson(NormalResponse instance) =>
    <String, dynamic>{
      'message': instance.message,
      'code': instance.code,
      'data': instance.data,
      'extend': instance.extend,
    };

Result _$ResultFromJson(Map<String, dynamic> json) => Result(
      result: json['result'] as bool? ?? false,
    );

Map<String, dynamic> _$ResultToJson(Result instance) => <String, dynamic>{
      'result': instance.result,
    };
