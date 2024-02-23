part of 'my_advertisement_cubit.dart';

enum MyAdvertisementStatus { initial, success, failure }

class MyAdvertisementState extends Equatable {
  const MyAdvertisementState({
    this.otcAdvertiseList = const [],
    this.page = 1,
    this.total = 1,
    this.status = MyAdvertisementStatus.initial,
  });

  final List<Content>? otcAdvertiseList;
  final int page;
  final int total;
  final MyAdvertisementStatus status;

  MyAdvertisementState copyWith({
    List<Content>? otcAdvertiseList,
    int? page,
    int? total,
    MyAdvertisementStatus? status,
  }) {
    return MyAdvertisementState(
      otcAdvertiseList: otcAdvertiseList ?? this.otcAdvertiseList,
      page: page ?? this.page,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [otcAdvertiseList ?? [], page, total, status];
}
