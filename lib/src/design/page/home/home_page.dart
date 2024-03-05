import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/advertise_response.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';
import 'package:yan_demo_fcm/src/config/routes.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/home/home_cubit.dart';

import '../../../../domain/response/home_page_response/announcement_response.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_svg/svg.dart';
import '../../../config/app_color.dart';
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
    return SingleChildScrollView(
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
    );
  }
}

class Advisement extends StatelessWidget {
  const Advisement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.bgColor1,
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
                        height: 24.h,
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
                                  BlocProvider.of<RoutesCubit>(context).changePage(
                                    Routes.details,
                                    arguments: DetailsArguments(id: item.id, type: DetailsType.announcement),
                                  );
                                },
                                child: Text(
                                  item.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    height: 1.h,
                                    color: AppColor.textColor1,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: "Inter",
                                    fontSize: 14.sp,
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
              InkWell(
                onTap: (){
                  BlocProvider.of<RoutesCubit>(context).changePage(Routes.announcement);
                },
                child: Text(
                  "更多",
                  style: TextStyle(
                    color: AppColor.textColor2,
                    fontWeight: FontWeight.w400,
                    fontFamily: "Inter",
                    fontSize: 14.sp,
                  ),
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
      color: AppColor.bgColor1,
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
                    color: AppColor.textColor1,
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
                      "總資產",
                      style: TextStyle(
                        color: AppColor.textColor1,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 14.sp,
                      ),
                    );
                  },
                ),
                addVerticalSpace(6.h),
                BlocBuilder<UserCubit, UserState>(
                  buildWhen: (previous, current) => previous.balance != current.balance,
                  builder: (context, state) {
                    return Text(
                      state.balance.toPrecisionString(),
                      style: TextStyle(
                        color: AppColor.textColor1,
                        fontWeight: FontWeight.w400,
                        fontFamily: "Inter",
                        fontSize: 14.sp,
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
        InkWell(
          onTap: (){
            BlocProvider.of<RoutesCubit>(context).changePage(Routes.helpCenter);
          },
          child: Container(
            height: 100.h,
            width: (MediaQuery.of(context).size.width) / 2 - 1.w,
            color: AppColor.bgColor1,
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
                          color:  AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                        ),
                      ),
                      addVerticalSpace(10.h),
                      Text(
                        "問題/指南/資料",
                        style: TextStyle(
                          color:  AppColor.textColor1,
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
        ),
        addHorizontalSpace(1.w),
        InkWell(
          onTap: (){
            BlocProvider.of<RoutesCubit>(context).changePage(Routes.announcement);
          },
          child: Container(
            height: 100.h,
            width: (MediaQuery.of(context).size.width) / 2 - 1.w,
            color: AppColor.bgColor1,
            child: Padding(
              padding: EdgeInsets.only(top: 20.h, bottom: 10.h, left: 20.w, right: 30.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "公告",
                        style: TextStyle(
                          color:  AppColor.textColor1,
                          fontWeight: FontWeight.w400,
                          fontFamily: "Inter",
                          fontSize: 16.sp,
                        ),
                      ),
                      addVerticalSpace(10.h),
                      Text(
                        "新聞/活動/資訊",
                        style: TextStyle(
                          color:  AppColor.textColor1,
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
                    color: AppColor.bgColor1,
                    child: CarouselSlider.builder(
                      itemCount: state.symbolList.length,
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => SizedBox(
                        height: 130.h,
                        child: SizedBox(
                          width: (MediaQuery.of(context).size.width) / 3,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.symbolList[itemIndex].symbol,
                                style: TextStyle(
                                  color: AppColor.textColor1,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  fontSize: 16.sp,
                                ),
                              ),
                              addVerticalSpace(4.h),
                              Text(
                                state.symbolList[itemIndex].usdRate.toPrecisionString(),
                                style: TextStyle(
                                  color: AppColor.textColor5,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  fontSize: 16.sp,
                                ),
                              ),
                              addVerticalSpace(4.h),
                              Text(
                                "${(state.symbolList[itemIndex].chg.d() * 100.d()).toPrecisionString()}%",
                                style: TextStyle(
                                  color: state.symbolList[itemIndex].chg > 0 ? AppColor.textColor6 : AppColor.textColor7,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  fontSize: 14.sp,
                                ),
                              ),
                              addVerticalSpace(4.h),
                              Text(
                                "=267150.73.CNY",
                                style: TextStyle(
                                  color: AppColor.textColor5,
                                  fontWeight: FontWeight.w400,
                                  fontFamily: "Inter",
                                  fontSize: 14.sp,
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
                        height: 130.h,
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
          color: AppColor.bgColor1,
          padding: EdgeInsets.symmetric(vertical: 10.h),
          child: Text(
            "漲幅榜",
            style: TextStyle(
              color: AppColor.textColor1,
              fontWeight: FontWeight.w700,
              fontFamily: "Inter",
              fontSize: 16.sp,
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
                    color: AppColor.bgColor1,
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
                                          width: 18.r,
                                          height: 18.r,
                                          decoration: BoxDecoration(
                                            color: state.symbolList[i].chg > 0 ? AppColor.textColor6 : AppColor.textColor7,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            (i + 1).toString(),
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: AppColor.textColor8,
                                              fontSize: 14.sp,
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
                                              color: AppColor.textColor1,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Inter",
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                          addVerticalSpace(6.h),
                                          Text(
                                            "24H量2714.1719",
                                            style: TextStyle(
                                              color: AppColor.textColor5,
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
                                              color: state.symbolList[i].chg > 0 ? AppColor.textColor6 : AppColor.textColor7,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                          addVerticalSpace(6.h),
                                          Text(
                                            "=33.24CNY",
                                            style: TextStyle(
                                              color: AppColor.textColor5,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: "Inter",
                                              fontSize: 14.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(vertical: 2.h),
                                        width: 60.w,
                                        decoration: BoxDecoration(
                                          color: state.symbolList[i].chg > 0 ? AppColor.textColor6 : AppColor.textColor7,
                                          borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                                        ),
                                        alignment: Alignment.center,
                                        child: Text(
                                          "${(state.symbolList[i].chg.d() * 100.d()).toPrecisionString()}%",
                                          style: TextStyle(
                                            color: AppColor.textColor1,
                                            fontWeight: FontWeight.w400,
                                            fontFamily: "Inter",
                                            fontSize: 14.sp,
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
