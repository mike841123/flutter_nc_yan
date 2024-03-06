import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../driven/util/custom_class.dart';
import '../../../config/app_color.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'package:flutter_svg/svg.dart';
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
  List<LobbyItem> listBody = [
    LobbyItem(title: "首頁", widget: const HomeProvider()),
    LobbyItem(title: "行情", widget: const MarketProvider()),
    LobbyItem(title: "交易", widget: const TransactionProvider()),
    LobbyItem(title: "法幣", widget: const OtcProvider()),
    LobbyItem(title: "我的", widget: const MemberProvider()),
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
              // appBar: CustomAppBar(
              //   title: listBody[state.currentIndex].title,
              // ),
              body: listBody[state.currentIndex].widget,
              backgroundColor: Colors.black,
              bottomNavigationBar: _bottomNavigationBar(),
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
            ),
          ),
        );
      },
    );
  }

  Widget _bottomNavigationBar() {
    List<BarItem> items = [
      BarItem(assetName: "assets/images/img_home.svg", label: "首頁"),
      BarItem(assetName: "assets/images/img_home.svg", label: "行情"),
      BarItem(assetName: "assets/images/img_home.svg", label: "交易"),
      BarItem(assetName: "assets/images/img_home.svg", label: "法幣"),
      BarItem(assetName: "assets/images/img_home.svg", label: "我的"),
    ];
    return BlocBuilder<RoutesCubit, RoutesState>(
      buildWhen: (previous, current) => previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        List<BottomNavigationBarItem> finalItems = [];
        for (int i = 0; i < items.length; i++) {
          finalItems.add(BottomNavigationBarItem(
            icon: SvgPicture.asset(
              items[i].assetName,
              color: state.currentIndex == i ?  AppColor.textColor2 : AppColor.textColor5,
              fit: BoxFit.fill,
            ),
            label: items[i].label,
          ));
        }
        return BottomNavigationBar(
          items: finalItems,
          currentIndex: state.currentIndex,
          iconSize: 30.r,
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
        );
      },
    );
  }
}

class LobbyItem {
  final String title;
  final Widget widget;

  LobbyItem({
    required this.title,
    required this.widget,
  });
}
