class GetBackForgetLoginPasswordRequest {
  final String? mobileOrEmail;
  final String? username;
  final String? password;
  final String? rePassword;
  final String? mobileOrEmailCode;
  final String? payPassword;

  GetBackForgetLoginPasswordRequest({
    this.mobileOrEmail,
    this.username,
    this.password,
    this.rePassword,
    this.mobileOrEmailCode,
    this.payPassword,
  });
}
