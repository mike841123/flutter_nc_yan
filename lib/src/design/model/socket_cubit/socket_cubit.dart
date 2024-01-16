import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';

import '../../../config/app_config.dart';

part 'socket_state.dart';

/// socket Cubit
class SocketCubit extends Cubit<SocketState> {
  SocketCubit() : super(const SocketState());

  void init() {
    // print("123");
  //   IO.Socket socket = IO.io("wss://java-front-qa.ncpro.io/market/market-ws/310/zwxkgkvi/websocket", <String, dynamic>{
  //     'transports': ['websocket'],
  //
  //     'forceNew': true
  //   });
  //   socket.onError((_) => print('error : ${_.toString()}'));
  //   socket.onConnect((_) {
  //     print('connect');
  //   });
  //   socket.on('event', (data) => print(data));
  //   socket.onDisconnect((_) => print('disconnect'));
  //   socket.on('fromServer', (_) => print(_));
  }

}
