import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import 'package:yan_demo_fcm/src/design/component/message_item.dart';
import 'package:yan_demo_fcm/src/design/model/routes_cubit/routes_cubit.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../../driven/util/widget_util.dart';
import '../../../config/app_color.dart';
import '../../../config/routes.dart';
import 'announcement_cubit.dart';

class AnnouncementPage extends StatefulWidget {
  const AnnouncementPage({super.key});

  @override
  CurrentPageState<AnnouncementPage> createState() => _AnnouncementPageState();
}

class _AnnouncementPageState extends CurrentPageState<AnnouncementPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor4,
      appBar: const CustomAppBar(
        title: "公告",
      ),
      body: SafeArea(
        child: BlocBuilder<AnnouncementCubit, AnnouncementState>(
          buildWhen: (previous, current) => previous.status != current.status || previous.contentList != previous.contentList,
          builder: (context, state) {
            switch (state.status) {
              // api未回傳前顯示loading
              case AnnouncementStatus.initial:
                return const Center(child: CircularProgressIndicator());
              // api回傳成功
              case AnnouncementStatus.success:
                return state.contentList == null
                    ? empty()
                    : state.contentList!.isEmpty
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
                        : Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                            child: ListView.separated(
                              itemCount: state.contentList!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return MessageItem(
                                  title: state.contentList![index].title,
                                  time: state.contentList![index].createTime,
                                  onTap: () {
                                    BlocProvider.of<RoutesCubit>(context).changePage(Routes.details, arguments: DetailsArguments(type: DetailsType.announcement, id: state.contentList![index].id));
                                  },
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return SizedBox(
                                  height: 14.h,
                                );
                              },
                            ),
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
