import 'filecoin_request.dart';

class FilecoinAccountWithdrawHistoryRequest extends FilecoinRequest {
  final int page;
  final int size;

  FilecoinAccountWithdrawHistoryRequest({
    required int sourceType,
    required String hexKey,
    required String cid,
    required this.page,
    required this.size,
  }) : super(sourceType: sourceType, hexKey: hexKey, cid: cid);
}
