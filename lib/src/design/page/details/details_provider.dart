import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yan_demo_fcm/driven/util/custom_class.dart';

import 'details_cubit.dart';
import 'details_page.dart';

class DetailsProvider extends StatelessWidget {
  const DetailsProvider({super.key});

  @override
  Widget build(BuildContext context) {
    final DetailsArguments arguments = (ModalRoute.of(context)?.settings.arguments as DetailsArguments);
    return BlocProvider(
      create: (_) => DetailsCubit()..init(arguments),
      child: Builder(builder: (context) {
        return DetailsPage(
          detailsType: arguments.type,
        );
      }),
    );
  }
}
