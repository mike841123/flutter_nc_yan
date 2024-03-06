import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';

import '../../../../driven/service/state_service.dart';
import '../../../../get_it_service_locator.dart';
import '../../../config/app_color.dart';
import 'transaction_cubit.dart';
import 'transaction_page.dart';

class TransactionProvider extends StatelessWidget {
  const TransactionProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          backgroundColor: AppColor.bgColor4,
          appBar: AppBar(
            backgroundColor: AppColor.bgColor1,
            leadingWidth: 160.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      getIt<StateService>().scaffoldState.openDrawer();
                    },
                    child: SvgPicture.asset(
                      "assets/images/img_drawer.svg",
                      width: 20.r,
                      height: 20.r,
                      fit: BoxFit.fill,
                    ),
                  ),
                  addHorizontalSpace(10.w),
                  Text(
                    "BTC/USDT",
                    style: TextStyle(color: AppColor.textColor1, fontSize: 16.sp),
                  )
                ],
              ),
            ),
          ),
          drawer: Drawer(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                  child: Text('抽屉菜单'),
                ),
                ListTile(
                  title: Text('菜单项1'),
                  onTap: () {
                    // 处理菜单项1点击事件
                  },
                ),
                ListTile(
                  title: Text('菜单项2'),
                  onTap: () {
                    // 处理菜单项2点击事件
                  },
                ),
              ],
            ),
          ),
          body: TransactionPage(),
        );
      }),
    );
  }
}
