import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/user/list/models/models.dart';

part 'user_list_event.dart';
part 'user_list_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserLoading()) {
    on<UserStarted>(_onStarted);
  }

  final UserService _userService = UserService();

  Future<void> _onStarted(UserStarted event, Emitter<UserState> emit) async {
    emit(UserLoading());
    try {
      final AppProvider provider = event.provider;
      final res = await _userService.findAll(provider, {});
      List<UserModel> users = [];
      if (res['statusCode'] == 200) {
        List data = res['data'];
        users = data.map((item) => UserModel.fromJson(item)).toList();
      }
      emit(UserState(
        users: users,
      ));
    } catch (e) {
      print(e);
      emit(UserError());
    }
  }
}
