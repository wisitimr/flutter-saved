import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/core/user.dart';
import 'package:saved/company/models/company_model.dart';
import 'package:saved/my_profile/models/models.dart';

part 'my_profile_event.dart';
part 'my_profile_state.dart';

class MyProfileBloc extends Bloc<MyProfileEvent, MyProfileState> {
  MyProfileBloc(AppProvider provider)
      : _provider = provider,
        super(MyProfileLoading()) {
    on<MyProfileStarted>(_onStarted);
    on<MyProfileUsernameChanged>(_onUsernameChanged);
    on<MyProfileFirstNameChanged>(_onFirstNameChanged);
    on<MyProfileLastNameChanged>(_onLastNameChanged);
    on<MyProfileEmailChanged>(_onEmailChanged);
    on<MyProfileCompanySelected>(_onCompanySelected);
    on<MyProfileSubmitConfirm>(_onSubmitConfirm);
    on<MyProfileSubmitted>(_onSubmitted);
    on<MyProfileDeleteConfirm>(_onDeleteConfirm);
    on<MyProfileDelete>(_onDelete);
  }

  final AppProvider _provider;
  final UserService _userService = UserService();

  Future<void> _onStarted(
      MyProfileStarted event, Emitter<MyProfileState> emit) async {
    emit(state.copyWith(status: MyProfileStatus.loading));
    try {
      final res = await _userService.findById(_provider);

      if (res != null && res['statusCode'] == 200) {
        var data = MyProfile.fromJson(res['data']);
        emit(state.copyWith(
            status: MyProfileStatus.success,
            imageUrl: 'https://picsum.photos/id/1005/300/300',
            id: Id.dirty(data.id),
            username: Username.dirty(data.username),
            firstName: FirstName.dirty(data.firstName),
            lastName: LastName.dirty(data.lastName),
            email: Email.dirty(data.email),
            role: Role.dirty(data.role),
            companies: data.companies,
            companySelected: _provider.companyId,
            isValid: data.id.isNotEmpty));
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: MyProfileStatus.failure,
          message: e.toString(),
        ),
      );
    }
  }

  void _onUsernameChanged(
    MyProfileUsernameChanged event,
    Emitter<MyProfileState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate(
          [
            username,
            state.firstName,
            state.lastName,
            state.email,
          ],
        ),
      ),
    );
  }

  void _onFirstNameChanged(
    MyProfileFirstNameChanged event,
    Emitter<MyProfileState> emit,
  ) {
    final firstName = FirstName.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate(
          [
            state.username,
            firstName,
            state.lastName,
            state.email,
          ],
        ),
      ),
    );
  }

  void _onLastNameChanged(
    MyProfileLastNameChanged event,
    Emitter<MyProfileState> emit,
  ) {
    final lastName = LastName.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate(
          [
            state.username,
            state.firstName,
            lastName,
            state.email,
          ],
        ),
      ),
    );
  }

  void _onEmailChanged(
    MyProfileEmailChanged event,
    Emitter<MyProfileState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate(
          [
            state.username,
            state.firstName,
            state.lastName,
            email,
          ],
        ),
      ),
    );
  }

  Future<void> _onCompanySelected(
    MyProfileCompanySelected event,
    Emitter<MyProfileState> emit,
  ) async {
    await _provider.setCompanyAsync(
        companyId: event.id, companyName: event.name);
    emit(
      state.copyWith(
        status: MyProfileStatus.selected,
        companySelected: event.id,
      ),
    );
  }

  Future<void> _onSubmitConfirm(
    MyProfileSubmitConfirm event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(state.copyWith(
      status: MyProfileStatus.loading,
    ));
    try {
      emit(
        state.copyWith(
          status: MyProfileStatus.submitConfirmation,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: MyProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onSubmitted(
    MyProfileSubmitted event,
    Emitter<MyProfileState> emit,
  ) async {
    try {
      final Map<String, dynamic> data = {};
      data['id'] = state.id.value;
      data['username'] = state.username.value;
      data['firstName'] = state.firstName.value;
      data['lastName'] = state.lastName.value;
      data['email'] = state.email.value;
      data['companies'] = [];
      if (state.companies.isNotEmpty) {
        List<String> list = [];
        for (var element in state.companies) {
          list.add(element.id);
        }
        data['companies'] = list;
      }

      dynamic res = await _userService.update(_provider, data);

      if (res['statusCode'] == 200) {
        var data = res['data'];
        await _provider.setUserDataAsync(
          fullName: data['fullName'],
          role: data['role'] ?? '',
          userProfileImageUrl: 'https://picsum.photos/id/1005/300/300',
        );
        emit(state.copyWith(
          status: MyProfileStatus.submited,
          message: res['statusMessage'],
        ));
      } else {
        emit(state.copyWith(
          status: MyProfileStatus.failure,
          message: res['statusMessage'],
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: MyProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDeleteConfirm(
    MyProfileDeleteConfirm event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(state.copyWith(status: MyProfileStatus.loading));
    try {
      emit(
        state.copyWith(
          status: MyProfileStatus.deleteConfirmation,
          selectedDeleteRowId: event.id,
        ),
      );
    } catch (e) {
      emit(state.copyWith(
        status: MyProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }

  Future<void> _onDelete(
    MyProfileDelete event,
    Emitter<MyProfileState> emit,
  ) async {
    emit(state.copyWith(status: MyProfileStatus.loading));
    try {
      if (state.selectedDeleteRowId.isNotEmpty) {
        final res =
            await _userService.delete(_provider, state.selectedDeleteRowId);
        if (res['statusCode'] == 200) {
          emit(
            state.copyWith(
              status: MyProfileStatus.deleted,
              message: res['statusMessage'],
            ),
          );
        } else {
          emit(
            state.copyWith(
              status: MyProfileStatus.failure,
              message: res['statusMessage'],
            ),
          );
        }
      } else {
        emit(state.copyWith(
          status: MyProfileStatus.failure,
          message: "Invalid parameter",
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: MyProfileStatus.failure,
        message: e.toString(),
      ));
    }
  }
}

class MyProfileTmp {
  String id = '';
  String name = '';
  String type = '';
  String amount = '';
  String account = '';
  String daybook = '';
}
