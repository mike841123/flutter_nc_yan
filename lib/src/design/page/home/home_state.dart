part of 'home_cubit.dart';

class HomeState extends Equatable {
  const HomeState({
    this.text,
  });

  final String? text;

  HomeState copyWith({
    String? text,
  }) {
    return HomeState(text: text ?? this.text);
  }

  @override
  List<Object> get props => [text ?? ""];
}
