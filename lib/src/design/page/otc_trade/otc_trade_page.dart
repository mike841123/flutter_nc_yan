import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import '../../../../domain/response/otc_page_response/otc_order_pre_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../component/custom_text_field.dart';
import 'otc_trade_cubit.dart';

class OtcTradePage extends StatefulWidget {
  const OtcTradePage({super.key});

  @override
  CurrentPageState<OtcTradePage> createState() => _OtcTradePageState();
}

class _OtcTradePageState extends CurrentPageState<OtcTradePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController price1 = TextEditingController();
    return BlocBuilder<OtcTradeCubit, OtcTradeState>(
      buildWhen: (previous, current) => previous.otcOrderPreResponse != current.otcOrderPreResponse,
      builder: (context, state) {
        OtcOrderPreResult result = state.otcOrderPreResponse?.data ?? OtcOrderPreResult();
        return state.otcOrderPreResponse == null
            ? const CircularProgressIndicator()
            : Column(
                children: [
                  Container(
                    color: Color(0xff2e2e2e),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(),
                                addHorizontalSpace(4.w),
                                Text(
                                  result.username ?? "",
                                  style: TextStyle(
                                      color: Color(0xff828ea1),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Image.asset(
                                  "assets/images/img_paymode_wechat.png",
                                  fit: BoxFit.fill,
                                  width: 20.r,
                                  height: 20.r,
                                ),
                                addHorizontalSpace(4.w),
                                Text(
                                  result.transactions.toPrecisionString(),
                                  style: TextStyle(
                                      color: Color(0xff828ea1),
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 15.sp),
                                ),
                              ],
                            ),
                          ],
                        ),
                        addVerticalSpace(16.h),
                        rowTextItem("價格", "812"),
                        addVerticalSpace(8.h),
                        rowTextItem("價格", "812"),
                        addVerticalSpace(8.h),
                        rowTextItem("價格", "812"),
                        addVerticalSpace(8.h),
                        rowTextItem("價格", "812"),
                        addVerticalSpace(8.h),
                        rowTextItem("價格", "812"),
                        addVerticalSpace(16.h),
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "备注信息：谢谢亲的购买，请记得付款",
                            style: TextStyle(
                                color: Color(0xff828ea1),
                                fontWeight: FontWeight.w700,
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(8.h),
                  Container(
                    width: double.infinity,
                    color: Color(0xff2e2e2e),
                    padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 18.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("需要出售多少?",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w500, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 15.sp),
                            textAlign: TextAlign.left),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("CNY",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.left),
                            CustomTextField(
                              price1,
                            ),
                            addHorizontalSpace(6.w),
                            Image.asset(
                              "assets/images/img_change.png",
                              fit: BoxFit.fill,
                              width: 20.r,
                              height: 20.r,
                            ),
                            addHorizontalSpace(6.w),
                            Text("CNY",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.left),
                            addHorizontalSpace(6.w),
                            CustomTextField(
                              price1,
                              width: 124.w,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  addVerticalSpace(8.h),
                  Container(
                    width: double.infinity,
                    color: Color(0xff2e2e2e),
                    padding: EdgeInsets.only(top: 10.h, bottom: 20.h, left: 14.w, right: 14.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("交易提醒",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w500, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 15.sp),
                            textAlign: TextAlign.left),
                        addVerticalSpace(8.h),
                        titleAndContent("1.", "交易前請詳細瞭解賣家的交易信息。"),
                        titleAndContent("2.", "請通過平台進行溝通約定,並保存好相關聊天記錄。 "),
                        titleAndContent("3.", "如遇到交易糾紛,請通過平台該頁面右上角幫助解決問題。"),
                      ],
                    ),
                  ),
                ],
              );
      },
    );
  }
}

Widget titleAndContent(String title, String content) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 14.sp),
        textAlign: TextAlign.left,
      ),
      Expanded(
        child: Text(
          content,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 14.sp),
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}
