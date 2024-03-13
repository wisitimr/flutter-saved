import 'package:equatable/equatable.dart';
import 'package:findigitalservice/report/financial_statement/list/models/account_detail.dart';

class ReportFinancialStatementListModel extends Equatable {
  const ReportFinancialStatementListModel({
    required this.code,
    required this.name,
    required this.accountDetail,
  });

  final String code;
  final String name;
  final List<AccountDetail> accountDetail;

  factory ReportFinancialStatementListModel.fromJson(
      Map<String, dynamic> json) {
    var accountDetail =
        json['accountDetail'] != null ? json['accountDetail'] as List : [];
    return ReportFinancialStatementListModel(
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
