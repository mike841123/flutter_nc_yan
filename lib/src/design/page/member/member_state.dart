part of 'member_cubit.dart';

class MemberState extends Equatable {
  const MemberState({
    this.text,
  });

  final String? text;

  MemberState copyWith({
    String? text,
  }) {
    return MemberState(text: text ?? this.text);
  }

  @override
  List<Object> get props => [text ?? ""];
}
