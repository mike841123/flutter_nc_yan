import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';
import 'package:yan_demo_fcm/src/design/page/transaction/component/drawer.dart';
import '../../../config/app_color.dart';
import '../../model/market_cubit/market_cubit.dart';
import 'transaction_cubit.dart';
import 'transaction_page.dart';

class TransactionProvider extends StatefulWidget {
  const TransactionProvider({Key? key}) : super(key: key);

  @override
  State<TransactionProvider> createState() => _TransactionProviderState();
}

class _TransactionProviderState extends State<TransactionProvider> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<String> tabs = ["自選", "USDT"];

  @override
  void initState() {
    BlocProvider.of<MarketCubit>(context).getUsdtCnyRate();
    BlocProvider.of<MarketCubit>(context).getMarketSymbolList();
    _tabController = TabController(
      length: tabs.length,
      vsync: this,
      initialIndex: 1,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> key = GlobalKey(); // drawer的key
    return BlocProvider(
      create: (_) => TransactionCubit(),
      child: Builder(builder: (context) {
        return Scaffold(
          key: key,
          backgroundColor: AppColor.bgColor4,
          appBar: AppBar(
            backgroundColor: AppColor.bgColor1,
            leadingWidth: 160.w,
            leading: Padding(
              padding: EdgeInsets.only(left: 8.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      key.currentState!.openDrawer(); // 這樣才能打開這頁的drawer
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
          drawer: CustomDrawer(tabs: tabs,tabController: _tabController,),
          body: TransactionPage(),
        );
      }),
    );
  }
}
