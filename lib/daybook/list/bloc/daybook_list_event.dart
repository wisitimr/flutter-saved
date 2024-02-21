part of 'daybook_list_bloc.dart';

@immutable
sealed class DaybookListEvent extends Equatable {
  const DaybookListEvent();
}

final class DaybookListStarted extends DaybookListEvent {
  const DaybookListStarted();

  @override
  List<Object> get props => [];
}

final class DaybookListSearchChanged extends DaybookListEvent {
  const DaybookListSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
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
