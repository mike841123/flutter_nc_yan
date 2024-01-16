part of 'socket_cubit.dart';

class SocketState extends Equatable {
  const SocketState({
    this.currentPage = "/login",

  });

  final String currentPage;

  SocketState copyWith({
    String? currentPage,

  }) {
    return SocketState(
      currentPage: currentPage ?? this.currentPage,
    );
  }

  @override
  List<Object> get props => [
        currentPage,
      ];
}
