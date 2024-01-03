import 'filecoin_request.dart';

class SearchAccountPutCalculateAbilityRequest extends FilecoinRequest {
  final int page;
  final int? size;

  SearchAccountPutCalculateAbilityRequest({
    required int sourceType,
    required String hexKey,
    required String cid,
    required this.page,
    this.size,
  }) : super(sourceType: sourceType, hexKey: hexKey, cid: cid);
}
