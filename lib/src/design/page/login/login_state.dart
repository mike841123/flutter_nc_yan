part of 'login_cubit.dart';

class LoginState extends Equatable {
  const LoginState({
    this.text,
  });

  final String? text;

  LoginState copyWith({
    String? text,
  }) {
    return LoginState(text: text ?? this.text);
  }

  @override
  List<Object> get props => [text ?? ""];
}
