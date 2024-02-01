import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'otc_trade_cubit.dart';
import 'otc_trade_page.dart';

class OtcTradeProvider extends StatelessWidget {
  const OtcTradeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final OtcTradeArguments arguments = (ModalRoute.of(context)?.settings.arguments as OtcTradeArguments);
    return BlocProvider(
      create: (_) => OtcTradeCubit()..init(arguments.id),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              leading: IconButton(
                onPressed: () {
                  BlocProvider.of<RoutesCubit>(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_ios_outlined,
                  color: Colors.white,
                ),
              ),
              title: Text("${arguments.type.text}${arguments.unit}",
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
            body: OtcTradePage(
              arguments: arguments,
            ));
      }),
    );
  }
}
