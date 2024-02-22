import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import 'package:yan_demo_fcm/src/design/model/user_cubit/user_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/otc_list/otc_list_cubit.dart';
import '../../../../domain/response/otc_page_response/otc_order_detail_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../config/app_color.dart';

import 'otc_details_cubit.dart';

class OtcDetailsPage extends StatefulWidget {
  const OtcDetailsPage({super.key});

  @override
  CurrentPageState<OtcDetailsPage> createState() => _OtcDetailsPageState();
}

class _OtcDetailsPageState extends CurrentPageState<OtcDetailsPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtcDetailsCubit, OtcDetailsState>(
      buildWhen: (previous, current) => previous.otcOrderDetailResult != current.otcOrderDetailResult,
      builder: (context, state) {
        return state.otcOrderDetailResult == null
            ? const Center(child: CircularProgressIndicator())
            : CustomScrollView(
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                rowTextItem(
                                  "訂單狀態",
                                  BlocProvider.of<OtcDetailsCubit>(context).getOrderTypeText(state.otcOrderDetailResult?.status ?? 0),
                                  titleStyle: TextStyle(
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.sp,
                                  ),
                                  contentStyle: TextStyle(
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 16.sp,
                                  ),
                                ),
                                addVerticalSpace(10.h),
                                Text(
                                  "訂單信息",
                                  style: TextStyle(
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                addVerticalSpace(10.h),
                                rowTextItem("交易對象", state.otcOrderDetailResult?.otherSide ?? ""),
                                rowTextItem("訂單編號", state.otcOrderDetailResult?.orderSn ?? ""),
                                rowTextItem("交易價格", "${state.otcOrderDetailResult?.price.toPrecisionString()} CNY"),
                                rowTextItem("交易數量", "${state.otcOrderDetailResult?.amount.toPrecisionString()} ${state.otcOrderDetailResult?.unit ?? ""}"),
                                rowTextItem("交易時間", state.otcOrderDetailResult?.createTime ?? ""),
                                rowTextItem("交易金額", "${state.otcOrderDetailResult?.money.toPrecisionString()} CNY"),
                                addVerticalSpace(10.h),
                                Text(
                                  "支付信息",
                                  style: TextStyle(
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                addVerticalSpace(10.h),
                                _payInfoItem("alipay", "支付寶帳號", state.otcOrderDetailResult?.payInfo?.alipay?.aliNo ?? "",
                                    qrcodeImg: state.otcOrderDetailResult?.payInfo?.alipay?.qrCodeUrl ?? ""),
                                _payInfoItem("wechat", "微信帳號", state.otcOrderDetailResult?.payInfo?.wechatPay?.wechat ?? "",
                                    qrcodeImg: state.otcOrderDetailResult?.payInfo?.wechatPay?.qrWeCodeUrl ?? ""),
                                _payInfoItem("bank", "銀行卡帳號", state.otcOrderDetailResult?.payInfo?.bankInfo?.cardNo ?? "",
                                    isQrcode: false, bankInfo: state.otcOrderDetailResult?.payInfo?.bankInfo),
                              ],
                            ),
                          ),
                        ),
                        state.otcOrderDetailResult?.status == OrderStatus.unpaid.value ||
                                state.otcOrderDetailResult?.status == OrderStatus.paid.value ||
                                state.otcOrderDetailResult?.status == OrderStatus.appeal.value
                            ? Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height: 50.h,
                                      decoration: BoxDecoration(color: AppColor.bgColor2),
                                      child: ElevatedButton(
                                        style: transparentButtonStyle(textHeight: 0, borderRadius: 0),
                                        onPressed: () {
                                          // 按钮1的点击事件处理逻辑
                                        },
                                        child: Text(
                                          "訂單申訴",
                                          style: TextStyle(
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Container(
                                      height: 50.h,
                                      decoration: BoxDecoration(color: AppColor.bgColor7),
                                      child: ElevatedButton(
                                        style: transparentButtonStyle(textHeight: 0, borderRadius: 0),
                                        onPressed: () {
                                          SmartDialog.show(
                                            builder: (_) {
                                              return promptDialog(state.otcOrderDetailResult?.orderSn ?? "");
                                            },
                                          );
                                        },
                                        child: Text(
                                          "取消交易",
                                          style: TextStyle(
                                              color: AppColor.bgColor4,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 16.sp),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : empty(),
                      ],
                    ),
                  )
                ],
              );
      },
    );
  }

  _payInfoItem(String imgSrc, String title, String content, {bool isQrcode = true, String qrcodeImg = "", BankInfo? bankInfo}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Image.asset(
                "assets/images/img_paymode_$imgSrc.png",
                fit: BoxFit.fill,
                width: 20.r,
                height: 20.r,
              ),
              addHorizontalSpace(8.w),
              Text(
                title,
                style: TextStyle(
                  color: AppColor.textColor1,
                  fontWeight: FontWeight.w700,
                  fontFamily: "HelveticaNeue",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.sp,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                content.isEmpty ? "用戶暫未添加$title" : content,
                style: TextStyle(
                  color: AppColor.textColor1,
                  fontWeight: FontWeight.w700,
                  fontFamily: "HelveticaNeue",
                  fontStyle: FontStyle.normal,
                  fontSize: 14.sp,
                ),
              ),
              addHorizontalSpace(8.w),
              InkWell(
                onTap: () async {
                  if (content.isNotEmpty) {
                    String imgUrl = await BlocProvider.of<UserCubit>(context).getS3ImgUrl(qrcodeImg);
                    SmartDialog.show(
                      alignment: Alignment.bottomCenter,
                      builder: (_) {
                        return detailDialog(title, imgUrl: imgUrl, bankInfo: bankInfo, isQrcode: bankInfo == null);
                      },
                    );
                  }
                },
                child: Icon(
                  size: 18.r,
                  isQrcode ? Icons.qr_code : Icons.info_outline,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget promptDialog(String id) {
    return Container(
      width: 300.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: AppColor.bgColor1,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 不然彈窗會變全螢幕
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Text(
              "提示",
              style:
                  TextStyle(color: AppColor.textColor1, fontWeight: FontWeight.w700, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
            ),
          ),
          Container(
            width: 300.w,
            height: 1.h,
            decoration: BoxDecoration(color: AppColor.bgColor4),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 14.w),
            child: Text(
              "已付款向並不退還！您確定取消訂單嗎？",
              style:
                  TextStyle(color: AppColor.textColor1, fontWeight: FontWeight.w700, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 16.sp),
            ),
          ),
          Container(
            width: 300.w,
            height: 1.h,
            decoration: BoxDecoration(color: AppColor.bgColor4),
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColor.bgColor1,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0), // 左下角圆角
                    ),
                  ), // 左下角圆角),
                  child: ElevatedButton(
                    style: transparentButtonStyle(textHeight: 0, borderRadius: 0),
                    onPressed: () {
                      SmartDialog.dismiss();
                    },
                    child: Text(
                      "取消",
                      style: TextStyle(
                          color: AppColor.textColor1, fontWeight: FontWeight.w700, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: AppColor.bgColor1,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(12.0), // 左下角圆角
                    ),
                  ), // 左下角圆角),
                  child: ElevatedButton(
                    style: transparentButtonStyle(textHeight: 0, borderRadius: 0),
                    onPressed: () {
                      BlocProvider.of<OtcDetailsCubit>(context).otcOrderCancel(id, () {
                        SmartDialog.dismiss();
                      });
                    },
                    child: Text(
                      "確定",
                      style: TextStyle(
                          color: AppColor.textColor1, fontWeight: FontWeight.w700, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 14.sp),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget detailDialog(
    String title, {
    bool isQrcode = true,
    String imgUrl = "",
    BankInfo? bankInfo,
  }) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: AppColor.bgColor1,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              isQrcode
                  ? Image.network(
                      imgUrl,
                      width: 100.r,
                      height: 100.r,
                      fit: BoxFit.fill,
                      loadingBuilder: loadingBuilder(100.r),
                      errorBuilder: (BuildContext context, Object child, StackTrace? stackTrace) {
                        return Center(
                          child: SvgPicture.asset(
                            "assets/images/img_network_error.svg",
                            width: 100.r,
                            height: 100.r,
                            fit: BoxFit.fill,
                          ),
                        );
                      },
                    )
                  : Column(
                      children: [
                        rowTextItem("開戶銀行", bankInfo?.bank ?? ""),
                        rowTextItem("開戶支行", bankInfo?.branch ?? ""),
                        rowTextItem("銀行卡號", bankInfo?.cardNo ?? ""),
                      ],
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
