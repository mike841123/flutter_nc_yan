import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';

import '../../config/app_color.dart';
import '../model/routes_cubit/routes_cubit.dart';

/// appbar
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.title = "",
    this.bgColor,
    this.actions,
    this.leading,
  }) : super(key: key);

  final String title;
  final Color? bgColor;
  final List<Widget>? actions;
  final Widget? leading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        AppBar(
          title: title.isEmpty || title == "首頁"
              ? empty()
              : Text(
                  title,
                  style: TextStyle(
                    color: AppColor.textColor1,
                    fontWeight: FontWeight.w500,
                    fontFamily: "HelveticaNeue",
                    fontStyle: FontStyle.normal,
                    fontSize: 18.sp,
                  ),
                ),
          elevation: 0,
          leadingWidth: 48.w,
          leading: Visibility(
            visible: BlocProvider.of<RoutesCubit>(context).canPop(),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_outlined,
                color: AppColor.textColor1,
              ),
              onPressed: () => BlocProvider.of<RoutesCubit>(context).pop(),
            ),
          ),
          actions: actions,
          backgroundColor: bgColor ?? AppColor.bgColor1,
        ),
        title == "首頁"
            ? Positioned(
                left: 14.w,
                child: SvgPicture.asset(
                  width: 90.w,
                  height: 24.h,
                  "assets/images/img_chat.svg",
                  fit: BoxFit.contain,
                ),
              )
            : empty(),
      ],
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size(double.infinity, 50.h);
}
