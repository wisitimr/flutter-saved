import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:saved/company/models/company_model.dart';
import 'package:saved/core/core.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/core/role.dart';
import 'package:saved/user/form/models/user_form_model.dart';
import 'package:saved/user/form/models/models.dart';

part 'user_form_event.dart';
part 'user_form_state.dart';

class UserFormBloc extends Bloc<UserFormEvent, UserFormState> {
  UserFormBloc() : super(UserFormLoading()) {
    on<UserFormStarted>(_onStarted);
    on<UserFormIdChanged>(_onIdChanged);
    on<UserFormUsernameChanged>(_onUsernameChanged);
    on<UserFormFirstNameChanged>(_onFirstNameChanged);
    on<UserFormLastNameChanged>(_onLastNameChanged);
    on<UserFormEmailChanged>(_onEmailChanged);
    on<UserFormRoleChanged>(_onRoleChanged);
    on<UserSubmitted>(_onSubmitted);
  }

  final UserService _userService = UserService();
  final RoleService _roleService = RoleService();

  Future<void> _onStarted(
      UserFormStarted event, Emitter<UserFormState> emit) async {
    // emit(UserFormLoading());
    emit(state.copyWith(isLoading: true));
    try {
      final AppProvider provider = event.provider;
      final roleRes = await _roleService.findAll(provider, {});
      List<String>? roles = [];
      if (roleRes != null && roleRes['statusCode'] == 200) {
        roles = (roleRes['data'] as List)
            .map((data) => data['name'])
            .cast<String>()
            .toList();
      }
      final user = UserFormTmp();
      if (event.id.isNotEmpty) {
        final res = await _userService.findById(provider, event.id);
        if (res != null && res['statusCode'] == 200) {
          UserFormModel data = UserFormModel.fromJson(res['data']);
          user.id = data.id;
          user.username = data.username;
          user.firstName = data.firstName;
          user.lastName = data.lastName;
          user.email = data.email;
          user.role = data.role;
          user.companies = data.companies;
        }
      }
      emit(state.copyWith(
        isLoading: false,
        id: Id.dirty(user.id),
        username: Username.dirty(user.username),
        firstName: FirstName.dirty(user.firstName),
        lastName: LastName.dirty(user.lastName),
        email: Email.dirty(user.email),
        role: Role.dirty(user.role),
        companies: user.companies,
        roles: roles,
        isValid: user.id.isNotEmpty,
      ));
    } catch (e) {
      // ignore: avoid_print
      print("Exception occured: $e");
      emit(UserFormError());
    }
  }

  void _onIdChanged(
    UserFormIdChanged event,
    Emitter<UserFormState> emit,
  ) {
    final id = Id.dirty(event.id);
    emit(
      state.copyWith(
        id: id,
        isValid: Formz.validate(
          [
            state.username,
            state.firstName,
            state.lastName,
            state.email,
          ],
        ),
      ),
    );
  }

  void _onUsernameChanged(
    UserFormUsernameChanged event,
    Emitter<UserFormState> emit,
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
    UserFormFirstNameChanged event,
    Emitter<UserFormState> emit,
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
    UserFormLastNameChanged event,
    Emitter<UserFormState> emit,
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
    UserFormEmailChanged event,
    Emitter<UserFormState> emit,
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

  void _onRoleChanged(
    UserFormRoleChanged event,
    Emitter<UserFormState> emit,
  ) {
    final role = Role.dirty(event.role);
    emit(
      state.copyWith(
        role: role,
        isValid: Formz.validate(
          [
            state.username,
            state.firstName,
            state.lastName,
            state.email,
          ],
        ),
      ),
    );
  }

  Future<void> _onSubmitted(
    UserSubmitted event,
    Emitter<UserFormState> emit,
  ) async {
    final AppProvider provider = event.provider;
    if (state.isValid) {
      try {
        final Map<String, dynamic> data = {};
        data['id'] = state.id.value;
        data['username'] = state.username.value;
        data['firstName'] = state.firstName.value;
        data['lastName'] = state.lastName.value;
        data['email'] = state.email.value;
        List<String> companies = [];
        if (state.companies.isNotEmpty) {
          for (var c in state.companies) {
            companies.add(c.id);
          }
        }
        data['companies'] = companies;
        dynamic res = await _userService.save(provider, data);

        if (res['statusCode'] == 200 || res['statusCode'] == 201) {
          emit(state.copyWith(
              status: FormzSubmissionStatus.success,
              message: res['statusMessage']));
        } else {
          emit(state.copyWith(
              status: FormzSubmissionStatus.failure,
              message: res['statusMessage']));
        }
      } catch (e) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }
}

class UserFormTmp {
  String id = '';
  String username = '';
  String firstName = '';
  String lastName = '';
  String email = '';
  String role = '';
  List<CompanyModel> companies = [];
}
