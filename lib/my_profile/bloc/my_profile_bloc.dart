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
  MyProfileBloc() : super(MyProfileLoading()) {
    on<MyProfileStarted>(_onStarted);
    on<MyProfileUsernameChanged>(_onUsernameChanged);
    on<MyProfileFirstNameChanged>(_onFirstNameChanged);
    on<MyProfileLastNameChanged>(_onLastNameChanged);
    on<MyProfileEmailChanged>(_onEmailChanged);
    on<MyProfileCompanySelected>(_onCompanySelected);
    on<MyProfileSubmitted>(_onSubmitted);
  }

  final UserService _userService = UserService();

  Future<void> _onStarted(
      MyProfileStarted event, Emitter<MyProfileState> emit) async {
    emit(MyProfileLoading());
    try {
      final AppProvider provider = event.provider;
      final res = await _userService.findById(provider, provider.id);

      if (res != null && res['statusCode'] == 200) {
        var data = MyProfile.fromJson(res['data']);

        // if (data.companies.isNotEmpty) {
        //   await provider.setCompanyAsync(
        //       companyId: data.companies[0].id,
        //       companyName: data.companies[0].name);
        // }
        emit(state.copyWith(
            isLoading: false,
            imageUrl: 'https://picsum.photos/id/1005/300/300',
            id: Id.dirty(data.id),
            username: Username.dirty(data.username),
            firstName: FirstName.dirty(data.firstName),
            lastName: LastName.dirty(data.lastName),
            email: Email.dirty(data.email),
            role: Role.dirty(data.role),
            companies: data.companies,
            companySelected: provider.companyId,
            isValid: data.id.isNotEmpty));
      }
    } catch (e) {
      // ignore: avoid_print
      print("Exception occured: $e");
      emit(MyProfileError());
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
    final AppProvider provider = event.provider;
    await provider.setCompanyAsync(
        companyId: event.companyId, companyName: event.companyName);
    emit(
      state.copyWith(
        companySelected: event.companyId,
      ),
    );
  }

  Future<void> _onSubmitted(
    MyProfileSubmitted event,
    Emitter<MyProfileState> emit,
  ) async {
    final AppProvider provider = event.provider;
    try {
      final Map<String, dynamic> data = {};
      data['id'] = state.id.value;
      data['username'] = state.username.value;
      data['firstName'] = state.firstName.value;
      data['lastName'] = state.lastName.value;
      data['email'] = state.email.value;
      // data['role'] = state.role.value;

      dynamic res = await _userService.update(provider, data);

      if (res['statusCode'] == 200) {
        var data = res['data'];
        await provider.setUserDataAsync(
          fullName: data['fullName'],
          role: data['role'] ?? '',
          userProfileImageUrl: 'https://picsum.photos/id/1005/300/300',
        );
        emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            message: res['statusMessage']));
      } else {
        emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            message: res['statusMessage']));
      }
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
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
