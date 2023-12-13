import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'timer_state.dart';

/// 計時器 Cubit
class TimerCubit extends Cubit<TimerState> {
  TimerCubit() : super(const TimerState());

  void forgetTradeCountDown() {
    emit(state.copyWith(forgetTradeCount: state.forgetTradeCount - 1));
  }

  int getForgetTradeCount() {
    return state.forgetTradeCount;
  }

  void setForgetTradeCount(int count) {
    emit(state.copyWith(forgetTradeCount: count));
  }

  void forgetPasswordCountDown() {
    emit(state.copyWith(forgetPasswordCount: state.forgetPasswordCount - 1));
  }

  int getForgetPasswordCount() {
    return state.forgetPasswordCount;
  }

  void setForgetPasswordCount(int count) {
    emit(state.copyWith(forgetPasswordCount: count));
  }

  // 倒數忘記交易密碼送出驗證碼
  void forgetTradeCountTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state.forgetTradeCount >= 1) {
        forgetTradeCountDown();
      } else {
        timer.cancel();
      }
    });
  }

  // 倒數忘記密碼送出驗證碼
  void forgetPasswordCountTimer() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      if (state.forgetPasswordCount >= 1) {
        forgetPasswordCountDown();
      } else {
        timer.cancel();
      }
    });
  }
}
