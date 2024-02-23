import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:findigitalservice/core/auth.dart';
import 'package:findigitalservice/register/models/models.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc() : super(const RegisterState()) {
    on<RegisterUsernameChanged>(_onUsernameChanged);
    on<RegisterEmailChanged>(_onEmailChanged);
    on<RegisterPasswordChanged>(_onPasswordChanged);
    on<RegisterFirstNameChanged>(_onFirstNameChanged);
    on<RegisterLastNameChanged>(_onLastNameChanged);
    on<RegisterSubmitted>(_onSubmitted);
  }

  final AuthService _authService = AuthService();

  void _onUsernameChanged(
    RegisterUsernameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([
          username,
          state.email,
          state.password,
          state.firstName,
          state.lastName
        ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onEmailChanged(
    RegisterEmailChanged event,
    Emitter<RegisterState> emit,
  ) {
    final email = Email.dirty(event.email);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          state.username,
          email,
          state.password,
          state.firstName,
          state.lastName
        ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onPasswordChanged(
    RegisterPasswordChanged event,
    Emitter<RegisterState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([
          state.username,
          state.email,
          password,
          state.firstName,
          state.lastName
        ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onFirstNameChanged(
    RegisterFirstNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final firstName = FirstName.dirty(event.firstName);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          state.username,
          state.email,
          state.password,
          firstName,
          state.lastName
        ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onLastNameChanged(
    RegisterLastNameChanged event,
    Emitter<RegisterState> emit,
  ) {
    final lastName = LastName.dirty(event.lastName);
    emit(
      state.copyWith(
        lastName: lastName,
        isValid: Formz.validate([
          state.username,
          state.email,
          state.password,
          state.firstName,
          lastName
        ]),
        status: FormzSubmissionStatus.initial,
      ),
    );
  }

  Future<void> _onSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      final Map<String, dynamic> data = {};
      data['username'] = state.username.value;
      data['password'] = state.password.value;
      data['email'] = state.email.value;
      data['firstName'] = state.firstName.value;
      data['lastName'] = state.lastName.value;

      dynamic res = await _authService.registerUser(data);

      if (res['statusCode'] == 201) {
        emit(state.copyWith(
            status: FormzSubmissionStatus.success,
            message: 'Your account has been successfully created.'));
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
