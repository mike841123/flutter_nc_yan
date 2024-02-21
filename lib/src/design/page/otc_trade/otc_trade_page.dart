import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/otc_trade_request.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import 'package:yan_demo_fcm/src/config/app_color.dart';
import '../../../../domain/response/otc_page_response/otc_order_pre_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../component/custom_text_field.dart';
import 'otc_trade_cubit.dart';

class OtcTradePage extends StatefulWidget {
  const OtcTradePage({
    Key? key,
    required this.arguments,
  }) : super(key: key);

  final OtcTradeArguments arguments;

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
    TextEditingController price2 = TextEditingController();
    return BlocBuilder<OtcTradeCubit, OtcTradeState>(
      buildWhen: (previous, current) => previous.otcOrderPreResponse != current.otcOrderPreResponse,
      builder: (context, state) {
        OtcOrderPreResult result = state.otcOrderPreResponse?.data ?? OtcOrderPreResult();
        return state.otcOrderPreResponse == null
            ? const CircularProgressIndicator()
            : CustomScrollView(
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
                                Container(
                                  color: AppColor.bgColor1,
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Row(
                                            children: [
                                              Image.asset(
                                                'assets/images/img_default_header.png',
                                                width: 40.r,
                                                height: 40.r,
                                                fit: BoxFit.fill,
                                              ),
                                              addHorizontalSpace(4.w),
                                              Text(
                                                result.username ?? "",
                                                style: TextStyle(
                                                    color: AppColor.textColor1,
                                                    fontWeight: FontWeight.w700,
                                                    fontFamily: "HelveticaNeue",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 15.sp),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  for (int i = 0; i < BlocProvider.of<OtcTradeCubit>(context).getPayModeList().length; i++)
                                                    Padding(
                                                      padding: EdgeInsets.only(right: 4.w),
                                                      child: Image.asset(
                                                        "assets/images/img_paymode_${BlocProvider.of<OtcTradeCubit>(context).getPayModeImageSrc(BlocProvider.of<OtcTradeCubit>(context).getPayModeList()[i])}.png",
                                                        fit: BoxFit.fill,
                                                        width: 20.r,
                                                        height: 20.r,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                              addHorizontalSpace(4.w),
                                              Text(
                                                result.transactions.toPrecisionString(),
                                                style: TextStyle(
                                                    color: AppColor.textColor1,
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
                                      rowTextItem("價格", "${result.price.toPrecisionString()}CNY/${result.unit ?? ""}"),
                                      addVerticalSpace(8.h),
                                      rowTextItem("數量", "${result.maxTradableAmount.toPrecisionString()}${result.unit ?? ""}"),
                                      addVerticalSpace(8.h),
                                      rowTextItem("交易限額", "${result.minLimit.toPrecisionString()}-${result.maxLimit.toPrecisionString()}CNY"),
                                      addVerticalSpace(8.h),
                                      rowTextItem("所在地", result.country ?? ""),
                                      addVerticalSpace(8.h),
                                      rowTextItem("價格", "${result.timeLimit}分鐘"),
                                      addVerticalSpace(16.h),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "备注信息：谢谢亲的购买，请记得付款",
                                          style: TextStyle(
                                              color: AppColor.textColor1,
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
                                  color: AppColor.bgColor1,
                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 18.h),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("需要出售多少?",
                                          style: TextStyle(
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text("CNY",
                                              style: TextStyle(
                                                  color: AppColor.textColor1,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13.sp),
                                              textAlign: TextAlign.left),
                                          CustomTextField(
                                            price1,
                                            width: 124.w,
                                            onChanged: (value) {
                                              if (value != null) {
                                                if (value.isNotEmpty) {
                                                  double price = double.parse(value.toString());
                                                  double test = result.price ?? 0;
                                                  price2.text = (price.d() / test.d()).toDouble().toStringAsFixed(8);
                                                } else {
                                                  price2.text = "";
                                                }
                                              }
                                            },
                                          ),
                                          addHorizontalSpace(6.w),
                                          Image.asset(
                                            "assets/images/img_change.png",
                                            fit: BoxFit.fill,
                                            width: 20.r,
                                            height: 20.r,
                                          ),
                                          addHorizontalSpace(6.w),
                                          Text(result.unit ?? "",
                                              style: TextStyle(
                                                  color: AppColor.textColor1,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 13.sp),
                                              textAlign: TextAlign.left),
                                          addHorizontalSpace(6.w),
                                          CustomTextField(
                                            price2,
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
                                  color: AppColor.bgColor1,
                                  padding: EdgeInsets.only(top: 10.h, bottom: 20.h, left: 14.w, right: 14.w),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("交易提醒",
                                          style: TextStyle(
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 15.sp),
                                          textAlign: TextAlign.left),
                                      addVerticalSpace(8.h),
                                      titleAndContent("1.", "交易前請詳細瞭解賣家的交易信息。"),
                                      titleAndContent("2.", "請通過平台進行溝通約定,並保存好相關聊天記錄。 "),
                                      titleAndContent("3.", "如遇到交易糾紛,請通過平台該頁面右上角幫助解決問題。"),
                                    ],
                                  ),
                                ),
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
                                if (price1.text.isNotEmpty && price2.text.isNotEmpty) {
                                  SmartDialog.show(
                                    alignment: Alignment.bottomCenter,
                                    builder: (_) {
                                      return detailDialog(
                                        context,
                                        arguments: widget.arguments,
                                        price: result.price ?? 0,
                                        count: double.parse(price2.text),
                                        total: double.parse(price1.text),
                                        unit: result.unit ?? "",
                                      );
                                    },
                                  );
                                }
                              },
                              child: Text(
                                "出售",
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
      },
    );
  }
}

Widget detailDialog(BuildContext context,{OtcTradeArguments? arguments,double price = 0, double count = 0, double total = 0, String unit = ""}) {
  return SafeArea(
    child: Container(
      width: double.infinity,
      color: AppColor.bgColor1,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Column(
              children: [
                Text("確認${arguments?.type.text}",
                    style: TextStyle(
                      color: AppColor.textColor1,
                      fontWeight: FontWeight.w400,
                      fontFamily: "HelveticaNeue",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.center),
                addVerticalSpace(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("價格",
                        style: TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "HelveticaNeue",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center),
                    Text("$price CNY/$unit",
                        style: TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "HelveticaNeue",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
                addVerticalSpace(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("數量",
                        style: TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "HelveticaNeue",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center),
                    Text("$count $unit",
                        style: TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "HelveticaNeue",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
                addVerticalSpace(8.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("總額",
                        style: TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "HelveticaNeue",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center),
                    Text("$total CNY",
                        style: TextStyle(
                          color: AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "HelveticaNeue",
                          fontStyle: FontStyle.normal,
                          fontSize: 16.sp,
                        ),
                        textAlign: TextAlign.center),
                  ],
                ),
                addVerticalSpace(8.h),
                Container(
                  width: 166.w,
                  height: 44.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColor.bgColor2,
                  ),
                  child: ElevatedButton(
                    style: transparentButtonStyle(textHeight: 0),
                    onPressed: () {
                      SmartDialog.dismiss();
                      BlocProvider.of<OtcTradeCubit>(context).otcTrade(arguments!.type, OtcTradeRequest(
                        id: arguments.id,
                        coinId: arguments.coinId,
                        price: price,
                        money: total,
                        amount: count,
                      ));

                    },
                    child: Text(
                      "確認${arguments?.type.text}",
                      style: TextStyle(
                        color: AppColor.textColor1,
                        fontWeight: FontWeight.w700,
                        fontFamily: "HelveticaNeue",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp,
                      ),
                    ),
                  )
                )
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

Widget titleAndContent(String title, String content) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: TextStyle(color: AppColor.textColor1, fontWeight: FontWeight.w500, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 14.sp),
        textAlign: TextAlign.left,
      ),
      Expanded(
        child: Text(
          content,
          style: TextStyle(color: AppColor.textColor1, fontWeight: FontWeight.w500, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 14.sp),
          textAlign: TextAlign.left,
        ),
      ),
    ],
  );
}
