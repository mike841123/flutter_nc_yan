import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'my_advertisement_cubit.dart';
import 'my_advertisement_page.dart';


class MyAdvertisementProvider extends StatelessWidget {
  const MyAdvertisementProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MyAdvertisementCubit()..init(),
      child: Builder(
        builder: (context) {
          return const MyAdvertisementPage();
        }
      ),
    );
  }
}
