import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import '../../../../driven/abstract/current_page_state.dart';
import '../../../config/app_color.dart';
import '../../component/custom_appbar.dart';

class RechargePage extends StatefulWidget {
  const RechargePage({super.key});

  @override
  CurrentPageState<RechargePage> createState() => _RechargePageState();
}

class _RechargePageState extends CurrentPageState<RechargePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bgColor4,
      appBar: const CustomAppBar(
        title: "充幣",
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 14.w),
          child: Column(
            children: [
              Text(
                "BTC充幣",
                style: TextStyle(
                  color: AppColor.textColor1,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              addVerticalSpace(10.h),

            ],
          ),
        ),
      ),
    );
  }
}
