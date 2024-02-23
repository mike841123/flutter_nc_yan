import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';
import 'package:yan_demo_fcm/src/design/component/custom_appbar.dart';
import '../../../config/app_color.dart';
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
            backgroundColor: AppColor.bgColor1,
            appBar: CustomAppBar(
              title: "${BlocProvider.of<OtcTradeCubit>(context).getOtcAdvertiseTypeText(arguments.type)}${arguments.unit}",
            ),
            body: OtcTradePage(
              arguments: arguments,
            ));
      }),
    );
  }
}
