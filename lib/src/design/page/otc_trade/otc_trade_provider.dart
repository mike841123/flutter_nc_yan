import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'otc_trade_cubit.dart';
import 'otc_trade_page.dart';

class OtcTradeProvider extends StatelessWidget {
  const OtcTradeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = (ModalRoute.of(context)?.settings.arguments as int);
    return BlocProvider(
      create: (_) => OtcTradeCubit()..init(id),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.pets,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    // BlocProvider.of<RoutesCubit>(context).changePage(Routes.moneyManagementRecord);
                  },
                )
              ],
              leading: IconButton(
                onPressed: () {
                  BlocProvider.of<RoutesCubit>(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
              title: Text("買入USDT",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontFamily: "HelveticaNeue",
                    fontStyle: FontStyle.normal,
                    fontSize: 17.sp,
                  ),
                  textAlign: TextAlign.center),
              backgroundColor: const Color(0xff2e2e2e),
            ),
            body: const OtcTradePage());
      }),
    );
  }
}
