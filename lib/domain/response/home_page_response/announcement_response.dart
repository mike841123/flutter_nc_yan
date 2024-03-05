import 'package:json_annotation/json_annotation.dart';
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
    this.id = 0,
    this.title = "",
    this.content = "",
    this.createTime = "",
  });

  int id;
  String title;
  String content;
  String createTime;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
