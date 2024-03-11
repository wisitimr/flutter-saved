part of 'report_financial_statement_list_bloc.dart';

@immutable
sealed class FinancialStatementListEvent extends Equatable {
  const FinancialStatementListEvent();
}

final class FinancialStatementListStarted extends FinancialStatementListEvent {
  const FinancialStatementListStarted(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class FinancialStatementListSearchChanged
    extends FinancialStatementListEvent {
  const FinancialStatementListSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class FinancialStatementListYearSelected
    extends FinancialStatementListEvent {
  const FinancialStatementListYearSelected(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class FinancialStatementListDownload extends FinancialStatementListEvent {
  const FinancialStatementListDownload(this.year);

  final FinancialStatementListModel year;

  @override
  List<Object> get props => [year];
}

final class FinancialStatementListDeleteConfirm
    extends FinancialStatementListEvent {
  const FinancialStatementListDeleteConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class FinancialStatementListDelete extends FinancialStatementListEvent {
  const FinancialStatementListDelete();

  @override
  List<Object> get props => [];
}
