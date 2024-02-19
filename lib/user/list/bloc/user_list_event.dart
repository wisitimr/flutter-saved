part of 'user_list_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class UserStarted extends UserEvent {
  const UserStarted(this.provider);

  final AppProvider provider;

  @override
  List<Object> get props => [provider];
}
