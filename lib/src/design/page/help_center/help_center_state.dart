part of 'help_center_cubit.dart';

enum HelpCenterStatus { initial, success, failure }

class HelpCenterState extends Equatable {
  const HelpCenterState({
    this.helpResponse,
    this.status = HelpCenterStatus.initial,
  });

  final HelpCenterStatus status;
  final HelpResponse? helpResponse;

  HelpCenterState copyWith({
    HelpCenterStatus? status,
    HelpResponse? helpResponse,
  }) {
    return HelpCenterState(
      helpResponse: helpResponse ?? this.helpResponse,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [helpResponse ?? HelpResponse(), status];
}
