import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/design/page/money_management/money_management_cubit.dart';
import 'package:yan_demo_fcm/src/design/page/money_management/money_management_page.dart';



class MoneyManagementProvider extends StatelessWidget {
  const MoneyManagementProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoneyManagementCubit()..init(),
      child: Builder(
        builder: (context) {
          return const MoneyManagementPage();
        }
      ),
    );
  }
}
