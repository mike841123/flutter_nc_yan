part of 'money_management_record_cubit.dart';

class MoneyManagementRecordState extends Equatable {
  const MoneyManagementRecordState({
    this.investedRecordList = const [],
    this.page = 1,
    this.total = 0,
    this.status = MoneyManagementRecordStatus.initial,
  });

  final List<Content>? investedRecordList;
  final int page;
  final int total;
  final MoneyManagementRecordStatus status;

  MoneyManagementRecordState copyWith({
    List<Content>? investedRecordList,
    int? page,
    int? total,
    MoneyManagementRecordStatus? status,
  }) {
    return MoneyManagementRecordState(
      investedRecordList: investedRecordList ?? this.investedRecordList,
      page: page ?? this.page,
      total: total ?? this.total,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [investedRecordList ?? [], page, total, status];
}

enum MoneyManagementRecordStatus { initial, success, failure }

@immutable
class OrderTypeLabel {
  const OrderTypeLabel(this.label);

  final OrderType label;
}

enum OrderType {
  current("活期", 0),
  regular("定期", 1);

  const OrderType(this.value, this.type);

  final String value;
  final int type;
}

@immutable
class InvestedTypeLabel {
  const InvestedTypeLabel(this.label);

  final InvestedType label;
}

enum InvestedType {
  invalid("無效", 0),
  valid("有效", 1),
  auto("到期自動贖回", 2),
  hand("手動贖回贖回", 3),
  immediately("立即贖回", 4),
  autoBuy("自動申購並贖回", 5);

  const InvestedType(this.value, this.type);

  final String value;
  final int type;
}
