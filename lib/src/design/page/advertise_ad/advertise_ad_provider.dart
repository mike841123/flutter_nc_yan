import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'advertise_ad_cubit.dart';
import 'advertise_ad_page.dart';



class AdvertiseAdProvider extends StatelessWidget {
  const AdvertiseAdProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AdvertiseAdCubit()..init(),
      child: Builder(
        builder: (context) {
          return const AdvertiseAdPage();
        }
      ),
    );
  }
}
