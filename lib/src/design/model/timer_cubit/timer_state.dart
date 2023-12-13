part of 'timer_cubit.dart';

class TimerState extends Equatable {
  const TimerState({
    this.forgetTradeCount = 0, // 忘記交易密碼的倒數
    this.forgetPasswordCount = 0, // 修改密碼的倒數
  });

  final int forgetTradeCount;
  final int forgetPasswordCount;

  TimerState copyWith({
    int? forgetTradeCount,
    int? forgetPasswordCount,
  }) {
    return TimerState(
      forgetTradeCount: forgetTradeCount ?? this.forgetTradeCount,
      forgetPasswordCount: forgetPasswordCount ?? this.forgetPasswordCount,
    );
  }

  @override
  List<Object> get props => [
        forgetTradeCount,
        forgetPasswordCount,
      ];
}
