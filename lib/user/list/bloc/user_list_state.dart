part of 'user_list_bloc.dart';

@immutable
final class UserState extends Equatable {
  const UserState({
    this.users = const <UserModel>[],
  });

  final List<UserModel> users;

  @override
  List<Object> get props => [];
}

final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserError extends UserState {
  @override
  List<Object> get props => [];
}
