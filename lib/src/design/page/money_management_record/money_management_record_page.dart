import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/design/page/money_management_record/money_management_record_cubit.dart';
import '../../../../domain/request/money_management_record_page_request/invested_record_request.dart';
import '../../../../domain/response/money_management_response/invested_record_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../component/date_widget.dart';
import '../../model/routes_cubit/routes_cubit.dart';

class MoneyManagementRecordPage extends StatefulWidget {
  const MoneyManagementRecordPage({super.key});

  @override
  CurrentPageState<MoneyManagementRecordPage> createState() => _MoneyManagementRecordPageState();
}

class _MoneyManagementRecordPageState extends CurrentPageState<MoneyManagementRecordPage> {
  List<String> investedTypeList = ["BTC", "ETH", "FIL", "LTC", "SHIB", "USDT", "XRP"];
  String investedTypeSelected = "";
  List<OrderTypeLabel> orderTypeLabel = [
    const OrderTypeLabel(OrderType.current),
    const OrderTypeLabel(OrderType.regular),
  ];
  OrderTypeLabel? selectedOrderType;
  List<InvestedTypeLabel> investedTypeLabel = [
    const InvestedTypeLabel(InvestedType.invalid),
    const InvestedTypeLabel(InvestedType.valid),
    const InvestedTypeLabel(InvestedType.auto),
    const InvestedTypeLabel(InvestedType.hand),
    const InvestedTypeLabel(InvestedType.immediately),
    const InvestedTypeLabel(InvestedType.autoBuy),
  ];
  InvestedTypeLabel? selectedInvestedType;
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
          IconButton(
            icon: const Icon(
              Icons.pets,
              color: Colors.white,
            ),
            onPressed: () {
              SmartDialog.show(
                alignment: Alignment.topCenter,
                builder: (_) {
                  return selectDialog(context);
                },
              );
            },
          )
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
        title: Text("歷史紀錄",
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
        child: BlocBuilder<MoneyManagementRecordCubit, MoneyManagementRecordState>(
          buildWhen: (previous, current) =>
              previous.investedRecordList != current.investedRecordList || previous.total != current.total || previous.status != current.status,
          builder: (context, state) {
            switch (state.status) {
              // api未回傳前顯示loading
              case MoneyManagementRecordStatus.initial:
                return const Center(child: CircularProgressIndicator());
              // api回傳成功
              case MoneyManagementRecordStatus.success:
                return ListView.separated(
                  padding: EdgeInsets.zero,
                  itemCount: state.investedRecordList!.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == state.investedRecordList!.length - 1) {
                      /// 當未到達最後一筆就繼續取10筆
                      if (state.investedRecordList!.length < state.total) {
                        //获取数据
                        BlocProvider.of<MoneyManagementRecordCubit>(context).getInvestedRecord(
                            InvestedRecordRequest(
                              pageNo: state.page + 1,
                              pageSize: 10,
                              // symbol: selectedCoin == null ? null : selectedCoin!.unit,
                              // type: selectedOpType == null ? null : selectedOpType!.label.type,
                              // startTime: firstDate.text.isEmpty ? null : firstDate.text,
                              // endTime: lastDate.text.isEmpty ? null : lastDate.text,
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
                        InkWell(
                          onTap: () {
                            SmartDialog.show(
                              alignment: Alignment.bottomCenter,
                              builder: (_) {
                                return detailDialog(state.investedRecordList![index]);
                              },
                            );
                          },
                          child: Container(
                            height: 110.h,
                            color: Color(0xff2e2e2e),
                            child: Padding(
                              padding: EdgeInsets.only(top: 20.h, right: 8.w, left: 8.w),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        state.investedRecordList![index].coinUnit,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 17.sp),
                                      ),
                                      state.investedRecordList![index].status == 1
                                          ? Row(
                                              children: [
                                                Container(
                                                  width: 100.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    color: Color(0xff00cfbe),
                                                  ),
                                                  child: ElevatedButton(
                                                    style: transparentButtonStyle(textHeight: 0, borderRadius: 8.0),
                                                    onPressed: () {
                                                      BlocProvider.of<MoneyManagementRecordCubit>(context)
                                                          .investedRedeem(state.investedRecordList![index].id, 3);
                                                    },
                                                    child: Text(
                                                      "手動贖回",
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
                                                addHorizontalSpace(6.w),
                                                Container(
                                                  width: 100.w,
                                                  height: 20.h,
                                                  decoration: BoxDecoration(
                                                    borderRadius: BorderRadius.circular(8.0),
                                                    color: Color(0xff00cfbe),
                                                  ),
                                                  child: ElevatedButton(
                                                    style: transparentButtonStyle(textHeight: 0, borderRadius: 8.0),
                                                    onPressed: () {
                                                      BlocProvider.of<MoneyManagementRecordCubit>(context)
                                                          .investedRedeem(state.investedRecordList![index].id, 4);
                                                    },
                                                    child: Text(
                                                      "立即贖回",
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
                                              ],
                                            )
                                          : Text(
                                              BlocProvider.of<MoneyManagementRecordCubit>(context)
                                                  .getInvestedRecordType(state.investedRecordList![index].status),
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 17.sp),
                                            )
                                    ],
                                  ),
                                  addVerticalSpace(10.h),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 120.w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "投資金額",
                                              style: TextStyle(
                                                  color: Color(0xff828ea1),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                            ),
                                            Text(
                                              state.investedRecordList![index].investedAmount.toPrecisionString(),
                                              style: TextStyle(
                                                  color: Color(0xff828ea1),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        width: 120.w,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "年利率",
                                              style: TextStyle(
                                                  color: Color(0xff828ea1),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                            ),
                                            Text(
                                              "${(state.investedRecordList![index].annualRate.d() * 100.d()).toPrecisionString()}%",
                                              style: TextStyle(
                                                  color: Color(0xff828ea1),
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: "HelveticaNeue",
                                                  fontStyle: FontStyle.normal,
                                                  fontSize: 12.sp),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "投資金額",
                                                style: TextStyle(
                                                    color: Color(0xff828ea1),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "HelveticaNeue",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12.sp),
                                              ),
                                              Text(
                                                state.investedRecordList![index].totalInterestAmount,
                                                style: TextStyle(
                                                    color: Color(0xff828ea1),
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: "HelveticaNeue",
                                                    fontStyle: FontStyle.normal,
                                                    fontSize: 12.sp),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
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

  Widget selectDialog(BuildContext context) {
    return StatefulBuilder(builder: (BuildContext context, Function(void Function()) state) {
      return SafeArea(
        child: Container(
          margin: EdgeInsets.only(top: 50.h),
          width: double.infinity,
          color: Color(0xff2e2e2e),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  children: [
                    // Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    //   children: [
                    //     Text("交易對",
                    //         style: TextStyle(
                    //             color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 13.sp),
                    //         textAlign: TextAlign.center),
                    //     addVerticalSpace(8.h),
                    //     Container(
                    //       height: 46.h,
                    //       decoration: const BoxDecoration(color: Colors.white),
                    //       child: DropdownButtonHideUnderline(
                    //         child: DropdownButton2<String>(
                    //           icon: Padding(
                    //             padding: EdgeInsets.only(right: 10.w),
                    //             child: Image.asset(
                    //               'assets/images/icon_drop_menu.png',
                    //               width: 12.w,
                    //               height: 7.h,
                    //               fit: BoxFit.fill,
                    //             ),
                    //           ),
                    //           isDense: true,
                    //           items: investedTypeList.map<DropdownMenuItem<String>>((String data) {
                    //             return DropdownMenuItem(
                    //               value: data,
                    //               child: Builder(
                    //                 builder: (context) {
                    //                   return Text(
                    //                     data,
                    //                     style: TextStyle(
                    //                       color: Colors.black,
                    //                       fontSize: 14.sp,
                    //                     ),
                    //                   );
                    //                 },
                    //               ),
                    //             );
                    //           }).toList(),
                    //           value: investedTypeSelected,
                    //           hint: Padding(
                    //             padding: EdgeInsets.only(left: 16.w),
                    //             child: Text(
                    //               "請選擇",
                    //               style: TextStyle(
                    //                 fontSize: 14.sp,
                    //                 color: Colors.black,
                    //                 fontWeight: FontWeight.w400,
                    //                 fontStyle: FontStyle.normal,
                    //               ),
                    //               textAlign: TextAlign.left,
                    //             ),
                    //           ),
                    //           onChanged: (String? value) {
                    //             state(() {
                    //               investedTypeSelected = value!;
                    //             });
                    //           },
                    //           onMenuStateChange: (bool status) {
                    //             // buyFundAsyncStatus = status;
                    //           },
                    //           isExpanded: true,
                    //           itemHeight: 35.h,
                    //           offset: Offset(0, -4.h),
                    //           dropdownDecoration: BoxDecoration(
                    //             borderRadius: BorderRadius.circular(8.0),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    addVerticalSpace(8.h),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("交易對",
                            style: TextStyle(
                                color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 13.sp),
                            textAlign: TextAlign.center),
                        addVerticalSpace(8.h),
                        Container(
                          height: 46.h,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<OrderTypeLabel>(
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
                              items: orderTypeLabel.map<DropdownMenuItem<OrderTypeLabel>>((OrderTypeLabel data) {
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
                              value: selectedOrderType,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: Text(
                                  "請選擇",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              onChanged: (OrderTypeLabel? value) {
                                state(() {
                                  selectedOrderType = value;
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
                                color: Colors.white, fontWeight: FontWeight.w400, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 13.sp),
                            textAlign: TextAlign.center),
                        addVerticalSpace(8.h),
                        Container(
                          height: 46.h,
                          decoration: const BoxDecoration(color: Colors.white),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2<InvestedTypeLabel>(
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
                              items: investedTypeLabel.map<DropdownMenuItem<InvestedTypeLabel>>((InvestedTypeLabel data) {
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
                              value: selectedInvestedType,
                              hint: Padding(
                                padding: EdgeInsets.only(left: 16.w),
                                child: Text(
                                  "請選擇",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              onChanged: (InvestedTypeLabel? value) {
                                state(() {
                                  selectedInvestedType = value;
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
                              fontSize: 13.sp,
                            ),
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
                              selectedInvestedType = null; // 重置下拉
                              investedTypeSelected = "";
                              selectedOrderType = null;
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
                            // func(
                            //   AssetFlowRequest(
                            //     pageNo: 1,
                            //     pageSize: 10,
                            //     symbol: selectedCoin == null ? null : selectedCoin!.unit,
                            //     type: selectedOpType == null ? null : selectedOpType!.label.type,
                            //     startTime: firstDate.text.isEmpty ? null : firstDate.text,
                            //     endTime: lastDate.text.isEmpty ? null : lastDate.text,
                            //   ),
                            // );
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
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget detailDialog(Content content) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        color: Color(0xff2e2e2e),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 12.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  Text("歷史紀錄",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "HelveticaNeue",
                        fontStyle: FontStyle.normal,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center),
                  addVerticalSpace(8.h),
                  dialogItem("幣種", content.coinUnit),
                  dialogItem("投資金額", content.investedAmount.toPrecisionString()),
                  dialogItem("年利率", (content.annualRate.d() * 100.d()).toPrecisionString()),
                  dialogItem("總利息", content.totalInterestAmount),
                  dialogItem("訂單類型", content.optionType.toString()),
                  dialogItem("訂單狀態", content.status.toString()),
                  dialogItem("最新發送利息日期", "為提供"),
                  dialogItem("訂單編號", content.orderId),
                  dialogItem("有效天數", content.legalDays.toPrecisionString()),
                  dialogItem("開始日期", content.startDate.isEmpty ? "--" : content.startDate),
                  dialogItem("結束日期", content.endDate.isEmpty ? "--" : content.endDate),
                  dialogItem("贖回日期", content.redeemDate.isEmpty ? "--" : content.redeemDate),
                  dialogItem("訂單創立日期", content.createTime),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dialogItem(String title, String content) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: "HelveticaNeue",
              fontStyle: FontStyle.normal,
              fontSize: 14.sp,
            ),
          ),
          Text(
            content,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: "HelveticaNeue",
              fontStyle: FontStyle.normal,
              fontSize: 14.sp,
            ),
          ),
        ],
      ),
    );
  }
}
