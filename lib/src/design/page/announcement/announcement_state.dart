part of 'announcement_cubit.dart';

enum AnnouncementStatus { initial, success, failure }

class AnnouncementState extends Equatable {
  const AnnouncementState({
    this.contentList,
    this.status = AnnouncementStatus.initial,
  });

  final AnnouncementStatus status;
  final List<Content>? contentList;

  AnnouncementState copyWith({
    AnnouncementStatus? status,
    List<Content>? contentList,
  }) {
    return AnnouncementState(
      contentList: contentList ?? this.contentList,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        contentList ?? [],
        status,
      ];
}
