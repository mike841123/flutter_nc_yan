part of 'otc_cubit.dart';

class OtcState extends Equatable {
  const OtcState({
    this.text,
  });

  final String? text;

  OtcState copyWith({
    String? text,
  }) {
    return OtcState(text: text ?? this.text);
  }

  @override
  List<Object> get props => [text ?? ""];
}
