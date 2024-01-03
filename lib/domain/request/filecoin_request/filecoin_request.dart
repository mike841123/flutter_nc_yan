abstract class FilecoinRequest {
  final int sourceType;
  final String hexKey;
  final String cid;

  FilecoinRequest({
    required this.sourceType,
    required this.hexKey,
    required this.cid,
  });
}
