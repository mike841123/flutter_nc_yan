import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/config/app_color.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import 'otc_list_cubit.dart';
import 'otc_list_page.dart';

class OtcListProvider extends StatelessWidget {
  const OtcListProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtcListCubit()..init(),
      child: Builder(builder: (context) {
        return Scaffold(
            backgroundColor: AppColor.bgColor1,
            appBar: const CustomAppBar(
              title: "我的訂單",
            ),
            body: const OtcListPage());
      }),
    );
  }
}
