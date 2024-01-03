class ModifyPasswordRequest {
  final String? oldPassword;
  final String? mobileOrEmailCode;
  final String? password;
  final String? rePassword;
  final String? payPassword;

  ModifyPasswordRequest({
    this.oldPassword,
    this.mobileOrEmailCode,
    this.password,
    this.rePassword,
    this.payPassword,
  });
}
