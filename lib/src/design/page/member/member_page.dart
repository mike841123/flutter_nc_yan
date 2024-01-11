import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/domain/response/member_page_response/security_setting_response.dart';
import 'package:yan_demo_fcm/src/config/app_config.dart';
import 'package:yan_demo_fcm/src/design/page/member/member_cubit.dart';
import 'dart:io';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/routes.dart';
import '../../component/open_image_button.dart';
import '../../model/routes_cubit/routes_cubit.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  CurrentPageState<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends CurrentPageState<MemberPage> {
  TextEditingController imgPath2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {
                if (AppConfig.token.isEmpty) {
                  BlocProvider.of<RoutesCubit>(context).changePage(Routes.login);
                } else {
                  print("進入個人中心");
                }
              },
              child: Container(
                width: 390.w,
                height: 120.h,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    children: [
                      addVerticalSpace(10.h),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Image.asset(
                          'assets/images/icon_settings.png',
                          width: 24.r,
                          height: 24.r,
                          fit: BoxFit.fill,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AppConfig.token.isEmpty
                                  ? Image.asset(
                                      'assets/images/img_default_header.png',
                                      width: 56.r,
                                      height: 56.r,
                                      fit: BoxFit.fill,
                                    )
                                  : BlocBuilder<MemberCubit, MemberState>(
                                      buildWhen: (previous, current) => previous.uploadImageResponse != current.uploadImageResponse,
                                      builder: (context, state) {
                                        return state.uploadImageResponse == null
                                            ? SizedBox(
                                                height: 56.r,
                                                width: 56.r,
                                                child: CircularProgressIndicator(
                                                  strokeWidth: 4.w,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            : OpenImageButton(
                                                imgPath2Controller,
                                                child: (String path) {
                                                  return ClipOval(
                                                    child: Image.network(state.uploadImageResponse?.data ?? "",
                                                        width: 56.r, height: 56.r, fit: BoxFit.fill, loadingBuilder: loadingBuilder(56.r),
                                                        errorBuilder: (BuildContext context, Object child, StackTrace? stackTrace) {
                                                      return SizedBox(
                                                        width: 56.r,
                                                        height: 56.r,
                                                        child: const Icon(
                                                          Icons.error,
                                                          color: Colors.white,
                                                        ),
                                                      );
                                                    }),
                                                  );
                                                },
                                                onImagePickerSuccess: (String path) async {
                                                  if (path.isNotEmpty) {
                                                    File imageFile = File(path);
                                                    imgPath2Controller.text = await BlocProvider.of<MemberCubit>(context).uploadImg(imageFile);
                                                    return true;
                                                  } else {
                                                    return false;
                                                  }
                                                },
                                              );
                                      },
                                    ),
                              addHorizontalSpace(14.h),
                              BlocBuilder<MemberCubit, MemberState>(
                                buildWhen: (previous, current) => previous.securitySettingResponse != current.securitySettingResponse,
                                builder: (context, state) {
                                  SecuritySettingResult result = state.securitySettingResponse?.data ?? SecuritySettingResult();
                                  return Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppConfig.token.isEmpty ? "未登入" : result.username ?? "",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                      addVerticalSpace(6.h),
                                      Text(
                                        "歡迎來到ncex",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff6b6b6b),
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                          Image.asset(
                            'assets/images/icon_into.png',
                            width: 20.r,
                            height: 20.r,
                            fit: BoxFit.contain,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    addVerticalSpace(8.h),
                    Container(
                      width: 390.w,
                      height: 120.h,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, left: 16.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 3.w,
                                  height: 14.h,
                                  color: const Color(0xff1199fa),
                                ),
                                addHorizontalSpace(4.w),
                                Text(
                                  "資產管理",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          addVerticalSpace(20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              iconTextItem("assets/images/img_my_assets.png", "我的資產",Routes.assetFlow),
                              iconTextItem("assets/images/img_my_flow.png", "資產流水",Routes.assetFlow),
                              iconTextItem("assets/images/img_payment_setting.png", "收款設置",Routes.assetFlow),
                              iconTextItem("assets/images/img_my_fund_pwd.png", "資金密碼",Routes.assetFlow),
                            ],
                          )
                        ],
                      ),
                    ),
                    addVerticalSpace(8.h),
                    Container(
                      width: 390.w,
                      height: 120.h,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: 3.w,
                                      height: 14.h,
                                      color: const Color(0xff1199fa),
                                    ),
                                    addHorizontalSpace(4.w),
                                    Text(
                                      "我的邀請",
                                      style: TextStyle(
                                        color: Color(0xff000000),
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                                Text(
                                  "我的邀請連結",
                                  style: TextStyle(
                                    color: Color(0xff1199fa),
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          addVerticalSpace(20.h),
                          Text(
                            "127",
                            style: TextStyle(
                              color: Color(0xff000000),
                              fontSize: 14.sp,
                            ),
                          ),
                          addVerticalSpace(10.h),
                          Text(
                            "邀請人數",
                            style: TextStyle(
                              color: Color(0xff6b6b6b),
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                    addVerticalSpace(8.h),
                    Container(
                      width: 390.w,
                      height: 120.h,
                      color: Colors.white,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 10.h, left: 16.w, right: 16.w),
                            child: Row(
                              children: [
                                Container(
                                  width: 3.w,
                                  height: 14.h,
                                  color: const Color(0xff1199fa),
                                ),
                                addHorizontalSpace(4.w),
                                Text(
                                  "法幣管理",
                                  style: TextStyle(
                                    color: Color(0xff000000),
                                    fontSize: 14.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          addVerticalSpace(20.h),
                          Padding(
                            padding: EdgeInsets.only(
                              left: 20.w,
                            ),
                            child: Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<RoutesCubit>(context).changePage(Routes.myAdvertisement);
                                  },
                                  child: Container(
                                    height: 44.h,
                                    width: 120.w,
                                    decoration: const BoxDecoration(
                                      color: Color(0xffE9E9F1),
                                      borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(
                                          "assets/images/img_my_order.png",
                                          width: 30.r,
                                          height: 30.r,
                                          fit: BoxFit.fill,
                                        ),
                                        addHorizontalSpace(6.w),
                                        Text(
                                          "我的廣告",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: Color(0xff000000),
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                addHorizontalSpace(50.w),
                                Container(
                                  height: 44.h,
                                  width: 120.w,
                                  decoration: const BoxDecoration(
                                    color: Color(0xffE9E9F1),
                                    borderRadius: BorderRadius.all(Radius.circular(30.0)),
                                  ),
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        "assets/images/img_my_order.png",
                                        width: 30.r,
                                        height: 30.r,
                                        fit: BoxFit.fill,
                                      ),
                                      addHorizontalSpace(6.w),
                                      Text(
                                        "我的訂單",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xff000000),
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    addVerticalSpace(16.h),
                    Stack(
                      children: [
                        Container(
                          width: 390.w,
                          height: 150.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/img_order_manage.png"),
                            fit: BoxFit.fill,
                          )),
                        ),
                        Positioned(
                          left: 40.w,
                          child: Column(
                            children: [
                              addVerticalSpace(30.h),
                              Text(
                                "我的委託",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 22.sp,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                width: 85.w,
                                decoration: BoxDecoration(
                                  color: Color(0xff1199fa),
                                  borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "幣幣交易",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    addVerticalSpace(8.h),
                    Stack(
                      children: [
                        Container(
                          width: 390.w,
                          height: 150.h,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                            image: AssetImage("assets/images/img_coin_manage.png"),
                            fit: BoxFit.fill,
                          )),
                        ),
                        Positioned(
                          left: 40.w,
                          child: Column(
                            children: [
                              addVerticalSpace(30.h),
                              Text(
                                "安全設置",
                                style: TextStyle(
                                  color: Color(0xff000000),
                                  fontSize: 22.sp,
                                ),
                              ),
                              addVerticalSpace(20.h),
                              Container(
                                padding: EdgeInsets.symmetric(vertical: 6.h),
                                width: 85.w,
                                decoration: const BoxDecoration(
                                  color: Color(0xff1199fa),
                                  borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                ),
                                alignment: Alignment.center,
                                child: Text(
                                  "個人信息",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    addVerticalSpace(60.h),
                  ],
                ),
              ),
            )
          ],
        ),
      ],
    );
  }

  Widget iconTextItem(String imgPath, String title,String route) {
    return InkWell(
      onTap: (){
        BlocProvider.of<MemberCubit>(context).gotoPage(route);
      },
      child: Column(
        children: [
          Image.asset(
            imgPath,
            width: 23.r,
            height: 22.r,
            fit: BoxFit.fill,
          ),
          addVerticalSpace(10.h),
          Text(
            title,
            style: TextStyle(
              color: Color(0xff6b6b6b),
              fontSize: 12.sp,
            ),
          ),
        ],
      ),
    );
  }
}
