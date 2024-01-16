import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chat_content_cubit.dart';
import 'chat_content_page.dart';

class ChatContentProvider extends StatelessWidget {
  const ChatContentProvider({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChatContentCubit()..init(),
      child: Builder(
        builder: (context) {
          return const ChatContentPage();
        }
      ),
    );
  }
}
