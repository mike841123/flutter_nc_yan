import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

/// 計時器 Cubit
class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState());

  void changeLoginPwdSmsCountDown() {
    emit(state.copyWith(changeLoginPwdSmsCount: state.changeLoginPwdSmsCount - 1));
  }

  int getChangeLoginPwdSmsCount() {
    return state.changeLoginPwdSmsCount;
  }

  void setChangeLoginPwdSmsCount(int count) {
    emit(state.copyWith(changeLoginPwdSmsCount: count));
  }

  // 倒數密碼送出驗證碼
  void changeLoginPwdSmsCountTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state.changeLoginPwdSmsCount >= 1) {
        changeLoginPwdSmsCountDown();
      } else {
        timer.cancel();
      }
    });
  }
}
