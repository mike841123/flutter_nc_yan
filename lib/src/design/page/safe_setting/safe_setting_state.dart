part of 'safe_setting_cubit.dart';

enum SafeSettingStatus { initial, success, failure }

class SafeSettingState extends Equatable {
  const SafeSettingState({
    this.status = SafeSettingStatus.initial,
  });

  final SafeSettingStatus status;

  SafeSettingState copyWith({
    SafeSettingStatus? status,
  }) {
    return SafeSettingState(
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [status];
}
