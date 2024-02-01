part of 'otc_cubit.dart';

enum OtcAdvertiseType {
  buy(0, "買入"),
  sell(1, "賣出");

  const OtcAdvertiseType(this.value, this.text);

  final int value;
  final String text;
}

class OtcState extends Equatable {
  const OtcState({
    this.otcCoinResponse,
    this.advertiseUnitList = const [],
    this.total = 0,
    this.page = 1,
    this.status = OtcStatus.initial,
    this.advertiseType = 1,
  });

  final OtcCoinResponse? otcCoinResponse;
  final List<Context>? advertiseUnitList;
  final int page;
  final int total;
  final OtcStatus status;
  final int advertiseType;

  OtcState copyWith({
    OtcCoinResponse? otcCoinResponse,
    int? page,
    int? total,
    OtcStatus? status,
    List<Context>? advertiseUnitList,
    int? advertiseType,
  }) {
    return OtcState(
      otcCoinResponse: otcCoinResponse ?? this.otcCoinResponse,
      advertiseUnitList: advertiseUnitList ?? this.advertiseUnitList,
      page: page ?? this.page,
      total: total ?? this.total,
      status: status ?? this.status,
      advertiseType: advertiseType ?? this.advertiseType,
    );
  }

  @override
  List<Object> get props => [
        otcCoinResponse ?? OtcCoinResponse(),
        advertiseUnitList ?? [],
        page,
        total,
        status,
        advertiseType,
      ];
}

enum OtcStatus { initial, success, failure }
