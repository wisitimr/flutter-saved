import 'package:equatable/equatable.dart';
import 'package:findigitalservice/report/ledger_account/models/models.dart';

class ReportLedgerAccountModel extends Equatable {
  const ReportLedgerAccountModel({
    required this.code,
    required this.name,
    required this.accountDetail,
  });

  final String code;
  final String name;
  final List<AccountDetail> accountDetail;

  factory ReportLedgerAccountModel.fromJson(Map<String, dynamic> json) {
    var accountDetail =
        json['accountDetail'] != null ? json['accountDetail'] as List : [];
    return ReportLedgerAccountModel(
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
