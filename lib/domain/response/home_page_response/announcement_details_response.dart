import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'announcement_details_response.g.dart';

@JsonSerializable()
class AnnouncementDetailsResponse extends ApiResponse<AnnouncementDetailsResult> {
  AnnouncementDetailsResponse({String message = "", int code = 1, AnnouncementDetailsResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory AnnouncementDetailsResponse.fromJson(Map<String, dynamic> json) => _$AnnouncementDetailsResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnnouncementDetailsResponseToJson(this);
}

@JsonSerializable()
class AnnouncementDetailsResult {
  AnnouncementDetailsResult({
    this.info,
  });

  Info? info;

  factory AnnouncementDetailsResult.fromJson(Map<String, dynamic> json) => _$AnnouncementDetailsResultFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementDetailsResultToJson(this);
}

@JsonSerializable()
class Info {
  Info({this.createTime = "", this.title = "", this.content = ""});

  String content;
  String title;
  String createTime;

  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  Map<String, dynamic> toJson() => _$InfoToJson(this);
}
