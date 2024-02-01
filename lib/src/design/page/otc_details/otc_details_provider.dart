import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yan_demo_fcm/src/design/page/otc_details/otc_details_page.dart';
import '../../model/routes_cubit/routes_cubit.dart';
import 'otc_details_cubit.dart';

class OtcDetailsProvider extends StatelessWidget {
  const OtcDetailsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final int id = (ModalRoute.of(context)?.settings.arguments as int);
    return BlocProvider(
      create: (_) => OtcDetailsCubit()..init(id),
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
              title: Text("訂單",
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
            body: const OtcDetailsPage());
      }),
    );
  }
}
