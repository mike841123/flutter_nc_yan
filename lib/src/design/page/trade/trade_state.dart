part of 'trade_cubit.dart';

class TradeState extends Equatable {
  const TradeState({
    this.searchText = "",
  });

  final String searchText;

  TradeState copyWith({
    String? searchText,
  }) {
    return TradeState(
      searchText: searchText ?? this.searchText,
    );
  }

  @override
  List<Object> get props => [searchText];
}
