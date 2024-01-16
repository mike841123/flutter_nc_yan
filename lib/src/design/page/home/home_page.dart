import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/advertise_response.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/config/app_config.dart';
import 'package:yan_demo_fcm/src/design/page/home/home_cubit.dart';

import '../../../../domain/response/home_page_response/announcement_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_color.dart';
import '../../../config/routes.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import '../../model/user_cubit/user_cubit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  CurrentPageState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends CurrentPageState<HomePage> {
  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).getBalance();
    BlocProvider.of<HomeCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        leadingWidth: 120.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 20.w),
          child: SvgPicture.asset(
            "assets/images/img_chat.svg",
            fit: BoxFit.contain,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 20.w),
            child: InkWell(
              onTap: (){
                BlocProvider.of<RoutesCubit>(context).changePage(Routes.chatContent);
              },
              child: SvgPicture.asset(
                "assets/images/img_icon.svg",
                fit: BoxFit.contain,
                width: 20.r,
                height: 20.r,
              ),
            ),
          ),
        ],
        backgroundColor: const Color(0xff2e2e2e),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Advisement(),
            addVerticalSpace(10.h),
            const MyAsset(),
            addVerticalSpace(1.w),
            const HelpAndNewsArea(),
            addVerticalSpace(10.h),
            const Symbol(),
            addVerticalSpace(10.h),
            const UpAndDown(),
          ],
        ),
      ),
    );
  }
}

class Advisement extends StatelessWidget {
  const Advisement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2e2e2e),
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
                                    color: Colors.white,
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
    );
  }
}

class MyAsset extends StatelessWidget {
  const MyAsset({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff2e2e2e),
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
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                    fontSize: 16.sp,
                  ),
                ),
                addVerticalSpace(4.h),
                BlocBuilder<UserCubit, UserState>(
                  buildWhen: (previous, current) => previous.balance != current.balance,
                  builder: (context, state) {
                    return Text(
                      AppConfig.token.isNotEmpty ? "總資產" : "登入後可查看",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 12.sp,
                      ),
                    );
                  },
                ),
                addVerticalSpace(6.h),
                AppConfig.token.isEmpty ? Container(
                  padding: EdgeInsets.symmetric(vertical: 2.h),
                  width: 85.w,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                    border: Border.all(color: Color(0xffa6adb4), width: 1.w),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "註冊/登入",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontFamily: "Inter",
                      fontSize: 12.sp,
                    ),
                  ),
                ) : BlocBuilder<UserCubit, UserState>(
                  buildWhen: (previous, current) => previous.balance != current.balance,
                  builder: (context, state) {
                    return Text(
                      state.balance.toPrecisionString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 12.sp,
                      ),
                    );
                  },
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
    );
  }
}

class HelpAndNewsArea extends StatelessWidget {
  const HelpAndNewsArea({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 100.h,
          width: (MediaQuery.of(context).size.width) / 2 - 1.w,
          color: Color(0xff2e2e2e),
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
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 16.sp,
                      ),
                    ),
                    addVerticalSpace(10.h),
                    Text(
                      "問題/指南/資料",
                      style: TextStyle(
                        color: Colors.white,
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
          color: Color(0xff2e2e2e),
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
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 16.sp,
                      ),
                    ),
                    addVerticalSpace(10.h),
                    Text(
                      "問題/指南/資料",
                      style: TextStyle(
                        color: Colors.white,
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
    );
  }
}

class Symbol extends StatelessWidget {
  const Symbol({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => previous.symbolList != current.symbolList,
          builder: (context, state) {
            return state.symbolList.isEmpty
                ? empty()
                : Container(
                    color: Color(0xff2e2e2e),
                    child: CarouselSlider.builder(
                      itemCount: state.symbolList.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
                        height: 114.h,
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width) / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.symbolList[itemIndex].symbol,
                                style: TextStyle(
                                  color: Color(0xffD4D4D4),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  fontSize: 14.sp,
                                ),
                              ),
                              addVerticalSpace(4.h),
                              Text(
                                state.symbolList[itemIndex].usdRate.toPrecisionString(),
                                style: TextStyle(
                                  color: state.symbolList[itemIndex].chg > 0 ? Color(0xff39D7A1) : Color(0xffef8995),
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  fontSize: 14.sp,
                                ),
                              ),
                              addVerticalSpace(4.h),
                              Text(
                                "${(state.symbolList[itemIndex].chg.d() * 100.d()).toPrecisionString()}%",
                                style: TextStyle(
                                  color: state.symbolList[itemIndex].chg > 0 ? Color(0xff39D7A1) : Color(0xffef8995),
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
                        ),
                      ),
                      options: CarouselOptions(
                        initialPage: 1,
                        enableInfiniteScroll: true,
                        viewportFraction: 0.33333,
                        height: 114.h,
                        autoPlay: false,
                        onPageChanged: (index, reason) {
                          // BlocProvider.of<HomeCubit>(context).updateCarouselCurrentPage(index);
                        },
                      ),
                    ),
                  );
          },
        ),
        addVerticalSpace(10.h),
      ],
    );
  }
}

class UpAndDown extends StatelessWidget {
  const UpAndDown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          width: double.infinity,
          color: Color(0xff2e2e2e),
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "漲幅榜",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: "Inter",
              fontSize: 14.sp,
            ),
          ),
        ),
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) => previous.symbolList != current.symbolList,
          builder: (context, state) {
            if (state.symbolList.isNotEmpty) {
              state.symbolList.sort((left, right) => (right.chg).compareTo(left.chg));
            }
            return state.symbolList.isEmpty
                ? empty()
                : Container(
                    padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.h),
                    color: Color(0xff2e2e2e),
                    child: Column(
                      children: [
                        for (int i = 0; i < state.symbolList.length; i++)
                          Padding(
                            padding: EdgeInsets.only(bottom: i == state.symbolList.length - 1 ? 0 : 20.h),
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
                                          decoration: BoxDecoration(
                                            color: state.symbolList[i].chg > 0 ? Color(0xff39D7A1) : Color(0xffef8995),
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
                                            state.symbolList[i].symbol,
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
                                              color: state.symbolList[i].chg > 0 ? Color(0xff39D7A1) : Colors.white,
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
                                          color: state.symbolList[i].chg > 0 ? Color(0xff39D7A1) : Color(0xffef8995),
                                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${(state.symbolList[i].chg.d() * 100.d()).toPrecisionString()}%",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Inter",
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
                  );
          },
        ),
      ],
    );
  }
}
