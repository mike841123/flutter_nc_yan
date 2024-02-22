import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/config/app_color.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import 'package:yan_demo_fcm/src/design/page/otc_details/otc_details_page.dart';
import 'otc_details_cubit.dart';

class OtcDetailsProvider extends StatelessWidget {
  const OtcDetailsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final String id = (ModalRoute.of(context)?.settings.arguments as String);
    return BlocProvider(
      create: (_) => OtcDetailsCubit()..init(id),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: AppColor.bgColor1,
            appBar: const CustomAppBar(
              title: "訂單詳情",
            ),
            body: const SafeArea(child: OtcDetailsPage()));
      }),
    );
  }
}
