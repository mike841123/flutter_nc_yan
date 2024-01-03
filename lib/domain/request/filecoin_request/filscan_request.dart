class FilscanRequest {
  final int? id;
  final String? jsonrpc;
  final String method;

  FilscanRequest({
    this.id,
    this.jsonrpc,
    required this.method,
  });
}
