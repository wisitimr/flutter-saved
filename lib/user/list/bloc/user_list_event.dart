part of 'user_list_bloc.dart';

@immutable
sealed class UserEvent extends Equatable {
  const UserEvent();
}

final class UserStarted extends UserEvent {
  const UserStarted();

  @override
  List<Object> get props => [];
}

final class UserSearchChanged extends UserEvent {
  const UserSearchChanged(this.text);

  final String text;

  @override
  List<Object> get props => [text];
}

final class UserDeleteConfirm extends UserEvent {
  const UserDeleteConfirm(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}

final class UserDelete extends UserEvent {
  const UserDelete(this.id);

  final String id;

  @override
  List<Object> get props => [id];
}
