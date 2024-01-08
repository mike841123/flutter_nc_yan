import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'advertise_response.g.dart';

@JsonSerializable()
class AdvertiseResponse extends ApiResponse<List<AdvertiseItem>> {
  AdvertiseResponse({String message = "", int code = 1, List<AdvertiseItem>? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory AdvertiseResponse.fromJson(Map<String, dynamic> json) => _$AdvertiseResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AdvertiseResponseToJson(this);
}

@JsonSerializable()
class AdvertiseItem {
  AdvertiseItem({this.url = ""});

  String url;

  factory AdvertiseItem.fromJson(Map<String, dynamic> json) => _$AdvertiseItemFromJson(json);

  Map<String, dynamic> toJson() => _$AdvertiseItemToJson(this);
}
