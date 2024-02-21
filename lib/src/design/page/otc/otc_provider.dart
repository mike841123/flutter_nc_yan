import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';

import '../../../config/app_color.dart';
import 'otc_cubit.dart';
import 'otc_page.dart';

class OtcProvider extends StatelessWidget {
  const OtcProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtcCubit()..init(),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: AppColor.bgColor4,
            appBar: CustomAppBar(
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 14.w),
                  child: Text(
                    "發佈廣告",
                    style: TextStyle(
                      color: AppColor.textColor1,
                      fontWeight: FontWeight.w500,
                      fontFamily: "HelveticaNeue",
                      fontStyle: FontStyle.normal,
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
              title: "法幣交易",
            ),
            body: BlocBuilder<OtcCubit, OtcState>(
              buildWhen: (previous, current) => previous.otcCoinResponse != current.otcCoinResponse,
              builder: (context, state) {
                return state.otcCoinResponse == null ? const Center(child: CircularProgressIndicator()) : const OtcPage();
              },
            ));
      }),
    );
  }
}
