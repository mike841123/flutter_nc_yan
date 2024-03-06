import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/src/config/routes.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/user_cubit/user_cubit.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import 'component/safe_setting_item.dart';

class SafeSettingPage extends StatefulWidget {
  const SafeSettingPage({super.key});

  @override
  CurrentPageState<SafeSettingPage> createState() => _SafeSettingPageState();
}

class _SafeSettingPageState extends CurrentPageState<SafeSettingPage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getUser();
    super.initState();
  }

  /// 監聽返回
  @override
  void didPopNext() {
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = BlocProvider.of<UserCubit>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10.h, top: 10.h, left: 10.w),
          child: Text("为保障您的账户安全！", style: TextStyle(color: AppColor.textColor1)),
        ),
        SafeSettingItem(titleText: "個人頭像", isImg: true, imgSrc: userCubit.state.uploadImageResponse?.data ?? ""),
        addVerticalSpace(2.h),
        SafeSettingItem(
          titleText: "實名認證",
          contentText: (userCubit.state.userData?.realVerified ?? 0) == 1 ? "修改" : "未設置",
          onTap: () {
            print("haha");
          },
        ),
        addVerticalSpace(2.h),
        SafeSettingItem(
          titleText: "手機",
          contentText: (userCubit.state.userData?.phoneVerified ?? 0) == 1 ? "已設置" : "未綁定",
          onTap: () {
            print("haha");
          },
        ),
        addVerticalSpace(2.h),
        SafeSettingItem(
          titleText: "登入密碼",
          contentText: (userCubit.state.userData?.loginVerified ?? 0) == 1 ? "修改" : "未設置",
          onTap: () {
            BlocProvider.of<RoutesCubit>(context).changePage(Routes.loginPwd);
          },
        ),
        addVerticalSpace(2.h),
        SafeSettingItem(
          titleText: "資金密碼",
          contentText: (userCubit.state.userData?.fundsVerified ?? 0) == 1 ? "修改" : "未設置",
          onTap: () {
            print("haha");
          },
        ),
      ],
    );
  }
}
