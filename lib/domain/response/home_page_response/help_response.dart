import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'help_response.g.dart';

@JsonSerializable()
class HelpResponse extends ApiResponse<List<HelpItem>> {
  HelpResponse({String message = "", int code = 1, List<HelpItem>? data, dynamic extend}) : super(message: message, code: code, data: data, extend: extend);

  factory HelpResponse.fromJson(Map<String, dynamic> json) => _$HelpResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HelpResponseToJson(this);
}

@JsonSerializable()
class HelpItem {
  HelpItem({
    this.cate = "",
    this.titleCN = "",
    this.titleEN = "",
    this.title = "",
    this.createTime = "",
    this.content = const [],
  });


  String cate;
  String titleCN;
  String titleEN;
  List<Content> content;
  String title;
  String createTime;

  factory HelpItem.fromJson(Map<String, dynamic> json) => _$HelpItemFromJson(json);

  Map<String, dynamic> toJson() => _$HelpItemToJson(this);
}

@JsonSerializable()
class Content {
  Content({
    this.id = 0,
    this.title = "",
    this.createTime = "",
  });

  int id;
  String title;
  String createTime;

  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}
