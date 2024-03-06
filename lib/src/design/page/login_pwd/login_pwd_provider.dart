import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../config/app_color.dart';
import '../../component/custom_appbar.dart';
import 'login_pwd_cubit.dart';
import 'login_pwd_page.dart';



class LoginPwdProvider extends StatelessWidget {
  const LoginPwdProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginPwdCubit()..init(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColor.bgColor4,
            appBar: const CustomAppBar(
              title: "更改登入密碼",
            ),
            body: const LoginPwdPage(),
          );
        }
      ),
    );
  }
}
