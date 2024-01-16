part of 'chat_content_cubit.dart';

enum MsgStatus { initial, success, failure }

class ChatContentState extends Equatable {
  const ChatContentState({
    this.historyMsgResponse = const [],
    this.msgStatus = MsgStatus.initial,
  });

  final List<HistoryMsgResult> historyMsgResponse;
  final MsgStatus msgStatus;

  ChatContentState copyWith({
    List<HistoryMsgResult>? historyMsgResponse,
    MsgStatus? msgStatus,
  }) {
    return ChatContentState(
      historyMsgResponse: historyMsgResponse ?? this.historyMsgResponse,
      msgStatus: msgStatus ?? this.msgStatus,
    );
  }

  @override
  List<Object> get props => [
        historyMsgResponse,
        msgStatus,
      ];
}
