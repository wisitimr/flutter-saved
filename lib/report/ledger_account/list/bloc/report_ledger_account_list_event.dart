part of 'report_ledger_account_list_bloc.dart';

@immutable
sealed class ReportLedgerAccountListEvent extends Equatable {
  const ReportLedgerAccountListEvent();
}

final class ReportLedgerAccountListStarted
    extends ReportLedgerAccountListEvent {
  const ReportLedgerAccountListStarted(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportLedgerAccountListSearchChanged
    extends ReportLedgerAccountListEvent {
  const ReportLedgerAccountListSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class ReportLedgerAccountListYearSelected
    extends ReportLedgerAccountListEvent {
  const ReportLedgerAccountListYearSelected(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportLedgerAccountListDownload
    extends ReportLedgerAccountListEvent {
  const ReportLedgerAccountListDownload(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportLedgerAccountListPreviewLedgerAccount
    extends ReportLedgerAccountListEvent {
  const ReportLedgerAccountListPreviewLedgerAccount(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}
