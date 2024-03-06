import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/design/page/safe_setting/safe_setting_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/safe_setting/safe_setting_page.dart';

import '../../../config/app_color.dart';
import '../../component/custom_appbar.dart';



class SafeSettingProvider extends StatelessWidget {
  const SafeSettingProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SafeSettingCubit()..init(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColor.bgColor4,
            appBar: const CustomAppBar(
              title: "安全設置",
            ),
            body: const SafeSettingPage(),
          );
        }
      ),
    );
  }
}
