enum SendType { con_smstype_forgetpassword }

class SendVerifyCodeRequest {
  final String? mobileOrEmail;
  final String? username;
  final String? sendType;

  SendVerifyCodeRequest({
    this.mobileOrEmail,
    this.username,
    this.sendType,
  });
}
