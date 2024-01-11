import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/domain/response/my_advertisement_page_response/otc_advertise_response.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/design/page/my_advertisement/my_advertisement_cubit.dart';

import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../model/routes_cubit/routes_cubit.dart';

class MyAdvertisementPage extends StatefulWidget {
  const MyAdvertisementPage({super.key});

  @override
  CurrentPageState<MyAdvertisementPage> createState() => _MyAdvertisementPageState();
}

class _MyAdvertisementPageState extends CurrentPageState<MyAdvertisementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            BlocProvider.of<RoutesCubit>(context).pop();
          },
          icon: const Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
        ),
        title: Text("我的廣告",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontFamily: "HelveticaNeue", fontStyle: FontStyle.normal, fontSize: 17.sp),
            textAlign: TextAlign.center),
        backgroundColor: const Color(0xff2e2e2e),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 10.h),
        child: BlocBuilder<MyAdvertisementCubit, MyAdvertisementState>(
          buildWhen: (previous, current) => previous.otcAdvertiseResponse != current.otcAdvertiseResponse,
          builder: (context, state) {
            OtcAdvertiseResult result = state.otcAdvertiseResponse?.data ?? OtcAdvertiseResult();
            return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: result.content.length,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    Container(
                      height: 110.h,
                      width: double.infinity,
                      color: Color(0xff2e2e2e),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 6.h,horizontal: 10.w),
                        child: Column(
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
                                    addHorizontalSpace(6.w),
                                    Text(
                                        result.content[index].member?.email ?? "",
                                        style: TextStyle(
                                            color:  Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "HelveticaNeue",
                                            fontStyle:  FontStyle.normal,
                                            fontSize: 17.sp
                                        ),
                                        textAlign: TextAlign.left
                                    )
                                  ],
                                ),
                                Text(
                                    "已下架",
                                    style: TextStyle(
                                        color:  const Color(0xff00cfbe),
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 13.sp
                                    ),
                                    textAlign: TextAlign.left
                                )
                              ],
                            ),
                            addVerticalSpace(14.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "数量:${result.content[index].remainAmount.toPrecisionString()}",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 12.sp
                                    ),
                                    textAlign: TextAlign.left
                                ),
                                Text(
                                    "購買",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 12.sp
                                    ),
                                    textAlign: TextAlign.left
                                )
                              ],
                            ),
                            addVerticalSpace(6.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    "限額:${result.content[index].minLimit.toPrecisionString()}~${result.content[index].maxLimit.toPrecisionString()}",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 12.sp
                                    ),
                                    textAlign: TextAlign.left
                                ),
                                Text(
                                    "单价",
                                    style: TextStyle(
                                        color:  Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: "HelveticaNeue",
                                        fontStyle:  FontStyle.normal,
                                        fontSize: 12.sp
                                    ),
                                    textAlign: TextAlign.left
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    addVerticalSpace(10.h)
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
