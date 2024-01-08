import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'otc_cubit.dart';
import 'otc_page.dart';

class OtcProvider extends StatelessWidget {
  const OtcProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => OtcCubit()..init(),
      child: Builder(
        builder: (context) {
          return const OtcPage();
        }
      ),
    );
  }
}
