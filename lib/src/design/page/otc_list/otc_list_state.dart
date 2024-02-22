part of 'otc_list_cubit.dart';

enum OrderStatus {
  unpaid(1),
  paid(2),
  finish(3),
  cancel(0),
  appeal(4);

  const OrderStatus(this.value);

  final int value;
}

enum OtcListStatus { initial, success, failure }

class OtcListState extends Equatable {
  const OtcListState({
    this.otcOrderPreResponse,
    this.otcOrderList = const [],
    this.page = 0,
    this.total = 0,
    this.status = OtcListStatus.initial,
  });

  final OtcOrderPreResponse? otcOrderPreResponse;
  final List<Content>? otcOrderList;
  final int page;
  final int total;
  final OtcListStatus status;

  OtcListState copyWith({
    OtcOrderPreResponse? otcOrderPreResponse,
    List<Content>? otcOrderList,
    int? page,
    int? total,
    OtcListStatus? status,
  }) {
    return OtcListState(
      otcOrderPreResponse: otcOrderPreResponse ?? this.otcOrderPreResponse,
      otcOrderList: otcOrderList ?? this.otcOrderList,
      page: page ?? this.page,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [
        otcOrderPreResponse ?? OtcOrderPreResponse(),
        otcOrderList ?? [],
        page,
        total,
        status,
      ];
}
