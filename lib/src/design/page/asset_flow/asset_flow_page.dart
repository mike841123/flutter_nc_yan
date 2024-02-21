import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import '../../../../domain/request/asset_flow_page_request/asset_flow_request.dart';
import '../../../../domain/response/asset_flow_page_response/withdraw_coin_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import '../../component/date_widget.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'asset_flow_cubit.dart';

class AssetFlowPage extends StatefulWidget {
  const AssetFlowPage({super.key});

  @override
  CurrentPageState<AssetFlowPage> createState() => _AssetFlowPageState();
}

class _AssetFlowPageState extends CurrentPageState<AssetFlowPage> with SingleTickerProviderStateMixin {
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
      backgroundColor: AppColor.bgColor4,
      appBar: CustomAppBar(
        title: "資產流水",
        actions: [
          BlocBuilder<AssetFlowCubit, AssetFlowState>(
              buildWhen: (previous, current) => previous.withdrawCoinResponse != current.withdrawCoinResponse,
              builder: (context, state) {
                List<WithdrawCoinItem> list = state.withdrawCoinResponse?.data ?? [];
                return IconButton(
                  icon: const Icon(
                    Icons.pets,
                  ),
                  onPressed: () {
                    attachDialog(context, list, BlocProvider.of<AssetFlowCubit>(context).getAssetFlow);
                  },
                );
              })
        ],
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
                return state.assetFlowList!.isEmpty
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
                        itemCount: state.assetFlowList!.length,
                        itemBuilder: (BuildContext context, int index) {
                          if (index == state.assetFlowList!.length - 1) {
                            /// 當未到達最後一筆就繼續取10筆
                            if (state.assetFlowList!.length < state.total) {
                              //获取数据
                              BlocProvider.of<AssetFlowCubit>(context).getAssetFlow(
                                  AssetFlowRequest(
                                    pageNo: state.page + 1,
                                    pageSize: 10,
                                    symbol: selectedCoin?.unit,
                                    type: selectedOpType?.label.type,
                                    startTime: firstDate.text.isEmpty ? null : firstDate.text,
                                    endTime: lastDate.text.isEmpty ? null : lastDate.text,
                                  ),
                                  isInit: false);
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
                                color: AppColor.bgColor1,
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
                                                color: AppColor.textColor1,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "HelveticaNeue",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 16.sp),
                                            textAlign: TextAlign.left,
                                          ),
                                          Text(
                                            "已完成",
                                            style: TextStyle(
                                                color: AppColor.textColor1,
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
                            decoration: BoxDecoration(color: AppColor.bgColor5),
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
          style: TextStyle(color: AppColor.textColor1, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 12.sp),
          textAlign: TextAlign.left,
        ),
        Text(
          content,
          style: TextStyle(color: AppColor.textColor1, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 12.sp),
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
                  color: AppColor.bgColor1,
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
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.center),
                            addVerticalSpace(8.h),
                            Container(
                              height: 46.h,
                              decoration: BoxDecoration(color: AppColor.bgColor5),
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
                                              color: AppColor.textColor8,
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
                                        color: AppColor.textColor8,
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
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.center),
                            addVerticalSpace(8.h),
                            Container(
                              height: 46.h,
                              decoration: BoxDecoration(color: AppColor.bgColor5),
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
                                              color: AppColor.textColor8,
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
                                      "請選擇 ${list.isEmpty ? "(暫無數據)" : ""}",
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
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "HelveticaNeue",
                                    fontStyle: FontStyle.normal,
                                    fontSize: 13.sp),
                                textAlign: TextAlign.center),
                            addVerticalSpace(8.h),
                            DateWidget(
                              firstDate,
                              key: UniqueKey(),
                              height: 50.h,
                              width: 370.w,
                              bgColor: AppColor.bgColor5,
                            ),
                            addVerticalSpace(6.h),
                            DateWidget(
                              lastDate,
                              key: UniqueKey(),
                              height: 50.h,
                              width: 370.w,
                              bgColor: AppColor.bgColor5,
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
                              },
                              child: Container(
                                width: 166.w,
                                height: 44.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20.0),
                                  color: AppColor.bgColor5,
                                ),
                                child: Center(
                                  child: Text(
                                    "重置",
                                    style: TextStyle(
                                      color: AppColor.textColor8,
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
                                    symbol: selectedCoin?.unit,
                                    type: selectedOpType?.label.type,
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
                                  color: AppColor.bgColor2,
                                ),
                                child: Center(
                                  child: Text(
                                    "確定",
                                    style: TextStyle(
                                      color: AppColor.textColor8,
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
