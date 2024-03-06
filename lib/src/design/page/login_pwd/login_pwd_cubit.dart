import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/domain/request/update_pwd_request/update_pwd_request.dart';
import 'package:yan_demo_fcm/domain/response/public_response/normal_response.dart';

import '../../../../driven/service/state_service.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';
import '../../model/timer_cubit/timer_cubit.dart';

part 'login_pwd_state.dart';

class LoginPwdCubit extends Cubit<LoginPwdState> {
  LoginPwdCubit() : super(const LoginPwdState());

  void init() {}

  void getUpdatePwdCode() async {
    NormalResponse response = await getIt<ApiService>().getUpdatePwdCode();
    if (response.code == 0) {
      if (getIt<StateService>().scaffoldContext.mounted) {
        BlocProvider.of<TimerCubit>(getIt<StateService>().scaffoldContext).setChangeLoginPwdSmsCount(600);
        BlocProvider.of<TimerCubit>(getIt<StateService>().scaffoldContext).changeLoginPwdSmsCountTimer();
      }
    }
  }

  void updatePassword(UpdatePwdRequest request) async {
    NormalResponse response = await getIt<ApiService>().updatePassword(request);
    if (response.code == 0) {
      SmartDialog.showToast("修改密碼成功");
      print("登出");
    }
  }
}
