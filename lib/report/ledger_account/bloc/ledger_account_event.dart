part of 'ledger_account_bloc.dart';

@immutable
sealed class ReportLedgerAccountEvent extends Equatable {
  const ReportLedgerAccountEvent();
}

final class ReportLedgerAccountStarted extends ReportLedgerAccountEvent {
  const ReportLedgerAccountStarted(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportLedgerAccountSearchChanged extends ReportLedgerAccountEvent {
  const ReportLedgerAccountSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class ReportLedgerAccountYearSelected extends ReportLedgerAccountEvent {
  const ReportLedgerAccountYearSelected(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportLedgerAccountDownload extends ReportLedgerAccountEvent {
  const ReportLedgerAccountDownload(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportLedgerAccountPreviewLedgerAccount
    extends ReportLedgerAccountEvent {
  const ReportLedgerAccountPreviewLedgerAccount(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}
