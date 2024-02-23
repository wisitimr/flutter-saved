import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:findigitalservice/company/models/company_model.dart';
import 'package:findigitalservice/core/auth.dart';
import 'package:findigitalservice/core/user.dart';
import 'package:findigitalservice/login/models/models.dart';
import 'package:findigitalservice/models/access_token.dart';
import 'package:findigitalservice/models/user_profile.dart';
import 'package:findigitalservice/app_provider.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AppProvider provider,
  })  : _provider = provider,
        super(const LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginCompanySelected>(_onCompanySelected);
    on<LoginConfirm>(_onConfirm);
    on<LoginSubmitted>(_onSubmitted);
  }
  final AppProvider _provider;
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(
      state.copyWith(
          username: username,
          isValid: Formz.validate([username, state.password]),
          status: FormzSubmissionStatus.initial),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);
    emit(
      state.copyWith(
          password: password,
          isValid: Formz.validate([password, state.username]),
          status: FormzSubmissionStatus.initial),
    );
  }

  Future<void> _onCompanySelected(
    LoginCompanySelected event,
    Emitter<LoginState> emit,
  ) async {
    final AppProvider provider = event.provider;
    final company = Company.dirty(event.company);
    CompanyModel companySelected =
        state.companies.firstWhere((CompanyModel c) => c.id == company.value);
    if (event.company.isNotEmpty) {
      await provider.setCompanyAsync(
        companyId: companySelected.id,
        companyName: companySelected.name,
      );
    }
    emit(
      state.copyWith(
        isLoading: false,
        isValid: Formz.validate([company]),
      ),
    );
  }

  Future<void> _onConfirm(
    LoginConfirm event,
    Emitter<LoginState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(isLoading: true));
      try {
        emit(state.copyWith(
          status: FormzSubmissionStatus.success,
          isLoading: false,
        ));
      } catch (_) {
        emit(state.copyWith(status: FormzSubmissionStatus.failure));
      }
    }
  }

  Future<void> _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    final AppProvider provider = event.provider;
    if (state.isValid) {
      emit(state.copyWith(isLoading: true));
      try {
        dynamic res = await _authService.login(
          state.username.value,
          state.password.value,
        );

        if (res['statusCode'] == 200) {
          AccessToken t = AccessToken.fromJson(res['data']);
          dynamic profile = await _userService.getUserProfile(t.accessToken);
          if (profile['statusCode'] == 200) {
            UserProfile data = UserProfile.fromJson(profile['data']);
            await _provider.setUserDataAsync(
              id: data.id,
              fullName: data.fullName,
              role: data.role,
              userProfileImageUrl: 'https://picsum.photos/id/1005/300/300',
            );
            await _provider.setAccessToken(t.accessToken);

            if (data.companies.isNotEmpty) {
              List<CompanyModel> companies = [];
              companies.addAll([
                CompanyModel(
                  id: '',
                  name: '-- Select --',
                  description: '',
                  address: '',
                  phone: '',
                  contact: '',
                ),
                ...data.companies,
              ]);
              if (data.companies.length > 1) {
                emit(state.copyWith(
                  isLoading: false,
                  companies: companies,
                  isLoggedIn: true,
                  isValid: false,
                ));
              } else {
                await provider.setCompanyAsync(
                  companyId: data.companies[0].id,
                  companyName: data.companies[0].name,
                );
                emit(state.copyWith(
                  status: FormzSubmissionStatus.success,
                  isLoading: false,
                  isLoggedIn: true,
                ));
              }
            } else {
              emit(state.copyWith(
                status: FormzSubmissionStatus.success,
                isLoading: false,
                isLoggedIn: true,
              ));
            }
          } else {
            emit(state.copyWith(
                status: FormzSubmissionStatus.failure,
                message: res['statusMessage']));
          }
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
}
