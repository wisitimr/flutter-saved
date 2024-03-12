import 'package:equatable/equatable.dart';
import 'package:findigitalservice/report/ledger_account/list/models/account_detail.dart';

class MonthDetail extends Equatable {
  const MonthDetail({
    required this.month,
    required this.accountDetail,
  });

  final String month;
  final List<AccountDetail> accountDetail;

  factory MonthDetail.fromJson(Map<String, dynamic> json) {
    var accountDetail = json['accountDetail'] as List;
    return MonthDetail(
      month: json['month'] ?? '',
      accountDetail: accountDetail.isNotEmpty
          ? accountDetail.map((data) => AccountDetail.fromJson(data)).toList()
          : <AccountDetail>[],
    );
  }

  @override
  List<Object> get props => [
        month,
        accountDetail,
      ];
}
