import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/driven/util/widget_util.dart';

import '../../model/routes_cubit/routes_cubit.dart';
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
              title: Text("理財",
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
