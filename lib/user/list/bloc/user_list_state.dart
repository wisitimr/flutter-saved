part of 'user_list_bloc.dart';

enum UserListStatus {
  loading,
  success,
  failure,
  deleteConfirmation,
  deleted,
}

extension UserListStatusX on UserListStatus {
  bool get isLoading => this == UserListStatus.loading;
  bool get isSuccess => this == UserListStatus.success;
  bool get isFailure => this == UserListStatus.failure;
  bool get isDeleteConfirmation => this == UserListStatus.deleteConfirmation;
  bool get isDeleted => this == UserListStatus.deleted;
}

@immutable
final class UserState extends Equatable {
  const UserState({
    this.status = UserListStatus.loading,
    this.message = '',
    this.users = const <UserModel>[],
    this.filter = const <UserModel>[],
    this.selectedDeleteRowId = '',
  });

  final UserListStatus status;
  final String message;
  final List<UserModel> users;
  final List<UserModel> filter;
  final String selectedDeleteRowId;

  UserState copyWith({
    UserListStatus? status,
    String? message,
    List<UserModel>? users,
    List<UserModel>? filter,
    String? selectedDeleteRowId,
  }) {
    return UserState(
      status: status ?? this.status,
      message: message ?? this.message,
      users: users ?? this.users,
      filter: filter ?? this.filter,
      selectedDeleteRowId: selectedDeleteRowId ?? this.selectedDeleteRowId,
    );
  }

  @override
  List<Object> get props => [
        status,
        message,
        users,
        filter,
        selectedDeleteRowId,
      ];
}

final class UserLoading extends UserState {
  @override
  List<Object> get props => [];
}

final class UserError extends UserState {
  @override
  List<Object> get props => [];
}
