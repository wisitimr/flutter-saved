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
