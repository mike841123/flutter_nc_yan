import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/design/page/my_assets/my_assets_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/my_assets/my_assets_page.dart';

import '../../../config/app_color.dart';
import '../../component/custom_appbar.dart';



class MyAssetProvider extends StatelessWidget {
  const MyAssetProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyAssetsCubit()..init(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColor.bgColor4,
            appBar: const CustomAppBar(
              title: "幣幣帳戶",
            ),
            body: const MyAssetsPage(),
          );
        }
      ),
    );
  }
}
