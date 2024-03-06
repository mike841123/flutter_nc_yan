part of 'login_pwd_cubit.dart';

class LoginPwdState extends Equatable {
  const LoginPwdState({
    this.text = "",
  });

  final String text;

  LoginPwdState copyWith({
    String? text,
  }) {
    return LoginPwdState(
      text: text ?? this.text,
    );
  }

  @override
  List<Object> get props => [text];
}
