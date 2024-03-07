import 'package:json_annotation/json_annotation.dart';

part 'depth_response.g.dart';

@JsonSerializable()
class DepthResponse {
  DepthResponse({
    this.ask,
    this.bid,
  });

  Ask? ask;
  Bid? bid;

  factory DepthResponse.fromJson(Map<String, dynamic> json) => _$DepthResponseFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$DepthResponseToJson(this);
}

@JsonSerializable()
class Ask {
  Ask({
    this.items = const [],
  });

  List<DepthItem> items;

  factory Ask.fromJson(Map<String, dynamic> json) => _$AskFromJson(json);

  Map<String, dynamic> toJson() => _$AskToJson(this);
}

@JsonSerializable()
class Bid {
  Bid({
    this.items = const [],
  });

  List<DepthItem> items;

  factory Bid.fromJson(Map<String, dynamic> json) => _$BidFromJson(json);

  Map<String, dynamic> toJson() => _$BidToJson(this);
}

@JsonSerializable()
class DepthItem {
  DepthItem({
    this.price = 0,
    this.amount = 0,
  });

  double price;
  double amount;

  factory DepthItem.fromJson(Map<String, dynamic> json) => _$DepthItemFromJson(json);

  Map<String, dynamic> toJson() => _$DepthItemToJson(this);
}
