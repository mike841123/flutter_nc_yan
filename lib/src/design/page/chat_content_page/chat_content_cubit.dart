import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:yan_demo_fcm/driven/util/extension.dart';

import '../../../../domain/response/chat_page_response/history_msg_response.dart';
import '../../../../driven/service/state_service.dart';
import '../../../../get_it_service_locator.dart';
import '../../../../service/api_service.dart';
import '../../model/user_cubit/user_cubit.dart';

part 'chat_content_state.dart';

class ChatContentCubit extends Cubit<ChatContentState> {
  ChatContentCubit() : super(const ChatContentState());

  void init() {
    getHistoryMsg("760911842095796224", 1);
  }

  void getHistoryMsg(String? orderId, int? Page) async {
    HistoryMsgResponse response = await getIt<ApiService>().getHistoryMessage(orderId, Page);
    emit(state.copyWith(historyMsgResponse: response.data));
  }

  void sendMsg(String msg) {
    emit(state.copyWith(msgStatus: MsgStatus.initial));
    emit(state.copyWith(
      historyMsgResponse: state.historyMsgResponse
        ..insert(
          0,
          HistoryMsgResult(
            sendTimeStr: DateTime.now().timeToString(),
            nameFrom: BlocProvider.of<UserCubit>(getIt<StateService>().scaffoldContext).getUser()?.username ?? "",
            content: msg,
          ),
        ),
      msgStatus: MsgStatus.success,
    ));
  }
}
