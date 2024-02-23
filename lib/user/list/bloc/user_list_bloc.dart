import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/user/list/models/models.dart';
import 'package:findigitalservice/core/core.dart';
import 'package:findigitalservice/app_provider.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc(AppProvider provider)
      : _provider = provider,
        super(UserLoading()) {
    on<UserStarted>(_onStarted);
    on<UserSearchChanged>(_onSearchChanged);
    on<UserDeleteConfirm>(_onConfirm);
    on<UserDelete>(_onDelete);
  }

  final AppProvider _provider;
  final UserService _userService = UserService();

  Future<void> _onStarted(UserStarted event, Emitter<UserState> emit) async {
    emit(state.copyWith(status: UserListStatus.loading));
    try {
      List<UserModel> users = [];
      final res = await _userService.findAll(_provider, {});
      if (res['statusCode'] == 200) {
        List data = res['data'];
        users = data.map((item) => UserModel.fromJson(item)).toList();
      }
      emit(
        state.copyWith(
          status: UserListStatus.success,
          users: users,
          filter: users,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: UserListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  void _onSearchChanged(
    UserSearchChanged event,
    Emitter<UserState> emit,
  ) {
    emit(state.copyWith(status: UserListStatus.loading));
    var filter = event.text.isNotEmpty
        ? state.users
            .where(
              (item) =>
                  item.username
                      .toLowerCase()
                      .contains(event.text.toLowerCase()) ||
                  item.firstName
                      .toLowerCase()
                      .contains(event.text.toLowerCase()) ||
                  item.lastName
                      .toLowerCase()
                      .contains(event.text.toLowerCase()),
            )
            .toList()
        : state.users;
    emit(
      state.copyWith(
        status: UserListStatus.success,
        users: state.users,
        filter: filter,
      ),
    );
  }

  Future<void> _onConfirm(
    UserDeleteConfirm event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserListStatus.loading));
    try {
      emit(
        state.copyWith(
          status: UserListStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: UserListStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    UserDelete event,
    Emitter<UserState> emit,
  ) async {
    emit(state.copyWith(status: UserListStatus.loading));
    try {
      if (event.id.isNotEmpty) {
        final res = await _userService.delete(_provider, event.id);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: UserListStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: UserListStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: UserListStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: UserListStatus.failure,
        message: e.toString(),
      ));
    }
  }
}
