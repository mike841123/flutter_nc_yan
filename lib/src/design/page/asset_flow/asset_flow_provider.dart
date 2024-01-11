import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'asset_flow_cubit.dart';
import 'asset_flow_page.dart';


class AssetFlowProvider extends StatelessWidget {
  const AssetFlowProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AssetFlowCubit()..init(),
      child: Builder(
        builder: (context) {
          return const AssetFlowPage();
        }
      ),
    );
  }
}
