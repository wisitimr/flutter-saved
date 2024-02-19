part of 'daybook_list_bloc.dart';

@immutable
final class DaybookListState extends Equatable {
  const DaybookListState({
    this.daybooks = const <DaybookListModel>[],
    this.document = const <Document>[],
  });

  final List<DaybookListModel> daybooks;
  final List<Document> document;

  @override
  List<Object> get props => [];
}

final class DaybookListLoading extends DaybookListState {
  @override
  List<Object> get props => [];
}

final class DaybookListError extends DaybookListState {
  @override
  List<Object> get props => [];
}
