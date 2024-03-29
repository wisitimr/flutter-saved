part of 'tb12_bloc.dart';

@immutable
sealed class ReportTB12Event extends Equatable {
  const ReportTB12Event();
}

final class ReportTB12Started extends ReportTB12Event {
  const ReportTB12Started(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportTB12SearchChanged extends ReportTB12Event {
  const ReportTB12SearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class ReportTB12YearSelected extends ReportTB12Event {
  const ReportTB12YearSelected(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportTB12Download extends ReportTB12Event {
  const ReportTB12Download(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class ReportTB12PreviewAccountBalance extends ReportTB12Event {
  const ReportTB12PreviewAccountBalance(this.accountGroup);

  final String accountGroup;

  @override
  List<Object> get props => [accountGroup];
}

final class ReportTB12AccountBalanceColumnSelected extends ReportTB12Event {
  const ReportTB12AccountBalanceColumnSelected(this.columns);

  final List columns;

  @override
  List<Object> get props => [columns];
}

final class ReportTB12AccountBalanceColumnSelectedAll extends ReportTB12Event {
  const ReportTB12AccountBalanceColumnSelectedAll(this.isSelectAll);

  final bool isSelectAll;

  @override
  List<Object> get props => [isSelectAll];
}

final class ReportTB12AccountBalanceColumnSelectedDefault
    extends ReportTB12Event {
  const ReportTB12AccountBalanceColumnSelectedDefault();

  @override
  List<Object> get props => [];
}
