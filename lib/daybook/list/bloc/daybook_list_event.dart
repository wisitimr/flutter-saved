part of 'daybook_list_bloc.dart';

@immutable
sealed class DaybookListEvent extends Equatable {
  const DaybookListEvent();
}

final class DaybookListStarted extends DaybookListEvent {
  const DaybookListStarted(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class DaybookListSearchChanged extends DaybookListEvent {
  const DaybookListSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class DaybookListHeaderSort extends DaybookListEvent {
  const DaybookListHeaderSort(this.columnIndex, this.ascending);

  final int columnIndex;
  final bool ascending;

  @override
  List<Object> get props => [
        columnIndex,
        ascending,
      ];
}

final class DaybookListYearSelected extends DaybookListEvent {
  const DaybookListYearSelected(this.year);

  final int year;

  @override
  List<Object> get props => [year];
}

final class DaybookListDownload extends DaybookListEvent {
  const DaybookListDownload(this.data);

  final DaybookListModel data;

  @override
  List<Object> get props => [data];
}

final class DaybookListDeleteConfirm extends DaybookListEvent {
  const DaybookListDeleteConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class DaybookListDelete extends DaybookListEvent {
  const DaybookListDelete();

  @override
  List<Object> get props => [];
}
