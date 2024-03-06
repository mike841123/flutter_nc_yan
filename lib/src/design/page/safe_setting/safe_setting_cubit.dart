import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'safe_setting_state.dart';

class SafeSettingCubit extends Cubit<SafeSettingState> {
  SafeSettingCubit() : super(const SafeSettingState());

  void init() {
    getSafeSetting();
  }

  void getSafeSetting() async {

  }
}
