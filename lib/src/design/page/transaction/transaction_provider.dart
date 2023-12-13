import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'transaction_cubit.dart';
import 'transaction_page.dart';

class TransactionProvider extends StatelessWidget {
  const TransactionProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TransactionCubit(),
      child: Builder(
        builder: (context) {
          return const TransactionPage();
        }
      ),
    );
  }
}
