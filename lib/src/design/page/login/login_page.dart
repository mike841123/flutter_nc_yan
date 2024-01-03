import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import 'package:flutter_svg/svg.dart';
import '../../component/custom_text_field.dart';
import 'login_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  CurrentPageState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends CurrentPageState<LoginPage> {
  TextEditingController accountController = TextEditingController();
  TextEditingController pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 34.w),
        child: Column(
          children: [
            addVerticalSpace(72.h),
            SvgPicture.asset(
              "assets/images/img_logo.svg",
              width: 150.w,
              height: 40.h,
              fit: BoxFit.fill,
            ),
            addVerticalSpace(100.h),
            CustomTextField(
              accountController,
              hint: "请输入手机号/邮箱",
              title: "帳號",
            ),
            addVerticalSpace(24.h),
            CustomTextField(
              pwController,
              hint: "请输入密码",
              title: "密码",
              obscureText: true,
            ),
            addVerticalSpace(16.h),
            Container(
              alignment: Alignment.centerRight,
              child: Text("忘记密码?",
                  style: TextStyle(
                    color: const Color(0xff00cfbe),
                    fontWeight: FontWeight.w400,
                    fontFamily: "HelveticaNeue",
                    fontStyle: FontStyle.normal,
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center),
            ),
            addVerticalSpace(66.h),
            Container(
              width: 320.w,
              height: 44.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: Color(0xff00cfbe),
              ),
              child: ElevatedButton(
                style: transparentButtonStyle(textHeight: 0, borderRadius: 8.0),
                onPressed: () {
                  BlocProvider.of<LoginCubit>(context).login(
                    accountController.text,
                    pwController.text,
                  );
                },
                child: Text(
                  "登入",
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
            addVerticalSpace(116.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 38.h,
                  child: ElevatedButton(
                    style: transparentButtonStyle(),
                    onPressed: () {
                      // BlocProvider.of<RoutesCubit>(context).changeView(CurrentView.register);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: Text("没有BAZEX帐号?",
                            style: TextStyle(
                                color: Color(0xffefefef),
                                fontWeight: FontWeight.w400,
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp),
                            textAlign: TextAlign.center)),
                  ),
                ),
                SizedBox(
                  height: 38.h,
                  child: ElevatedButton(
                    style: transparentButtonStyle(),
                    onPressed: () {
                      // BlocProvider.of<RoutesCubit>(context).changeView(CurrentView.forget);
                    },
                    child: Padding(
                        padding: EdgeInsets.only(top: 8.h, bottom: 8.h),
                        child: Text("立即注册",
                            style: TextStyle(
                                color: Color(0xffefefef),
                                fontWeight: FontWeight.w400,
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontSize: 15.sp),
                            textAlign: TextAlign.center)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
