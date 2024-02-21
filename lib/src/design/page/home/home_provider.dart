import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yan_demo_fcm/src/config/app_color.dart';

import '../../../config/routes.dart';
import '../../component/custom_appbar.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'home_cubit.dart';
import 'home_page.dart';

class HomeProvider extends StatelessWidget {
  const HomeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColor.bgColor4,
          appBar: CustomAppBar(
            title: "首頁",
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 14.w),
                child: InkWell(
                  onTap: () {
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
          ),
          body: const HomePage(),
        );
      }),
    );
  }
}
