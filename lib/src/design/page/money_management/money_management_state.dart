part of 'money_management_cubit.dart';

class MoneyManagementState extends Equatable {
  const MoneyManagementState({
    this.investedRateResponse,
  });

  final ApiResponse? investedRateResponse;

  MoneyManagementState copyWith({
    ApiResponse? investedRateResponse,
  }) {
    return MoneyManagementState(
      investedRateResponse: investedRateResponse ?? this.investedRateResponse,
    );
  }

  @override
  List<Object> get props => [
        investedRateResponse ?? ApiResponse(),
      ];
}
