import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/advertise_response.dart';
import 'package:yan_demo_fcm/src/design/page/home/home_cubit.dart';

import '../../../../domain/response/home_page_response/announcement_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_color.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  CurrentPageState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends CurrentPageState<HomePage> {
  @override
  void initState() {
    print("123");
    BlocProvider.of<HomeCubit>(context).init();
    super.initState();
  }
  List<MarketSymbolData> dataUpAndDown = [
    MarketSymbolData(symbol: "BTC/USDT", close: 36563.560000, chg: 0.0376, volume: 1321.755000),
    MarketSymbolData(symbol: "ETH/USDT", close: 36563.560000, chg: 0.0376, volume: 1321.755000),
    MarketSymbolData(symbol: "FIL/USDT", close: 4.58, chg: 0.0676, volume: 23.45),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            color: Colors.white,
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                addVerticalSpace(10.h),
                BlocBuilder<HomeCubit, HomeState>(
                  buildWhen: (previous, current) => previous.advertiseResponse != current.advertiseResponse,
                  builder: (context, state) {
                    List<AdvertiseItem> list = state.advertiseResponse?.data ?? [];
                    return list.isEmpty
                        ? empty()
                        : CarouselSlider(
                            options: CarouselOptions(
                              height: 180.h,
                              viewportFraction: 1,
                              enableInfiniteScroll: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                            ),
                            items: list.map(
                              (item) {
                                return Image.network(
                                  item.url,
                                  fit: BoxFit.fill,
                                  width: 390.w,
                                  height: 310.h,
                                  loadingBuilder: loadingBuilder(56.r),
                                  errorBuilder: (BuildContext context, Object child, StackTrace? stackTrace) {
                                    return Center(
                                      child: SvgPicture.asset(
                                        "assets/images/img_network_error.svg",
                                        width: 100.r,
                                        height: 100.r,
                                        color: AppColor.color3,
                                        fit: BoxFit.fill,
                                      ),
                                    );
                                  },
                                );
                              },
                            ).toList(),
                          );
                  },
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset(
                          'assets/images/img_horn.png',
                          width: 14.r,
                          height: 14.r,
                          fit: BoxFit.fill,
                        ),
                        addHorizontalSpace(4.w),
                        BlocBuilder<HomeCubit, HomeState>(
                          buildWhen: (previous, current) => previous.announcementResponse != current.announcementResponse,
                          builder: (context, state) {
                            AnnouncementResult result = state.announcementResponse?.data ?? AnnouncementResult();
                            return SizedBox(
                              height: 20.h,
                              width: 250.w,
                              child: CarouselSlider(
                                options: CarouselOptions(
                                  scrollDirection: Axis.vertical,
                                  autoPlay: true,
                                  autoPlayInterval: const Duration(seconds: 4),
                                ),
                                items: result.content.map(
                                      (item) {
                                    return InkWell(
                                      onTap: () {
                                        // BlocProvider.of<RoutesCubit>(context).changePage(
                                        //   Routes.newsContent,
                                        //   arguments: NewsContentArguments(NewsType.news, item.newsId!),
                                        // );
                                      },
                                      child: Text(
                                        item.title,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          height: 1.1.h,
                                          color: Color(0xff1a1a1a),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    Text(
                      "更多",
                      style: TextStyle(
                        color: Color(0xff1199fa),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 12.sp,
                      ),
                    )
                  ],
                ),
                addVerticalSpace(10.h),
              ],
            ),
          ),
          addVerticalSpace(10.h),
          Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 14.h, left: 20.w, right: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "我的資產",
                        style: TextStyle(
                          color: Color(0xff1a1a1a),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                        ),
                      ),
                      addVerticalSpace(4.h),
                      Text(
                        "登入後可查看",
                        style: TextStyle(
                          color: Color(0xff6b6b6b),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          fontSize: 12.sp,
                        ),
                      ),
                      addVerticalSpace(6.h),
                      Container(
                        padding: EdgeInsets.symmetric(vertical: 2.h),
                        width: 85.w,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                          border: Border.all(color: Color(0xffa6adb4), width: 1.w),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "登入/註冊",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xff1199fa),
                            fontSize: 13.sp,
                          ),
                        ),
                      )
                    ],
                  ),
                  Image.asset(
                    "assets/images/img_home_asset.png",
                    fit: BoxFit.fill,
                    width: 110.w,
                    height: 100.h,
                  ),
                ],
              ),
            ),
          ),
          addVerticalSpace(1.w),
          Row(
            children: [
              Container(
                height: 100.h,
                width: (MediaQuery.of(context).size.width) / 2 - 1.w,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h, left: 20.w, right: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "幫助",
                            style: TextStyle(
                              color: Color(0xff1a1a1a),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              fontSize: 16.sp,
                            ),
                          ),
                          addVerticalSpace(10.h),
                          Text(
                            "問題/指南/資料",
                            style: TextStyle(
                              color: Color(0xff6b6b6b),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/images/img_home_help.png",
                        fit: BoxFit.fill,
                        width: 40.r,
                        height: 40.r,
                      ),
                    ],
                  ),
                ),
              ),
              addHorizontalSpace(1.w),
              Container(
                height: 100.h,
                width: (MediaQuery.of(context).size.width) / 2 - 1.w,
                color: Colors.white,
                child: Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 10.h, left: 20.w, right: 30.w),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "幫助",
                            style: TextStyle(
                              color: Color(0xff1a1a1a),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              fontSize: 16.sp,
                            ),
                          ),
                          addVerticalSpace(10.h),
                          Text(
                            "問題/指南/資料",
                            style: TextStyle(
                              color: Color(0xff6b6b6b),
                              fontWeight: FontWeight.w400,
                              fontFamily: "Inter",
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                      Image.asset(
                        "assets/images/img_home_ad.png",
                        fit: BoxFit.fill,
                        width: 40.r,
                        height: 40.r,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          addVerticalSpace(10.h),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                CarouselSlider.builder(
                  itemCount: dataUpAndDown.length ~/ 3,
                  itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                    height: 114.h,
                    color: Color(0xff7977B1),
                    child: Row(
                      children: [
                        for (int i = 0; i < dataUpAndDown.length; i++)
                          SizedBox(
                            width: (MediaQuery.of(context).size.width) / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "BTC/USDT",
                                  style: TextStyle(
                                    color: Color(0xffD4D4D4),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
                                  ),
                                ),
                                addVerticalSpace(4.h),
                                Text(
                                  "36591.11",
                                  style: TextStyle(
                                    color: Color(0xff39D7A1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
                                  ),
                                ),
                                addVerticalSpace(4.h),
                                Text(
                                  "+3.88%",
                                  style: TextStyle(
                                    color: Color(0xff39D7A1),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                    fontSize: 12.sp,
                                  ),
                                ),
                                addVerticalSpace(4.h),
                                Text(
                                  "=267150.73.CNY",
                                  style: TextStyle(
                                    color: Color(0xffABABAB),
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          )
                      ],
                    ),
                  ),
                  options: CarouselOptions(
                    height: 114.h,
                    viewportFraction: 1,
                    enableInfiniteScroll: false,
                    autoPlay: false,
                    onPageChanged: (index, reason) {
                      // BlocProvider.of<HomeCubit>(context).updateCarouselCurrentPage(index);
                    },
                  ),
                ),
                addVerticalSpace(10.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < dataUpAndDown.length ~/ 3; i++)
                      Container(
                        margin: EdgeInsets.only(right: 4.w),
                        height: 2.h,
                        width: 10.w,
                        color: Color(0xff7EBDE9),
                      )
                  ],
                ),
                addVerticalSpace(10.h),
              ],
            ),
          ),
          addVerticalSpace(10.h),
          Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                color: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  "漲幅榜",
                  style: TextStyle(
                    color: Color(0xff6b6b6b),
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                  ),
                ),
              ),
              addVerticalSpace(1.w),
              Container(
                color: Colors.white,
                height: 6.h,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                color: Color(0xff7977B1),
                child: Column(
                  children: [
                    for (int i = 0; i < dataUpAndDown.length; i++)
                      Padding(
                        padding: EdgeInsets.only(bottom: i == dataUpAndDown.length - 1 ? 0 : 20.h),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 160.w,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 4.h),
                                    child: Container(
                                      width: 16.r,
                                      height: 16.r,
                                      decoration: const BoxDecoration(
                                        color: Color(0xff00A56C),
                                      ),
                                      alignment: Alignment.center,
                                      child: Text(
                                        (i + 1).toString(),
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontSize: 10.sp,
                                        ),
                                      ),
                                    ),
                                  ),
                                  addHorizontalSpace(8.w),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "BTC/USDT",
                                        style: TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      addVerticalSpace(6.h),
                                      Text(
                                        "24H量2714.1719",
                                        style: TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "4.5",
                                        style: TextStyle(
                                          color: Color(0xff39D7A1),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          fontSize: 14.sp,
                                        ),
                                      ),
                                      addVerticalSpace(6.h),
                                      Text(
                                        "=33.24CNY",
                                        style: TextStyle(
                                          color: Color(0xffD4D4D4),
                                          fontWeight: FontWeight.w400,
                                          fontFamily: "Inter",
                                          fontSize: 12.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 2.h),
                                    width: 60.w,
                                    decoration: BoxDecoration(
                                      color: Color(0xff00A56C),
                                      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                    ),
                                    alignment: Alignment.center,
                                    child: Text(
                                      "+6.02%",
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Color(0xffD4D4D4),
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MarketSymbolData {
  final String symbol;
  final double close;
  final double chg;
  final double volume;

  MarketSymbolData({required this.symbol, required this.close, required this.chg, required this.volume});
}
