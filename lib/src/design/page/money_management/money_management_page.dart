import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yan_demo_fcm/src/design/page/money_management/money_management_cubit.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/routes.dart';
import '../../model/routes_cubit/routes_cubit.dart';

class MoneyManagementPage extends StatefulWidget {
  const MoneyManagementPage({super.key});

  @override
  CurrentPageState<MoneyManagementPage> createState() => _MoneyManagementPageState();
}

class _MoneyManagementPageState extends CurrentPageState<MoneyManagementPage> {
  List<String> investedTypeList = ["BTC", "ETH", "FIL", "LTC", "SHIB", "USDT", "XRP"];

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
              BlocProvider.of<RoutesCubit>(context).changePage(Routes.moneyManagementRecord);
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
        title: Text("理財",
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
      body: BlocBuilder<MoneyManagementCubit, MoneyManagementState>(
        buildWhen: (previous, current) => previous.investedRateResponse != current.investedRateResponse,
        builder: (context, state) {
          return state.investedRateResponse == null
              ? empty()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                            "https://h5-qa.ncpro.io/img/assets/img/finances-pc.png",
                            fit: BoxFit.fill,
                            width: 390.w,
                            height: 200.h,
                            loadingBuilder: loadingBuilder(56.r),
                            errorBuilder: (BuildContext context, Object child, StackTrace? stackTrace) {
                              return Center(
                                child: SvgPicture.asset(
                                  "assets/images/img_network_error.svg",
                                  width: 100.r,
                                  height: 100.r,
                                  fit: BoxFit.cover,
                                ),
                              );
                            },
                          ),
                          Column(
                            children: [
                              Text("NCex理財",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 30.sp),
                                  textAlign: TextAlign.left),
                              addVerticalSpace(14.h),
                              Text("简单又安全。搜寻热门币种，立即赚取收益。",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontFamily: "HelveticaNeue",
                                      fontStyle: FontStyle.normal,
                                      fontSize: 16.sp),
                                  textAlign: TextAlign.left),
                            ],
                          ),
                        ],
                      ),
                      addVerticalSpace(2.h),
                      Column(
                        children: [
                          for (int i = 0; i < investedTypeList.length; i++)
                            Container(
                              margin: EdgeInsets.only(bottom: 2.h),
                              width: 390.w,
                              height: 60.h,
                              color: Color(0xff192330),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(
                                        'assets/images/${investedTypeList[i]}.png',
                                        width: 35.w,
                                        height: 35.h,
                                        fit: BoxFit.fill,
                                      ),
                                      Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            investedTypeList[i],
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "HelveticaNeue",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 18.sp),
                                          ),
                                          addVerticalSpace(4.h),
                                          Text(
                                            investedTypeList[i],
                                            style: TextStyle(
                                                color: Color(0xff7c7c7c),
                                                fontWeight: FontWeight.w700,
                                                fontFamily: "HelveticaNeue",
                                                fontStyle: FontStyle.normal,
                                                fontSize: 14.sp),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                      BlocProvider.of<MoneyManagementCubit>(context).getRate(state.investedRateResponse!.data![investedTypeList[i]]),
                                        style: TextStyle(
                                            color: Color(0xff00b275),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.sp),
                                      ),
                                      addVerticalSpace(4.h),
                                      Text(
                                        "ARP",
                                        style: TextStyle(
                                            color: Color(0xff7c7c7c),
                                            fontWeight: FontWeight.w600,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle: FontStyle.normal,
                                            fontSize: 14.sp),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )
                        ],
                      )
                    ],
                  ),
                );
        },
      ),
    );
  }
}
