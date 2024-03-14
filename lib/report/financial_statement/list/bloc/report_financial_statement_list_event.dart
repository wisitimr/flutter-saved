part of 'report_financial_statement_list_bloc.dart';

@immutable
sealed class ReportFinancialStatementListEvent extends Equatable {
  const ReportFinancialStatementListEvent();
}

final class ReportFinancialStatementListStarted
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListStarted(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportFinancialStatementListSearchChanged
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class ReportFinancialStatementListYearSelected
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListYearSelected(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportFinancialStatementListDownload
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListDownload(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportFinancialStatementListPreviewLedgerAccount
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListPreviewLedgerAccount(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

final class ReportFinancialStatementListPreviewAccountBalance
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListPreviewAccountBalance(this.accountGroup);

  final String accountGroup;

  @override
  List<Object> get props => [accountGroup];
}

final class ReportFinancialStatementListAccountBalanceColumnSelected
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListAccountBalanceColumnSelected(this.columns);

  final List columns;

  @override
  List<Object> get props => [columns];
}

final class ReportFinancialStatementListAccountBalanceColumnSelectedAll
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListAccountBalanceColumnSelectedAll(
      this.isSelectAll);

  final bool isSelectAll;

  @override
  List<Object> get props => [isSelectAll];
}

final class ReportFinancialStatementListAccountBalanceColumnSelectedDefault
    extends ReportFinancialStatementListEvent {
  const ReportFinancialStatementListAccountBalanceColumnSelectedDefault();

  @override
  List<Object> get props => [];
}
