import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'loading_state.dart';

/// 讀取條 Cubit
class LoadingCubit extends Cubit<LoadingState> {
  LoadingCubit() : super(const LoadingState());

  /// 讀取狀態變化閉包
  Future<T> loadingClose<T>(Future<T> Function() func) async {
    emit(state.copyWith(loadStatus: LoadStatus.loading));
    T data = await func();
    emit(state.copyWith(loadStatus: LoadStatus.done));
    return data;
  }
}
