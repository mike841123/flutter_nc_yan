import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'announcement_cubit.dart';
import 'announcement_page.dart';



class AnnouncementProvider extends StatelessWidget {
  const AnnouncementProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AnnouncementCubit()..init(),
      child: Builder(
        builder: (context) {
          return const AnnouncementPage();
        }
      ),
    );
  }
}
