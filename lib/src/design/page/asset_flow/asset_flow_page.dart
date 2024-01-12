import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import '../../../../domain/request/asset_flow_page_request/asset_flow_request.dart';
import '../../../../domain/response/asset_flow_page_response/withdraw_coin_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../component/date_widget.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'asset_flow_cubit.dart';

class AssetFlowPage extends StatefulWidget {
  const AssetFlowPage({super.key});

  @override
  CurrentPageState<AssetFlowPage> createState() => _AssetFlowPageState();
}

class _AssetFlowPageState extends CurrentPageState<AssetFlowPage> with SingleTickerProviderStateMixin {
  final _scrollController = ScrollController();
  WithdrawCoinItem? selectedCoin;
  OpTypeLabel? selectedOpType;
  TextEditingController firstDate = TextEditingController();
  TextEditingController lastDate = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        actions: [
          BlocBuilder<AssetFlowCubit, AssetFlowState>(
              buildWhen: (previous, current) => previous.withdrawCoinResponse != current.withdrawCoinResponse,
              builder: (context, state) {
                List<WithdrawCoinItem> list = state.withdrawCoinResponse?.data ?? [];
                return IconButton(
                  icon: const Icon(
                    Icons.pets,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    attachDialog(context, list, BlocProvider.of<AssetFlowCubit>(context).getAssetFlow);
                  },
                );
              })
        ],
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<RoutesCubit>(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
        title: Text("資產流水",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontFamily: "HelveticaNeue",
              fontStyle: FontStyle.normal,
              fontSize: 17.sp,
            ),
            textAlign: TextAlign.center),
        backgroundColor: const Color(0xff2e2e2e),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: 30.h),
        child: BlocBuilder<AssetFlowCubit, AssetFlowState>(
          buildWhen: (previous, current) =>
              previous.assetFlowList != current.assetFlowList || previous.total != current.total || previous.status != current.status,
          builder: (context, state) {
            switch (state.status) {
              // api未回傳前顯示loading
              case AssetFlowStatus.initial:
                return const Center(child: CircularProgressIndicator());
              // api回傳成功
              case AssetFlowStatus.success:
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: state.assetFlowList!.length,
                  controller: _scrollController,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == state.assetFlowList!.length - 1) {
                      /// 當未到達最後一筆就繼續取10筆
                      if (state.assetFlowList!.length < state.total) {
                        //获取数据
                        BlocProvider.of<AssetFlowCubit>(context).getAssetFlow(
                            AssetFlowRequest(
                              pageNo: state.page + 1,
                              pageSize: 10,
                              symbol: selectedCoin == null ? null : selectedCoin!.unit,
                              type: selectedOpType == null ? null : selectedOpType!.label.type,
                              startTime: firstDate.text.isEmpty ? null : firstDate.text,
                              endTime: lastDate.text.isEmpty ? null : lastDate.text,
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
                          color: Color(0xff2e2e2e),
                          child: Padding(
                            padding: EdgeInsets.only(top: 6.h, bottom: 6.h, right: 8.w, left: 8.w),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      state.assetFlowList![index].symbol,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "HelveticaNeue",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.left,
                                    ),
                                    Text(
                                      "已完成",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w700,
                                          fontFamily: "HelveticaNeue",
                                          fontStyle: FontStyle.normal,
                                          fontSize: 16.sp),
                                      textAlign: TextAlign.right,
                                    )
                                  ],
                                ),
                                addVerticalSpace(8.h),
                                assetFlowItem("充幣地址", "--"),
                                addVerticalSpace(8.h),
                                assetFlowItem("充直數量", state.assetFlowList![index].amount.toPrecisionString()),
                                addVerticalSpace(8.h),
                                assetFlowItem("類型", "幣幣交易"),
                                addVerticalSpace(8.h),
                                assetFlowItem("應付手續費", state.assetFlowList![index].fee.toPrecisionString()),
                                addVerticalSpace(8.h),
                                assetFlowItem("抵扣手續費", state.assetFlowList![index].discountFee),
                                addVerticalSpace(8.h),
                                assetFlowItem("實付手續費", state.assetFlowList![index].realFee),
                                addVerticalSpace(8.h),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Container(
                      width: 342.w,
                      height: 1.h,
                      decoration: BoxDecoration(color: Colors.white),
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

  Widget assetFlowItem(String title, String content) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(color: Colors.white, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 12.sp),
          textAlign: TextAlign.left,
        ),
        Text(
          content,
          style: TextStyle(color: Colors.white, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 12.sp),
          textAlign: TextAlign.right,
        ),
      ],
    );
  }

  void attachDialog(BuildContext context, List<WithdrawCoinItem> list, Function(AssetFlowRequest request) func) {
    List<OpTypeLabel> opTypeList = [const OpTypeLabel(OpType.recharge), const OpTypeLabel(OpType.cash), const OpTypeLabel(OpType.transfer)];
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(0.5),
      builder: (_) => StatefulBuilder(builder: (BuildContext context, Function(void Function()) state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: EdgeInsets.only(top: 50.h),
                child: Container(
                  width: double.infinity,
                  color: Color(0xff2e2e2e),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("交易對",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.center),
                            addVerticalSpace(8.h),
                            Container(
                              height: 46.h,
                              decoration: const BoxDecoration(color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<WithdrawCoinItem>(
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Image.asset(
                                      'assets/images/icon_drop_menu.png',
                                      width: 12.w,
                                      height: 7.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  isDense: true,
                                  items: list.map<DropdownMenuItem<WithdrawCoinItem>>((WithdrawCoinItem data) {
                                    return DropdownMenuItem(
                                      value: data,
                                      child: Builder(
                                        builder: (context) {
                                          return Text(
                                            data.unit,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                  value: selectedCoin,
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 16.w),
                                    child: Text(
                                      "請選擇 ${list.isEmpty ? "(占無數據)" : ""}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  onChanged: (WithdrawCoinItem? value) {
                                    state(() {
                                      selectedCoin = value;
                                    });
                                  },
                                  onMenuStateChange: (bool status) {
                                    // buyFundAsyncStatus = status;
                                  },
                                  isExpanded: true,
                                  itemHeight: 35.h,
                                  offset: Offset(0, -4.h),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        addVerticalSpace(8.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("交易對",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.center),
                            addVerticalSpace(8.h),
                            Container(
                              height: 46.h,
                              decoration: const BoxDecoration(color: Colors.white),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton2<OpTypeLabel>(
                                  icon: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: Image.asset(
                                      'assets/images/icon_drop_menu.png',
                                      width: 12.w,
                                      height: 7.h,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  isDense: true,
                                  items: opTypeList.map<DropdownMenuItem<OpTypeLabel>>((OpTypeLabel data) {
                                    return DropdownMenuItem(
                                      value: data,
                                      child: Builder(
                                        builder: (context) {
                                          return Text(
                                            data.label.value,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 14.sp,
                                            ),
                                          );
                                        },
                                      ),
                                    );
                                  }).toList(),
                                  value: selectedOpType,
                                  hint: Padding(
                                    padding: EdgeInsets.only(left: 16.w),
                                    child: Text(
                                      "請選擇 ${list.isEmpty ? "(占無數據)" : ""}",
                                      style: TextStyle(
                                        fontSize: 14.sp,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  onChanged: (OpTypeLabel? value) {
                                    state(() {
                                      selectedOpType = value;
                                    });
                                  },
                                  onMenuStateChange: (bool status) {
                                    // buyFundAsyncStatus = status;
                                  },
                                  isExpanded: true,
                                  itemHeight: 35.h,
                                  offset: Offset(0, -4.h),
                                  dropdownDecoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        addVerticalSpace(8.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("起始時間",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.center),
                            addVerticalSpace(8.h),
                            DateWidget(
                              firstDate,
                              key: UniqueKey(),
                              height: 34.h,
                              width: 370.w,
                              borderWidth: 0,
                              bgColor: Colors.white,
                              borderRadius: 4,
                            ),
                            addVerticalSpace(6.h),
                            DateWidget(
                              lastDate,
                              key: UniqueKey(),
                              height: 34.h,
                              width: 370.w,
                              borderWidth: 0,
                              bgColor: Colors.white,
                              borderRadius: 4,
                            ),
                          ],
                        ),
                        addVerticalSpace(26.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                state(() {
                                  selectedCoin = null; // 重置下拉
                                  selectedOpType = null;
                                  firstDate.clear();
                                  lastDate.clear();
                                });

                                // func(AssetFlowRequest(pageNo: 1, pageSize: 10));
                                // BlocProvider.of<RoutesCubit>(context).pop();
                              },
                              child: Container(
                                width: 166.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Color(0xffffffff),
                                ),
                                child: Center(
                                  child: Text(
                                    "重置",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            addHorizontalSpace(4.w),
                            InkWell(
                              onTap: () {
                                func(
                                  AssetFlowRequest(
                                    pageNo: 1,
                                    pageSize: 10,
                                    symbol: selectedCoin == null ? null : selectedCoin!.unit,
                                    type: selectedOpType == null ? null : selectedOpType!.label.type,
                                    startTime: firstDate.text.isEmpty ? null : firstDate.text,
                                    endTime: lastDate.text.isEmpty ? null : lastDate.text,
                                  ),
                                );
                                BlocProvider.of<RoutesCubit>(context).pop();
                              },
                              child: Container(
                                width: 166.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: Color(0xff00cfbe),
                                ),
                                child: Center(
                                  child: Text(
                                    "確定",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
