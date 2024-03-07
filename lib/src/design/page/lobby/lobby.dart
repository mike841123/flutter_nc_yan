import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../config/app_color.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../model/socket_cubit/socket_cubit.dart';
import '../../model/user_cubit/user_cubit.dart';
import '../home/home_provider.dart';
import '../market/market_provider.dart';
import '../member/member_provider.dart';
import '../otc/otc_provider.dart';
import '../transaction/transaction_provider.dart';

class Lobby extends StatefulWidget {
  const Lobby({super.key});

  @override
  _LobbyPageState createState() => _LobbyPageState();
}

class _LobbyPageState extends State<Lobby> {
  List<(Widget, String, String)> lobbys = <(Widget, String, String)>[
    (const HomeProvider(), "首頁", "img_bottom_item1"),
    (const MarketProvider(), "行情", "img_bottom_item2"),
    (const TransactionProvider(), "交易", "img_bottom_item3"),
    (const OtcProvider(), "首頁", "img_bottom_item4"),
    (const MemberProvider(), "我的", "img_bottom_item5"),
  ];

  @override
  void initState() {
    BlocProvider.of<UserCubit>(context).init();
    BlocProvider.of<SocketCubit>(context).init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoutesCubit, RoutesState>(
      buildWhen: (previous, current) => previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        return GestureDetector(
          onTap: () {
            // 觸摸收起鍵盤
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SafeArea(
            child: Scaffold(
              body: lobbys[state.currentIndex].$1,
              backgroundColor: Colors.black,
              bottomNavigationBar: _bottomNavigationBar(lobbys),
            ),
          ),
        );
      },
    );
  }

  Widget _bottomNavigationBar(List<(Widget, String, String)> lobbys) {
    return BlocBuilder<RoutesCubit, RoutesState>(
      buildWhen: (previous, current) => previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        List<BottomNavigationBarItem> finalItems = [];
        for (int i = 0; i < lobbys.length; i++) {
          finalItems.add(BottomNavigationBarItem(
            icon: Image.asset(
              "assets/images/${lobbys[i].$3}.png",
              width: 25.r,
              height: 30.r,
              color: state.currentIndex == i ? AppColor.textColor2 : AppColor.textColor5,
              fit: BoxFit.fill,
            ),
            label: lobbys[i].$2,
          ));
        }
        return SizedBox(
          height: 70.h,
          child: BottomNavigationBar(
            backgroundColor: AppColor.bgColor4,
            items: finalItems,
            currentIndex: state.currentIndex,
            iconSize: 40.r,
            selectedFontSize: 14.sp,
            unselectedFontSize: 14.sp,
            selectedItemColor: AppColor.textColor2,
            unselectedItemColor: AppColor.textColor5,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              if (state.currentIndex != index) {
                BlocProvider.of<RoutesCubit>(context).changeLobbyPageWithInt(index);
              }
            },
          ),
        );
      },
    );
  }
}
