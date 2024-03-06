class UpdatePwdRequest {
  final String oldPassword;
  final String newPassword;
  final String confirm_newPassword;
  final String code;

  UpdatePwdRequest({
    required this.oldPassword,
    required this.newPassword,
    required this.confirm_newPassword,
    required this.code,
  });
}
