part of 'market_cubit.dart';

class MarketState extends Equatable {
  const MarketState({
    this.text,
  });

  final String? text;

  MarketState copyWith({
    String? text,
  }) {
    return MarketState(text: text ?? this.text);
  }

  @override
  List<Object> get props => [text ?? ""];
}
