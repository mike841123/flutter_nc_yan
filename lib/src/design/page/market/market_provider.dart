import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'market_cubit.dart';
import 'market_page.dart';

class MarketProvider extends StatelessWidget {
  const MarketProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MarketCubit(),
      child: Builder(
        builder: (context) {
          return const MarketPage();
        }
      ),
    );
  }
}
