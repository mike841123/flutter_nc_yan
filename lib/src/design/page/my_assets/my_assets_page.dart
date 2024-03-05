import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/config/routes.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/my_assets/my_assets_cubit.dart';
import '../../../../domain/response/public_response/asset_wallet_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import '../../component/check_widget.dart';
import '../../component/custom_text_field.dart';

class MyAssetsPage extends StatefulWidget {
  const MyAssetsPage({super.key});

  @override
  CurrentPageState<MyAssetsPage> createState() => _MyAssetsPageState();
}

class _MyAssetsPageState extends CurrentPageState<MyAssetsPage> {
  TextEditingController nameController = TextEditingController();
  CheckController isCheck = CheckController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyAssetsCubit, MyAssetsState>(
      buildWhen: (previous, current) =>
          previous.status != current.status ||
          previous.assetWalletResponse != previous.assetWalletResponse ||
          previous.isHideZeroAsset != current.isHideZeroAsset ||
          previous.searchText != current.searchText,
      builder: (context, state) {
        List<AssetWalletResult> assetList = state.isHideZeroAsset
            ? state.assetWalletResponse?.data?.where((element) => element.balance != 0).toList() ?? []
            : state.assetWalletResponse?.data ?? [];
        assetList = state.searchText.isNotEmpty ? assetList.where((element) => element.coin!.unit.contains(state.searchText)).toList() : assetList;
        assetList.sort((a, b) => a.id.compareTo(b.id));
        switch (state.status) {
          // api未回傳前顯示loading
          case MyAssetsStatus.initial:
            return const Center(child: CircularProgressIndicator());
          // api回傳成功
          case MyAssetsStatus.success:
            return Container(
              padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 14.w),
              child: Column(
                children: [
                  BlocBuilder<MyAssetsCubit, MyAssetsState>(
                    buildWhen: (previous, current) => previous.isHideAsset != current.isHideAsset,
                    builder: (context, isHideState) {
                      return Stack(
                        children: [
                          Image.asset(
                            'assets/images/img_uc_money_bg.png',
                            width: 358.w,
                            height: 120.h,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            left: 20.w,
                            top: 14.h,
                            child: Row(
                              children: [
                                Text(
                                  "總資產約(合USDT)",
                                  style: TextStyle(color: AppColor.textColor1, fontSize: 16.sp),
                                ),
                                addHorizontalSpace(4.w),
                                InkWell(
                                  onTap: () {
                                    BlocProvider.of<MyAssetsCubit>(context).updateIsHideAsset();
                                  },
                                  child: Icon(
                                    Icons.remove_red_eye,
                                    color: AppColor.bgColor5,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Positioned(
                            left: 20.w,
                            top: 50.h,
                            child: Text(
                              isHideState.isHideAsset ? "********" : BlocProvider.of<MyAssetsCubit>(context).getTotalUsdtAsset().toPrecisionString(),
                              style: TextStyle(color: AppColor.textColor1, fontSize: 22.sp, fontWeight: FontWeight.w800),
                            ),
                          ),
                          Positioned(
                            left: 20.w,
                            top: 84.h,
                            child: Text(
                              isHideState.isHideAsset
                                  ? "******"
                                  : "\u2248 ${BlocProvider.of<MyAssetsCubit>(context).getTotalCnyAsset().toPrecisionString()} CNY",
                              style: TextStyle(color: AppColor.textColor1, fontSize: 16.sp),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: () {
                              BlocProvider.of<MyAssetsCubit>(context).updateSearchText(nameController.text);
                            },
                            child: Icon(
                              Icons.search_sharp,
                              color: AppColor.bgColor5,
                            ),
                          ),
                          CustomTextField(
                            isShowBorder: false,
                            width: 180.w,
                            nameController,
                            hint: "輸入幣種名稱搜尋",
                          ),
                        ],
                      ),
                      CheckWidget(
                        isCheck,
                        text: "隱藏為0的幣種",
                        onTap: (value) {
                          BlocProvider.of<MyAssetsCubit>(context).updateIsHideZeroAsset(value ?? false);
                        },
                      )
                    ],
                  ),
                  Container(
                    height: 1.h,
                    decoration: BoxDecoration(color: AppColor.bgColor5),
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: assetList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: () {
                            SmartDialog.show(
                              alignment: Alignment.bottomCenter,
                              builder: (_) {
                                return SafeArea(
                                  child: Container(
                                    decoration:  BoxDecoration(
                                      color: AppColor.bgColor1,
                                      borderRadius: const BorderRadius.only(
                                        topLeft: Radius.circular(16),
                                        topRight: Radius.circular(16)
                                      ),
                                    ),
                                    width: double.infinity,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Column(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                SmartDialog.dismiss();
                                                BlocProvider.of<RoutesCubit>(context).changePage(Routes.recharge);
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                                child: Text("充幣",
                                                    style: TextStyle(
                                                      color: AppColor.textColor7,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "HelveticaNeue",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 20.sp,
                                                    ),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                            Container(height: 1, color: AppColor.bgColor5),
                                            InkWell(
                                              onTap: () {
                                                print("12");
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                padding: EdgeInsets.symmetric(vertical: 10.h),
                                                child: Text("提幣",
                                                    style: TextStyle(
                                                      color: AppColor.textColor6,
                                                      fontWeight: FontWeight.w600,
                                                      fontFamily: "HelveticaNeue",
                                                      fontStyle: FontStyle.normal,
                                                      fontSize: 20.sp,
                                                    ),
                                                    textAlign: TextAlign.center),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 10.h),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  assetList[index].coin?.unit ?? "",
                                  style: TextStyle(
                                    color: AppColor.textColor1,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                addVerticalSpace(10.h),
                                Row(
                                  children: [
                                    Expanded(
                                      flex: 1,
                                      child: DefaultTextStyle(
                                        style: TextStyle(color: AppColor.textColor1, fontSize: 14.sp),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("可用資產"),
                                            Text(assetList[index].balance.toPrecisionString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: DefaultTextStyle(
                                        style: TextStyle(color: AppColor.textColor1, fontSize: 14.sp),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("凍結資產"),
                                            Text(assetList[index].frozenBalance.toPrecisionString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: DefaultTextStyle(
                                        style: TextStyle(color: AppColor.textColor1, fontSize: 14.sp),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            const Text("待釋放資產"),
                                            Text(assetList[index].toReleased.toPrecisionString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Container(
                          width: 342.w,
                          height: 1.h,
                          decoration: BoxDecoration(color: AppColor.bgColor5),
                        ); // 分隔符
                      },
                    ),
                  )
                ],
              ),
            );
          default:
            return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
