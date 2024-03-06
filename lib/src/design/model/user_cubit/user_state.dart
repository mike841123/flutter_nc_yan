part of 'user_cubit.dart';

class UserState extends Equatable {
  const UserState({
    this.balance = 0,
    this.userData,
    this.uploadImageResponse,
  });

  final double balance;
  final SecuritySettingResult? userData;
  final ApiResponse<String>? uploadImageResponse;

  UserState copyWith({
    double? balance,
    SecuritySettingResult? userData,
    ApiResponse<String>? uploadImageResponse,
  }) {
    return UserState(
      balance: balance ?? this.balance,
      userData: userData ?? this.userData,
      uploadImageResponse: uploadImageResponse ?? this.uploadImageResponse,
    );
  }

  @override
  List<Object> get props => [
        balance,
        userData ?? SecuritySettingResult(),
        uploadImageResponse ?? ApiResponse<String>(),
      ];
}
