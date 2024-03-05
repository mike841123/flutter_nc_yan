import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/src/design/page/help_center/help_center_cubit.dart';

import 'help_center_page.dart';



class HelpCenterProvider extends StatelessWidget {
  const HelpCenterProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HelpCenterCubit()..init(),
      child: Builder(
        builder: (context) {
          return const HelpCenterPage();
        }
      ),
    );
  }
}
