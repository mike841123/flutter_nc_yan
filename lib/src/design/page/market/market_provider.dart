import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';

import '../../../config/app_color.dart';
import 'market_cubit.dart';
import 'market_page.dart';

class MarketProvider extends StatelessWidget {
  const MarketProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketCubit()..init(),
      child: Builder(
        builder: (context) {
          return Scaffold(
              backgroundColor: AppColor.bgColor4,
              appBar: CustomAppBar(
                bgColor: AppColor.bgColor4,
                title: "行情",
              ),
              body: const MarketPage());
        }
      ),
    );
  }
}
