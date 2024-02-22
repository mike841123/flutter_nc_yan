import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/domain/request/otc_page_request/otc_order_request.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import '../../../../domain/response/otc_page_response/otc_order_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../config/app_color.dart';
import '../../../config/routes.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'otc_list_cubit.dart';

class OtcListPage extends StatefulWidget {
  const OtcListPage({super.key});

  @override
  CurrentPageState<OtcListPage> createState() => _OtcListPageState();
}

class _OtcListPageState extends CurrentPageState<OtcListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<OrderStatus> tabs = [OrderStatus.unpaid, OrderStatus.paid, OrderStatus.finish, OrderStatus.cancel, OrderStatus.appeal];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 0,
    );
    _tabController.addListener(() {
      if (!_tabController.indexIsChanging) {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          onTap: (value) {
            BlocProvider.of<OtcListCubit>(context).getOtcOrder(
                OtcOrderRequest(
                  pageNo: 0,
                  pageSize: 10,
                  status: _getSelectedStatus(value),
                ),
                isInit: true);
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
                    BlocProvider.of<OtcListCubit>(context).getOrderStatusText(e),
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
            return BlocBuilder<OtcListCubit, OtcListState>(
              buildWhen: (previous, current) =>
                  previous.otcOrderList != current.otcOrderList || previous.total != current.total || previous.status != current.status,
              builder: (context, state) {
                switch (state.status) {
                  // api未回傳前顯示loading
                  case OtcListStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  // api回傳成功
                  case OtcListStatus.success:
                    return ListView.separated(
                      padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
                      itemCount: state.otcOrderList!.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (index == state.otcOrderList!.length - 1) {
                          /// 當未到達最後一筆就繼續取10筆
                          if (state.otcOrderList!.length < state.total) {
                            //获取数据
                            BlocProvider.of<OtcListCubit>(context).getOtcOrder(
                                OtcOrderRequest(
                                  pageNo: state.page + 1,
                                  pageSize: 10,
                                  status: _getSelectedStatus(_tabController.index),
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
                        return _orderItem(state.otcOrderList![index]);
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
        )),
      ],
    );
  }

  Widget _orderItem(Content result) {
    return InkWell(
      onTap: () {
        BlocProvider.of<RoutesCubit>(context).changePage(Routes.otcDetails, arguments: result.orderSn);
      },
      child: Container(
        height: 70.h,
        color: AppColor.bgColor1,
        padding: EdgeInsets.only(right: 18.w, left: 20.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  'assets/images/img_default_header.png',
                  width: 50.r,
                  height: 50.r,
                  fit: BoxFit.fill,
                ),
                addHorizontalSpace(10.w),
                Expanded(
                  child: SizedBox(
                    height: 70.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.orderSn,
                              style: TextStyle(
                                  color: AppColor.textColor1,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              result.name,
                              style: TextStyle(
                                  color: AppColor.textColor1,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "HelveticaNeue",
                                  fontStyle: FontStyle.normal,
                                  fontSize: 12.sp),
                            ),
                            Text(
                              "${result.amount.toPrecisionString()} ${result.unit}",
                              style: TextStyle(
                                  color: AppColor.textColor1,
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
                                color: result.type == 1 ? AppColor.bgColor2 : AppColor.bgColor6,
                              ),
                              child: ElevatedButton(
                                style: transparentButtonStyle(textHeight: 0, borderRadius: 8.0),
                                onPressed: () {},
                                child: Text(
                                  result.type == 1 ? "買入${result.unit}" : "賣出${result.unit}",
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
                            addVerticalSpace(4.h),
                            Text(
                              "${result.money.toPrecisionString()}CNY",
                              style: TextStyle(
                                  color: AppColor.textColor1,
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
    );
  }

  int _getSelectedStatus(int index) {
    switch (index) {
      case 0:
        return OrderStatus.unpaid.value;
      case 1:
        return OrderStatus.paid.value;
      case 2:
        return OrderStatus.finish.value;
      case 3:
        return OrderStatus.cancel.value;
      case 4:
        return OrderStatus.appeal.value;
      default:
        return 0;
    }
  }
}
