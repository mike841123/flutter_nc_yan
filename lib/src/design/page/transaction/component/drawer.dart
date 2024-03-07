import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';

import '../../../../../driven/util/widget_util.dart';
import '../../../../config/app_color.dart';
import '../../../model/market_cubit/market_cubit.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key, required this.tabs, required this.tabController}) : super(key: key);

  final List<String> tabs;
  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColor.bgColor4,
      width: 280.w,
      child: Column(
        children: [
          TabBar(
            onTap: (value) {
              if (value != tabController.index) {
                if (value == 0) {}
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
            controller: tabController,
            tabs: tabs
                .map(
                  (e) => Container(
                    width: 140.w,
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
              child: Container(
            color: AppColor.bgColor1,
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: tabController,
              children: tabs.map((e) {
                return BlocBuilder<MarketCubit, MarketState>(
                  builder: (context, state) {
                    return state.symbolList.isEmpty
                        ? empty()
                        : ListView.separated(
                            itemCount: state.symbolList.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                padding: EdgeInsets.symmetric(vertical: 18.h),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        state.symbolList[index].symbol,
                                        style: TextStyle(color: AppColor.textColor1, fontSize: 16.sp, fontWeight: FontWeight.w600, height: 1.h),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        state.symbolList[index].usdRate.toPrecisionString(),
                                        style: TextStyle(color: AppColor.textColor6, fontSize: 14.sp, height: 1.h),
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
            ),
          )),
        ],
      ),
    );
  }
}
