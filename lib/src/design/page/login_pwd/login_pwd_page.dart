import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/domain/request/update_pwd_request/update_pwd_request.dart';
import 'package:yan_demo_fcm/src/design/model/timer_cubit/timer_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/user_cubit/user_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/login_pwd/login_pwd_cubit.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import '../../component/input.dart';

class LoginPwdPage extends StatefulWidget {
  const LoginPwdPage({super.key});

  @override
  CurrentPageState<LoginPwdPage> createState() => _LoginPwdPageState();
}

class _LoginPwdPageState extends CurrentPageState<LoginPwdPage> {
  TextEditingController oldPwd = TextEditingController();
  TextEditingController newPwd = TextEditingController();
  TextEditingController confirmPwd = TextEditingController();
  TextEditingController sms = TextEditingController();

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      // 滑動按鈕固定在下方
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      addVerticalSpace(8.h),
                      Input(
                        oldPwd,
                        title: "舊登入密碼",
                        obscureText: true,
                      ),
                      addVerticalSpace(2.h),
                      Input(
                        newPwd,
                        title: "新登入密碼",
                        obscureText: true,
                      ),
                      addVerticalSpace(2.h),
                      Input(
                        confirmPwd,
                        title: "確認密碼",
                        obscureText: true,
                      ),
                      addVerticalSpace(2.h),
                      BlocBuilder<TimerCubit, TimerState>(
                        buildWhen: (previous, current) => previous.changeLoginPwdSmsCount != current.changeLoginPwdSmsCount,
                        builder: (context, state) {
                          return Input(
                            sms,
                            title: "手機驗證碼",
                            hint: "驗證碼",
                            isButton: true,
                            opBtnFunc: () {
                              print("123");
                              BlocProvider.of<LoginPwdCubit>(context).getUpdatePwdCode();
                            },
                            countDown: state.changeLoginPwdSmsCount,
                          );
                        },
                      ),
                      addVerticalSpace(2.h),
                    ],
                  ),
                ),
                Container(
                  width: 390.w,
                  height: 56.h,
                  decoration: BoxDecoration(
                    color: AppColor.bgColor2,
                  ),
                  child: ElevatedButton(
                    style: transparentButtonStyle(textHeight: 0),
                    onPressed: () {
                      if (oldPwd.text.isNotEmpty && newPwd.text.isNotEmpty && confirmPwd.text.isNotEmpty && sms.text.isNotEmpty) {
                        if (newPwd.text != confirmPwd.text) {
                          SmartDialog.showToast("新密碼與確認密碼不同");
                        } else {
                          BlocProvider.of<LoginPwdCubit>(context).updatePassword(
                              UpdatePwdRequest(oldPassword: oldPwd.text, newPassword: newPwd.text, confirm_newPassword: confirmPwd.text, code: sms.text));
                        }
                      } else {
                        SmartDialog.showToast("請完善訊息");
                      }
                    },
                    child: Text(
                      "提交",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontFamily: "HelveticaNeue",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
