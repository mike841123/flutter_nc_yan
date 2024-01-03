import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/src/config/app_config.dart';

import '../../../../domain/response/login_page_response/login_response.dart';
import '../../../../driven/service/state_service.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';
import '../../../config/routes.dart';
import '../../model/routes_cubit/routes_cubit.dart';


part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginState());


  /// 登入
  void login(String username,String password) async {
    LoginResponse? loginResponse;
    SmartDialog.showLoading();
    loginResponse = await getIt<ApiService>().login(
      username,password,
      replaceFunc: (res) {
        LoginResponse response = (res.data as LoginResponse);
        switch (response.code) {
          case 0:
            AppConfig.token = response.data?.token ?? "";
            BlocProvider.of<RoutesCubit>(getIt<StateService>().scaffoldContext).changePage(Routes.home);
            SmartDialog.dismiss();
            break;
          default:
            print("12121");
        }
      },
    );
  }
}
