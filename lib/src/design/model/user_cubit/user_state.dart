part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    this.balance = 0,
  });

  final double balance;

  UserState copyWith({double? balance}) {
    return UserState(
      balance: balance ?? this.balance,
    );
  }

  @override
  List<Object> get props => [
        balance,
      ];
}
