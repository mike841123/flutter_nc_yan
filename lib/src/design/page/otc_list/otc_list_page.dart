import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import '../../../../domain/response/otc_page_response/otc_order_pre_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import 'otc_list_cubit.dart';

class OtcListPage extends StatefulWidget {
  const OtcListPage({super.key});

  @override
  CurrentPageState<OtcListPage> createState() => _OtcListPageState();
}

class _OtcListPageState extends CurrentPageState<OtcListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = ["未付款", "已付款", "已完成", "已取消", "申訴中"];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(() {});
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OtcListCubit, OtcListState>(
      buildWhen: (previous, current) => previous.otcOrderPreResponse != current.otcOrderPreResponse,
      builder: (context, state) {
        OtcOrderPreResult result = state.otcOrderPreResponse?.data ?? OtcOrderPreResult();
        return Column(
          children: [
            TabBar(
              indicatorColor: Color(0xff00cfbe),
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
              controller: _tabController,
              children: tabs.map((e) {
                return BlocBuilder<OtcListCubit, OtcListState>(
                  buildWhen: (previous, current) => previous.otcOrderPreResponse != current.otcOrderPreResponse,
                  builder: (context, state) {
                    return ListView.separated(
                      itemCount: 10,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Container(
                              height: 70.h,
                              color: Color(0xff2e2e2e),
                              padding: EdgeInsets.only(right: 18.w, left: 20.w),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      SizedBox(width: 50.r, height: 50.h, child: const CircleAvatar()),
                                      addHorizontalSpace(10.w),
                                      Expanded(
                                        child: SizedBox(
                                          height: 70.h,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text(
                                                    "123",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "HelveticaNeue",
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 12.sp),
                                                  ),
                                                  Text(
                                                    "123",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "HelveticaNeue",
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 12.sp),
                                                  ),
                                                  Text(
                                                    "123",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "HelveticaNeue",
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 12.sp),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(
                                                    width: 76.w,
                                                    height: 26.h,
                                                    decoration: BoxDecoration(
                                                      borderRadius: BorderRadius.circular(8.0),
                                                      color: true ? Color(0xff00cfbe) : Color(0xfff15057),
                                                    ),
                                                    child: ElevatedButton(
                                                      style: transparentButtonStyle(textHeight: 0, borderRadius: 8.0),
                                                      onPressed: () {
                                                        // BlocProvider.of<RoutesCubit>(context).changePage(Routes.otcTrade,
                                                        //     arguments: OtcTradeArguments(
                                                        //       type: state.advertiseUnitList![index].advertiseType == 1 ? OtcAdvertiseType.buy : OtcAdvertiseType.sell,
                                                        //       id: state.advertiseUnitList![index].advertiseId,
                                                        //       coinId: state.advertiseUnitList![index].coinId,
                                                        //       unit: state.advertiseUnitList![index].unit,
                                                        //     ));
                                                      },
                                                      child: Text(
                                                        true ? "購買" : "出售",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight: FontWeight.w700,
                                                          fontFamily: "HelveticaNeue",
                                                          fontStyle: FontStyle.normal,
                                                          fontSize: 12.sp,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  addVerticalSpace(4.h),
                                                  Text(
                                                    "123",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontWeight: FontWeight.w500,
                                                        fontFamily: "HelveticaNeue",
                                                        fontStyle: FontStyle.normal,
                                                        fontSize: 12.sp),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return SizedBox(
                          height: 1.h,
                        );
                      },
                    );
                  },
                );
              }).toList(),
            )),
          ],
        );
      },
    );
  }
}
