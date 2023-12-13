part of 'loading_cubit.dart';

enum LoadStatus { loading, done }

class LoadingState extends Equatable {
  const LoadingState({
    this.loadStatus = LoadStatus.done,
  });

  final LoadStatus loadStatus;

  LoadingState copyWith({
    LoadStatus? loadStatus,
  }) {
    return LoadingState(
      loadStatus: loadStatus ?? this.loadStatus,
    );
  }

  @override
  List<Object> get props => [loadStatus];
}
