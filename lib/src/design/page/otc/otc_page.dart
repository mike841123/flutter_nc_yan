import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/asset_flow_request.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/config/app_color.dart';
import 'package:yan_demo_fcm/src/design/page/otc/otc_cubit.dart';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/routes.dart';
import '../../model/routes_cubit/routes_cubit.dart';

class OtcPage extends StatefulWidget {
  const OtcPage({super.key});

  @override
  CurrentPageState<OtcPage> createState() => _OtcPageState();
}

class _OtcPageState extends CurrentPageState<OtcPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = [];
  int initIndex = 0;

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < BlocProvider.of<OtcCubit>(context).state.otcCoinResponse!.data!.length; i++) {
      tabs.add(BlocProvider.of<OtcCubit>(context).state.otcCoinResponse!.data![i].unit);
      if (BlocProvider.of<OtcCubit>(context).state.otcCoinResponse!.data![i].unit == "USDT") {
        initIndex = i;
      }
    }
    _tabController = TabController(
      length: BlocProvider.of<OtcCubit>(context).state.otcCoinResponse!.data!.length,
      vsync: this,
      initialIndex: initIndex,
    );
    _tabController.addListener(() {
      BlocProvider.of<OtcCubit>(context).getAdvertiseUnit(
        AdvertiseUnitRequest(
            pageNo: 1,
            pageSize: 10,
            advertiseType: BlocProvider.of<OtcCubit>(context).state.advertiseType,
            unit: BlocProvider.of<OtcCubit>(context).state.otcCoinResponse!.data![_tabController.index].unit),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(
              'assets/images/img_otc_bg.png',
              width: 390.w,
              height: 200.h,
              fit: BoxFit.fill,
            ),
            Column(
              children: [
                Text(
                  "法幣交易",
                  style: TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.w700,
                    fontFamily: "HelveticaNeue",
                    fontStyle: FontStyle.normal,
                    fontSize: 30.sp,
                  ),
                ),
                addVerticalSpace(14.h),
                Text("简单又安全。搜寻热门币种，立即赚取收益。",
                    style: TextStyle(
                      color: AppColor.textColor1,
                      fontWeight: FontWeight.w600,
                      fontFamily: "HelveticaNeue",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.sp,
                    ),
                    textAlign: TextAlign.left),
              ],
            ),
          ],
        ),
        Container(
          color: AppColor.bgColor1,
          child: Column(
            children: [
              addVerticalSpace(10.h),
              ToggleSwitch(
                minWidth: 67.w,
                minHeight: 26.h,
                fontSize: 16.sp,
                initialLabelIndex: 0,
                activeBgColor: const [Color(0xff00cfbe)],
                activeFgColor: AppColor.bgColor5,
                inactiveBgColor: AppColor.bgColor5,
                inactiveFgColor: AppColor.textColor2,
                totalSwitches: 2,
                borderColor: const [Color(0xff00cfbe)],
                borderWidth: 1.w,
                cornerRadius: 8,
                labels: const ['買入', '賣出'],
                onToggle: (index) {
                  if (index == 0) {
                    BlocProvider.of<OtcCubit>(context).updateSwitchBtn(1, _tabController.index);
                  }
                  if (index == 1) {
                    BlocProvider.of<OtcCubit>(context).updateSwitchBtn(0, _tabController.index);
                  }
                },
              ),
              BlocBuilder<OtcCubit, OtcState>(
                buildWhen: (previous, current) => previous.otcCoinResponse != current.otcCoinResponse,
                builder: (context, state) {
                  return TabBar(
                    tabAlignment: TabAlignment.center,
                    // 不加的話左邊會有padding
                    indicatorPadding: EdgeInsets.zero,
                    labelPadding: EdgeInsets.zero,
                    isScrollable: true,
                    indicatorColor: AppColor.bgColor2,
                    controller: _tabController,
                    tabs: tabs
                        .map(
                          (e) => Container(
                            width: 60.w,
                            height: 50.h,
                            alignment: Alignment.center,
                            child: Text(
                              e,
                              style: TextStyle(
                                color: AppColor.textColor1,
                                fontWeight: FontWeight.w500,
                                fontFamily: "HelveticaNeue",
                                fontStyle: FontStyle.normal,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                        )
                        .toList(),
                  );
                },
              )
            ],
          ),
        ),
        Expanded(
            child: TabBarView(
          controller: _tabController,
          children: tabs.map((e) {
            return BlocBuilder<OtcCubit, OtcState>(
              buildWhen: (previous, current) => previous.advertiseUnitList != current.advertiseUnitList,
              builder: (context, state) {
                switch (state.status) {
                  // api未回傳前顯示loading
                  case OtcStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  // api回傳成功
                  case OtcStatus.success:
                    return ListView.separated(
                      padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                      itemCount: state.advertiseUnitList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == state.advertiseUnitList!.length - 1) {
                          /// 當未到達最後一筆就繼續取10筆
                          if (state.advertiseUnitList!.length < state.total) {
                            //获取数据
                            BlocProvider.of<OtcCubit>(context).getAdvertiseUnit(
                                AdvertiseUnitRequest(
                                  pageNo: state.page + 1,
                                  pageSize: 10,
                                  advertiseType: state.advertiseType,
                                  unit: state.otcCoinResponse!.data![_tabController.index].unit,
                                ),
                                isInit: false);
                            //加载时显示loading
                            return Container(
                              alignment: Alignment.center,
                              child: const SizedBox(
                                width: 24.0,
                                height: 24.0,
                                child: CircularProgressIndicator(strokeWidth: 2.0),
                              ),
                            );
                          }
                        }
                        return Column(
                          children: [
                            Container(
                              color: AppColor.bgColor1,
                              padding: EdgeInsets.only(right: 18.w, left: 20.w, top: 10.h, bottom: 10.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                          addHorizontalSpace(14.w),
                                          Text(
                                            state.advertiseUnitList![index].memberName,
                                            style: TextStyle(
                                                color: AppColor.textColor1,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: "HelveticaNeue",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 18.sp),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        state.advertiseUnitList![index].transactions.toPrecisionString(),
                                        style: TextStyle(
                                            color: AppColor.textColor1,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 12.sp),
                                      )
                                    ],
                                  ),
                                  addVerticalSpace(13.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("数量:${state.advertiseUnitList![index].remainAmount.toPrecisionString()}",
                                          style: TextStyle(
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.sp),
                                          textAlign: TextAlign.left),
                                      Text("單價",
                                          style: TextStyle(
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.sp),
                                          textAlign: TextAlign.left),
                                    ],
                                  ),
                                  addVerticalSpace(9.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                          "限額:${state.advertiseUnitList![index].minLimit.toPrecisionString()}~${state.advertiseUnitList![index].maxLimit.toPrecisionString()}CNY",
                                          style: TextStyle(
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.sp),
                                          textAlign: TextAlign.left),
                                      Text(
                                        "${state.advertiseUnitList![index].price}CNY",
                                        style: TextStyle(
                                            color: AppColor.textColor1,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 13.sp),
                                      )
                                    ],
                                  ),
                                  addVerticalSpace(13.h),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          for (int i = 0;
                                              i < BlocProvider.of<OtcCubit>(context).getPayModeList(state.advertiseUnitList![index].payMode!).length;
                                              i++)
                                            Padding(
                                              padding: EdgeInsets.only(right: 4.w),
                                              child: Image.asset(
                                                "assets/images/img_paymode_${BlocProvider.of<OtcCubit>(context).getPayModeImageSrc(BlocProvider.of<OtcCubit>(context).getPayModeList(state.advertiseUnitList![index].payMode!)[i])}.png",
                                                fit: BoxFit.fill,
                                                width: 20.r,
                                                height: 20.r,
                                              ),
                                            ),
                                        ],
                                      ),
                                      Container(
                                        width: 76.w,
                                        height: 26.h,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8.0),
                                          color: state.advertiseUnitList![index].advertiseType == 1 ? AppColor.bgColor2 : AppColor.bgColor6,
                                        ),
                                        child: ElevatedButton(
                                          style: transparentButtonStyle(textHeight: 0, borderRadius: 8.0),
                                          onPressed: () {
                                            BlocProvider.of<RoutesCubit>(context).changePage(Routes.otcTrade,
                                                arguments: OtcTradeArguments(
                                                  type: state.advertiseUnitList![index].advertiseType == 1 ? OtcAdvertiseType.buy : OtcAdvertiseType.sell,
                                                  id: state.advertiseUnitList![index].advertiseId,
                                                  coinId: state.advertiseUnitList![index].coinId,
                                                  unit: state.advertiseUnitList![index].unit,
                                                ));
                                          },
                                          child: Text(
                                            state.advertiseUnitList![index].advertiseType == 1 ? "購買" : "出售",
                                            style: TextStyle(
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w700,
                                              fontFamily: "HelveticaNeue",
                                              fontStyle: FontStyle.normal,
                                              fontSize: 12.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 16.h,
                        );
                      },
                    );
                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            );
          }).toList(),
        ))
      ],
    );
  }
}
