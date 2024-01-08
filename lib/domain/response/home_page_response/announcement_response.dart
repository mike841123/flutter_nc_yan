import 'package:json_annotation/json_annotation.dart';
import 'package:yan_demo_fcm/domain/response/list_result.dart';

import '../api_response.dart';

part 'announcement_response.g.dart';

@JsonSerializable()
class AnnouncementResponse extends ApiResponse<AnnouncementResult> {
  AnnouncementResponse({String message = "", int code = 1, AnnouncementResult? data, dynamic extend})
      : super(message: message, code: code, data: data, extend: extend);

  factory AnnouncementResponse.fromJson(Map<String, dynamic> json) => _$AnnouncementResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$AnnouncementResponseToJson(this);
}

@JsonSerializable()
class AnnouncementResult {
  AnnouncementResult({this.content = const []});

  List<Content> content;

  factory AnnouncementResult.fromJson(Map<String, dynamic> json) => _$AnnouncementResultFromJson(json);

  Map<String, dynamic> toJson() => _$AnnouncementResultToJson(this);
}

@JsonSerializable()
class Content {
  Content({
    this.totalElements = 0,
    this.id = 0,
    this.title = "",
    this.content = "",
  });

  int totalElements;
  int id;
  String title;
  String content;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
