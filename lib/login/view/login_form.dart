import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/app_router.dart';
import 'package:findigitalservice/company/models/company_model.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/generated/l10n.dart';
import 'package:findigitalservice/login/bloc/login_bloc.dart';
import 'package:findigitalservice/theme/theme_extensions/app_button_theme.dart';
import 'package:findigitalservice/theme/theme_extensions/app_color_scheme.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status.isFailure) {
          final dialog = AwesomeDialog(
            context: context,
            dialogType: DialogType.error,
            desc: state.message,
            width: kDialogWidth,
            btnOkText: 'OK',
            btnOkOnPress: () {},
          );

          dialog.show();
        } else if (state.status.isSuccess) {
          GoRouter.of(context).go(RouteUri.home);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Align(
            alignment: Alignment.topCenter,
            child: Container(
              padding: const EdgeInsets.only(top: kDefaultPadding * 5.0),
              constraints: const BoxConstraints(maxWidth: 400.0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: kDefaultPadding),
                        child: Image.asset(
                          'assets/images/app_logo.png',
                          height: 80.0,
                        ),
                      ),
                      Text(
                        lang.appTitle,
                        style: themeData.textTheme.headlineMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            bottom: kDefaultPadding * 2.0),
                        child: Text(
                          lang.adminPortalLogin,
                          style: themeData.textTheme.titleMedium,
                        ),
                      ),
                      Column(
                        children: [
                          if (state.isLoggedIn) ...[
                            const Padding(
                                padding:
                                    EdgeInsets.only(bottom: kDefaultPadding)),
                            _CompanySelect(),
                            const Padding(
                                padding:
                                    EdgeInsets.only(bottom: kDefaultPadding)),
                            _ConfirmButton()
                          ] else ...[
                            _UsernameInput(),
                            const Padding(
                                padding:
                                    EdgeInsets.only(bottom: kDefaultPadding)),
                            _PasswordInput(),
                            const Padding(
                                padding:
                                    EdgeInsets.only(bottom: kDefaultPadding)),
                            _LoginButton(),
                            const Padding(
                                padding:
                                    EdgeInsets.only(bottom: kDefaultPadding)),
                            _ValidateAccountText(),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.username != current.username,
      builder: (context, state) {
        return FormBuilderTextField(
          name: 'username',
          decoration: InputDecoration(
            labelText: lang.username,
            hintText: lang.username,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          enableSuggestions: false,
          validator: FormBuilderValidators.required(),
          onChanged: (username) =>
              context.read<LoginBloc>().add(LoginUsernameChanged(username!)),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return FormBuilderTextField(
          name: 'password',
          decoration: InputDecoration(
            labelText: lang.password,
            hintText: lang.password,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          enableSuggestions: false,
          obscureText: true,
          validator: FormBuilderValidators.required(),
          onChanged: (password) =>
              context.read<LoginBloc>().add(LoginPasswordChanged(password!)),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: themeData.extension<AppButtonTheme>()!.primaryElevated,
                  onPressed: (state.isValid
                      ? () {
                          context
                              .read<LoginBloc>()
                              .add(LoginSubmitted(context.read<AppProvider>()));
                        }
                      : null),
                  child: Text(lang.login),
                ),
              );
      },
    );
  }
}

class _ValidateAccountText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return SizedBox(
          height: 40.0,
          width: double.infinity,
          child: TextButton(
            style: themeData.extension<AppButtonTheme>()!.secondaryText,
            onPressed: () => GoRouter.of(context).go(RouteUri.register),
            child: RichText(
              text: TextSpan(
                text: '${lang.dontHaveAnAccount} ',
                style: TextStyle(
                  color: themeData.colorScheme.onSurface,
                ),
                children: [
                  TextSpan(
                    text: lang.registerNow,
                    style: TextStyle(
                      color: themeData.extension<AppColorScheme>()!.hyperlink,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _CompanySelect extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FormBuilderDropdown(
          name: lang.company,
          decoration: InputDecoration(
            labelText: lang.company,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            isDense: true,
          ),
          validator: FormBuilderValidators.required(),
          items: state.companies
              .map((CompanyModel e) => DropdownMenuItem(
                    value: e.id,
                    child: Text(e.name),
                  ))
              .toList(),
          initialValue: "",
          onChanged: (id) => context
              .read<LoginBloc>()
              .add(LoginCompanySelected(context.read<AppProvider>(), id!)),
        );
      },
    );
  }
}

class _ConfirmButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: themeData.extension<AppButtonTheme>()!.primaryElevated,
                  onPressed: (state.isValid
                      ? () {
                          context.read<LoginBloc>().add(const LoginConfirm());
                        }
                      : null),
                  child: Text(lang.confirm),
                ),
              );
      },
    );
  }
}
