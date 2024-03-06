part of 'timer_cubit.dart';

class TimerState extends Equatable {
  const TimerState({
    this.changeLoginPwdSmsCount = 0, // 修改密碼的驗證碼倒數
  });

  final int changeLoginPwdSmsCount;

  TimerState copyWith({
    int? changeLoginPwdSmsCount,
  }) {
    return TimerState(
      changeLoginPwdSmsCount: changeLoginPwdSmsCount ?? this.changeLoginPwdSmsCount,
    );
  }

  @override
  List<Object> get props => [
        changeLoginPwdSmsCount,
      ];
}
