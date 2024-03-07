import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/design/page/trade/trade_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/trade/trade_page.dart';

import '../../../config/app_color.dart';
import '../../component/custom_appbar.dart';



class TradeProvider extends StatelessWidget {
  const TradeProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TradeCubit()..init(),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColor.bgColor4,
            appBar: const CustomAppBar(
              title: "K線",
            ),
            body: const TradePage(),
          );
        }
      ),
    );
  }
}
