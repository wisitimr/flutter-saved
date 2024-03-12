import 'package:equatable/equatable.dart';
import 'package:findigitalservice/report/ledger_account/list/models/account_detail.dart';

class ReportLedgerAccountListModel extends Equatable {
  const ReportLedgerAccountListModel({
    required this.code,
    required this.name,
    required this.accountDetail,
  });

  final String code;
  final String name;
  final List<AccountDetail> accountDetail;

  factory ReportLedgerAccountListModel.fromJson(Map<String, dynamic> json) {
    var accountDetail =
        json['accountDetail'] != null ? json['accountDetail'] as List : [];
    return ReportLedgerAccountListModel(
      code: json['code'] ?? '',
      name: json['name'] ?? '',
      accountDetail: accountDetail.isNotEmpty
          ? accountDetail.map((data) => AccountDetail.fromJson(data)).toList()
          : <AccountDetail>[],
    );
  }

  @override
  List<Object> get props => [
        code,
        name,
        accountDetail,
      ];
}
