part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    this.balance = 0,
    this.userData,
  });

  final double balance;
  final SecuritySettingResult? userData;

  UserState copyWith({double? balance, SecuritySettingResult? userData}) {
    return UserState(
      balance: balance ?? this.balance,
      userData: userData ?? this.userData,
    );
  }

  @override
  List<Object> get props => [
        balance,
        userData ?? SecuritySettingResult(),
      ];
}
