class RegisterRequest {
  final String? mobileOrEmail;
  final String? username;
  final String? password;
  final String? rePassword;
  final String? referralCode;
  final int? countryId;

  RegisterRequest({
    this.mobileOrEmail,
    this.username,
    this.password,
    this.rePassword,
    this.referralCode,
    this.countryId,
  });
}
