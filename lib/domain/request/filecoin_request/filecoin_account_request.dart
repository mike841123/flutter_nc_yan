import 'filecoin_request.dart';

class FilecoinAccountRequest extends FilecoinRequest {
  FilecoinAccountRequest({
    required int sourceType,
    required String hexKey,
    required String cid,
  }) : super(sourceType: sourceType, hexKey: hexKey, cid: cid);
}
