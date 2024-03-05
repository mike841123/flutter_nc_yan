import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/help_response.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import 'package:yan_demo_fcm/src/design/component/message_item.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/help_center/help_center_cubit.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/custom_class.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import '../../../config/routes.dart';

class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  CurrentPageState<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends CurrentPageState<HelpCenterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor4,
      appBar: const CustomAppBar(
        title: "幫助",
      ),
      body: SafeArea(
        child: BlocBuilder<HelpCenterCubit, HelpCenterState>(
          buildWhen: (previous, current) => previous.status != current.status || previous.helpResponse != previous.helpResponse,
          builder: (context, state) {
            List<HelpItem> helpList = state.helpResponse?.data?.where((item) => item.content.isNotEmpty).toList() ?? [];
            switch (state.status) {
              // api未回傳前顯示loading
              case HelpCenterStatus.initial:
                return const Center(child: CircularProgressIndicator());
              // api回傳成功
              case HelpCenterStatus.success:
                return helpList.isEmpty
                    ? Center(
                        child: Text(
                          "暫無資料",
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
                        itemCount: helpList.length,
                        itemBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      helpList[index].titleCN,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        color: AppColor.textColor1,
                                      ),
                                    ),
                                    Text(
                                      "更多",
                                      style: TextStyle(
                                        fontSize: 13.sp,
                                        color: AppColor.textColor2,
                                      ),
                                    ),
                                  ],
                                ),
                                addVerticalSpace(14.h),
                                for (int i = 0; i < helpList[index].content.length; i++)
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 14.h),
                                    child: MessageItem(
                                      title: helpList[index].content[i].title,
                                      time: helpList[index].content[i].createTime,
                                      onTap: () {
                                        BlocProvider.of<RoutesCubit>(context).changePage(Routes.details,
                                            arguments: DetailsArguments(type: DetailsType.help, id: helpList[index].content[i].id));
                                      },
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 14.h,
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
}
