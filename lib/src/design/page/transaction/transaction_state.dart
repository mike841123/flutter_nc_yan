part of 'transaction_cubit.dart';

class TransactionState extends Equatable {
  const TransactionState({
    this.text,
  });

  final String? text;

  TransactionState copyWith({
    String? text,
  }) {
    return TransactionState(text: text ?? this.text);
  }

  @override
  List<Object> get props => [text ?? ""];
}
