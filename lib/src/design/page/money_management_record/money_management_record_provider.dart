import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'money_management_record_cubit.dart';
import 'money_management_record_page.dart';



class MoneyManagementRecordProvider extends StatelessWidget {
  const MoneyManagementRecordProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MoneyManagementRecordCubit()..init(),
      child: Builder(
        builder: (context) {
          return const MoneyManagementRecordPage();
        }
      ),
    );
  }
}
