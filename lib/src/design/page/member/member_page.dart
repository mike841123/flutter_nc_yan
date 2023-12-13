import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_color.dart';

class MemberPage extends StatefulWidget {
  const MemberPage({super.key});

  @override
  CurrentPageState<MemberPage> createState() => _MemberPageState();
}

class _MemberPageState extends CurrentPageState<MemberPage> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
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
                            Image.asset(
                              'assets/images/img_default_header.png',
                              width: 56.r,
                              height: 56.r,
                              fit: BoxFit.fill,
                            ),
                            addHorizontalSpace(14.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "uuuh36081@gmail.com",
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
                              iconTextItem("assets/images/img_my_assets.png","我的資產"),
                              iconTextItem("assets/images/img_my_flow.png","資產流水"),
                              iconTextItem("assets/images/img_payment_setting.png","收款設置"),
                              iconTextItem("assets/images/img_my_fund_pwd.png","資金密碼"),
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
                            padding: EdgeInsets.only(top: 10.h, left: 16.w,right: 16.w),
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
                            padding: EdgeInsets.only(top: 10.h, left: 16.w,right: 16.w),
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
                            padding: EdgeInsets.only(left: 20.w,),
                            child: Row(
                              children: [
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
                              )
                          ),
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
                              )
                          ),
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

  Widget iconTextItem(String imgPath, String title) {
    return Column(
      children: [
        Image.asset(
          imgPath,
          width: 22.r,
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
    );
  }
}