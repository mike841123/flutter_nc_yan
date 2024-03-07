import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/abstract/current_page_state.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import 'package:yan_demo_fcm/src/design/model/market_cubit/market_cubit.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';

import '../../../config/app_color.dart';
import '../../../config/routes.dart';

class MarketPage extends StatefulWidget {
  const MarketPage({Key? key}) : super(key: key);

  @override
  State<MarketPage> createState() => _MarketPageState();
}

class _MarketPageState extends CurrentPageState<MarketPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = ["自選", "USDT"];

  @override
  void initState() {
    BlocProvider.of<MarketCubit>(context).getUsdtCnyRate();
    BlocProvider.of<MarketCubit>(context).getMarketSymbolList();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          onTap: (value) {
            if (value != _tabController.index) {
              if (value == 0) {

              }
              if (value == 1) {
                BlocProvider.of<MarketCubit>(context).getMarketSymbolList();
              }
            }
          },
          tabAlignment: TabAlignment.center,
          // 不加的話左邊會有padding
          indicatorPadding: EdgeInsets.zero,
          labelPadding: EdgeInsets.zero,
          indicatorColor: AppColor.bgColor2,
          controller: _tabController,
          tabs: tabs
              .map(
                (e) => Container(
                  width: MediaQuery.of(context).size.width / tabs.length,
                  height: 50.h,
                  alignment: Alignment.center,
                  child: Text(
                    e,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontFamily: "HelveticaNeue",
                      fontStyle: FontStyle.normal,
                      fontSize: 13.sp,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
        Expanded(
            child: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _tabController,
          children: tabs.map((e) {
            return BlocBuilder<MarketCubit, MarketState>(
              builder: (context, state) {
                return state.symbolList.isEmpty
                    ? empty()
                    : ListView.separated(
                        itemCount: state.symbolList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              BlocProvider.of<RoutesCubit>(context).changePage(Routes.trade);
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.symbolList[index].symbol,
                                          style: TextStyle(color: AppColor.textColor1, fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.h),
                                        ),
                                        addVerticalSpace(10.h),
                                        Text(
                                          "24H量${state.symbolList[index].volume.toPrecisionString()}",
                                          style: TextStyle(color: AppColor.textColor3, fontSize: 14.sp, height: 1.h),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          state.symbolList[index].usdRate.toPrecisionString(),
                                          style: TextStyle(color: AppColor.textColor6, fontSize: 14.sp, height: 1.h),
                                        ),
                                        addVerticalSpace(10.h),
                                        Text(
                                          "≈${(state.symbolList[index].usdRate.d() * state.usdtCnyRate.d()).toPrecisionString()}",
                                          style: TextStyle(color: AppColor.textColor3, fontSize: 14.sp, height: 1.h),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: 24.h,
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(Radius.circular(4)),
                                        color: state.symbolList[index].chg < 0 ? AppColor.bgColor6 : AppColor.bgColor8),
                                    child: Text(
                                      "${(state.symbolList[index].chg.d() * 100.d()).toPrecisionString()}%",
                                      style: TextStyle(color: AppColor.textColor1),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Container(
                            height: 1.h,
                            color: AppColor.bgColor5,
                          );
                        },
                      );
              },
            );
          }).toList(),
        )),
      ],
    );
  }
}
