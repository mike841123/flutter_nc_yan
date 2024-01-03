class ModifyPayPasswordRequest {
  final String? mobileOrEmailCode;
  final String? payPassword;
  final String? rePayPassword;
  final String? oldPayPassword;

  ModifyPayPasswordRequest({
    this.mobileOrEmailCode,
    this.payPassword,
    this.rePayPassword,
    this.oldPayPassword,
  });
}
