part of 'details_cubit.dart';

enum DetailsStatus { initial, success, failure }

class DetailsState extends Equatable {
  const DetailsState({
    this.detailsResponse,
    this.status = DetailsStatus.initial,
    this.announcementDetailsResponse,
  });

  final DetailsStatus status;
  final DetailsResponse? detailsResponse;
  final AnnouncementDetailsResponse? announcementDetailsResponse;

  DetailsState copyWith({
    DetailsStatus? status,
    DetailsResponse? detailsResponse,
    AnnouncementDetailsResponse? announcementDetailsResponse,
  }) {
    return DetailsState(
      detailsResponse: detailsResponse ?? this.detailsResponse,
      announcementDetailsResponse: announcementDetailsResponse ?? this.announcementDetailsResponse,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        detailsResponse ?? DetailsResponse(),
        status,
        announcementDetailsResponse ?? AnnouncementDetailsResponse(),
      ];
}
