part of 'daybook_list_bloc.dart';

@immutable
sealed class DaybookListEvent extends Equatable {
  const DaybookListEvent();
}

final class DaybookListStarted extends DaybookListEvent {
  const DaybookListStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}
