import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/announcement_details_response.dart';
import 'package:yan_demo_fcm/domain/response/home_page_response/details_response.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../config/app_color.dart';
import 'details_cubit.dart';

class DetailsPage extends StatefulWidget {
  const DetailsPage({super.key, required this.detailsType});

  final DetailsType detailsType;

  @override
  CurrentPageState<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends CurrentPageState<DetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor4,
      appBar: const CustomAppBar(
        title: "詳情",
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: BlocBuilder<DetailsCubit, DetailsState>(
              buildWhen: (previous, current) => previous.status != current.status,
              builder: (context, state) {
                switch (state.status) {
                  // api未回傳前顯示loading
                  case DetailsStatus.initial:
                    return const Center(child: CircularProgressIndicator());
                  // api回傳成功
                  case DetailsStatus.success:
                    switch (widget.detailsType) {
                      case DetailsType.help:
                        DetailsResult result = state.detailsResponse?.data ?? DetailsResult();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.title,
                              style: TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            addVerticalSpace(10.h),
                            Text(
                              result.createTime,
                              style: TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            addVerticalSpace(10.h),
                            Container(height: 1, color: AppColor.bgColor5),
                            addVerticalSpace(16.h),
                            HtmlWidget(
                              HtmlUnescape().convert(result.content),
                              textStyle: TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        );
                      case DetailsType.announcement:
                        AnnouncementDetailsResult result = state.announcementDetailsResponse?.data ?? AnnouncementDetailsResult();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              result.info?.title ?? "",
                              style: TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 24.sp,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            addVerticalSpace(10.h),
                            Text(
                              result.info?.createTime ?? "",
                              style: TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            addVerticalSpace(10.h),
                            Container(height: 1, color: AppColor.bgColor5),
                            addVerticalSpace(16.h),
                            HtmlWidget(
                              HtmlUnescape().convert(
                                result.info?.content ?? "",
                              ),
                              textStyle: TextStyle(
                                color: AppColor.textColor1,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ],
                        );
                    }

                  default:
                    return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
