import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'member_cubit.dart';
import 'member_page.dart';

class MemberProvider extends StatelessWidget {
  const MemberProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MemberCubit(),
      child: Builder(
        builder: (context) {
          return const MemberPage();
        }
      ),
    );
  }
}
