import 'package:json_annotation/json_annotation.dart';

import '../api_response.dart';

part 'history_msg_response.g.dart';

@JsonSerializable()
class HistoryMsgResponse {
  HistoryMsgResponse({
    this.totalCount,
    this.data = const [],
  });

  int? totalCount;
  List<HistoryMsgResult>? data;

  factory HistoryMsgResponse.fromJson(Map<String, dynamic> json) => _$HistoryMsgResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HistoryMsgResponseToJson(this);
}

@JsonSerializable()
class HistoryMsgResult {
  HistoryMsgResult({
    this.sendTimeStr = "",
    this.nameFrom = "",
    this.content = "",
  });

  String sendTimeStr;
  String nameFrom;
  String content;

  factory HistoryMsgResult.fromJson(Map<String, dynamic> json) => _$HistoryMsgResultFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryMsgResultToJson(this);
}
