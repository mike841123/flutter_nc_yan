import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/my_advertisement/my_advertisement_cubit.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import '../../../config/routes.dart';

class MyAdvertisementPage extends StatefulWidget {
  const MyAdvertisementPage({super.key});

  @override
  CurrentPageState<MyAdvertisementPage> createState() => _MyAdvertisementPageState();
}

class _MyAdvertisementPageState extends CurrentPageState<MyAdvertisementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor4,
      appBar: CustomAppBar(
        title: "我的廣告",
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 14.w),
            child: InkWell(
              onTap: () {
                BlocProvider.of<RoutesCubit>(context).changePage(Routes.advertiseAd);
              },
              child: Text(
                "發佈廣告",
                style: TextStyle(
                  color: AppColor.textColor1,
                  fontWeight: FontWeight.w500,
                  fontFamily: "HelveticaNeue",
                  fontStyle: FontStyle.normal,
                  fontSize: 16.sp,
                ),
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<MyAdvertisementCubit, MyAdvertisementState>(
          buildWhen: (previous, current) =>
              previous.otcAdvertiseList != current.otcAdvertiseList || previous.total != current.total || previous.status != current.status,
          builder: (context, state) {
            switch (state.status) {
              // api未回傳前顯示loading
              case MyAdvertisementStatus.initial:
                return const Center(child: CircularProgressIndicator());
              // api回傳成功
              case MyAdvertisementStatus.success:
                return state.otcAdvertiseList!.isEmpty
                    ? Center(
                        child: Text(
                          "暫無紀錄",
                          style: TextStyle(
                            color: AppColor.textColor1,
                            fontWeight: FontWeight.w700,
                            fontFamily: "HelveticaNeue",
                            fontStyle: FontStyle.normal,
                            fontSize: 16.sp,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.separated(
                        padding: EdgeInsets.zero,
                        itemCount: state.otcAdvertiseList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == state.otcAdvertiseList!.length - 1) {
                            /// 當未到達最後一筆就繼續取10筆
                            if (state.otcAdvertiseList!.length < state.total) {
                              //获取数据
                              BlocProvider.of<MyAdvertisementCubit>(context).getOtcAdvertise(state.page + 1, isInit: false);
                              //加载时显示loading
                              return Container(
                                alignment: Alignment.center,
                                child: SizedBox(
                                  width: 24.r,
                                  height: 24.r,
                                  child: const CircularProgressIndicator(strokeWidth: 2.0),
                                ),
                              );
                            }
                          }
                          return Column(
                            children: [
                              Container(
                                height: 110.h,
                                width: double.infinity,
                                color: AppColor.bgColor1,
                                child: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6.h, horizontal: 10.w),
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
                                              addHorizontalSpace(6.w),
                                              Text(state.otcAdvertiseList![index].member?.email ?? "",
                                                  style: TextStyle(
                                                      color: AppColor.textColor1,
                                                      fontWeight: FontWeight.w500,
                                                      fontFamily: "HelveticaNeue",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 18.sp),
                                                  textAlign: TextAlign.left)
                                            ],
                                          ),
                                          Text(state.otcAdvertiseList![index].status == 1 ? "下架" : "上架",
                                              style: TextStyle(
                                                  color: AppColor.textColor2,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 14.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                      addVerticalSpace(14.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "数量:${state.otcAdvertiseList![index].remainAmount.toPrecisionString()} ${state.otcAdvertiseList![index].coin?.name ?? ""}",
                                              style: TextStyle(
                                                  color: AppColor.textColor1,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left),
                                          Text("購買",
                                              style: TextStyle(
                                                  color: AppColor.textColor1,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                      addVerticalSpace(6.h),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                              "限額:${state.otcAdvertiseList![index].minLimit.toPrecisionString()}~${state.otcAdvertiseList![index].maxLimit.toPrecisionString()}",
                                              style: TextStyle(
                                                  color: AppColor.textColor1,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left),
                                          Text("单价",
                                              style: TextStyle(
                                                  color: AppColor.textColor1,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                              textAlign: TextAlign.left)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 14.h,
                          );
                        },
                      );
              default:
                return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
