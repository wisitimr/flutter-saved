import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:formz/formz.dart';
import 'package:go_router/go_router.dart';
import 'package:saved/app_router.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/generated/l10n.dart';
import 'package:saved/register/bloc/register_bloc.dart';
import 'package:saved/theme/theme_extensions/app_button_theme.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);
    final passwordController = TextEditingController();

    return BlocListener<RegisterBloc, RegisterState>(
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
          final dialog = AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            desc: state.message,
            width: kDialogWidth,
            btnOkText: Lang.of(context).loginNow,
            btnOkOnPress: () => GoRouter.of(context).go(RouteUri.login),
          );

          dialog.show();
        }
      },
      child: Align(
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
                    padding:
                        const EdgeInsets.only(bottom: kDefaultPadding * 2.0),
                    child: Text(
                      lang.adminPortalLogin,
                      style: themeData.textTheme.titleMedium,
                    ),
                  ),
                  Column(
                    children: [
                      _UsernameInput(),
                      const Padding(
                          padding: EdgeInsets.only(bottom: kDefaultPadding)),
                      _EmailInput(),
                      const Padding(
                          padding: EdgeInsets.only(bottom: kDefaultPadding)),
                      _PasswordInput(passwordController),
                      const Padding(
                          padding: EdgeInsets.only(bottom: kDefaultPadding)),
                      _RetypePasswordInput(),
                      const Padding(
                          padding: EdgeInsets.only(bottom: kDefaultPadding)),
                      _FirstNameInput(),
                      const Padding(
                          padding: EdgeInsets.only(bottom: kDefaultPadding)),
                      _LastNameInput(),
                      const Padding(
                          padding: EdgeInsets.only(bottom: kDefaultPadding)),
                      _RegisterButton(),
                      const Padding(
                          padding: EdgeInsets.only(bottom: kDefaultPadding)),
                      _BackToLogin(),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _UsernameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
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
          onChanged: (username) => context
              .read<RegisterBloc>()
              .add(RegisterUsernameChanged(username!)),
        );
      },
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return FormBuilderTextField(
          name: 'email',
          decoration: InputDecoration(
            labelText: lang.email,
            hintText: lang.email,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          enableSuggestions: false,
          validator: FormBuilderValidators.required(),
          onChanged: (email) =>
              context.read<RegisterBloc>().add(RegisterEmailChanged(email!)),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput(TextEditingController passwordController)
      : _passwordController = passwordController;

  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return FormBuilderTextField(
          name: 'password',
          decoration: InputDecoration(
            labelText: lang.password,
            hintText: lang.password,
            helperText: lang.passwordHelperText,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          enableSuggestions: false,
          obscureText: true,
          validator: FormBuilderValidators.compose([
            FormBuilderValidators.required(),
            FormBuilderValidators.minLength(6),
            FormBuilderValidators.maxLength(18),
          ]),
          controller: _passwordController,
          onChanged: (password) => context
              .read<RegisterBloc>()
              .add(RegisterPasswordChanged(password!)),
        );
      },
    );
  }
}

class _RetypePasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final formKey = GlobalKey<FormBuilderState>();

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return FormBuilder(
          key: formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: FormBuilderTextField(
            name: 'retypePassword',
            decoration: InputDecoration(
              labelText: lang.retypePassword,
              hintText: lang.retypePassword,
              border: const OutlineInputBorder(),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            enableSuggestions: false,
            validator: (value) {
              if (state.password.value != value) {
                return lang.passwordNotMatch;
              }
              return null;
            },
            obscureText: true,
            onChanged: (retypePassword) => formKey.currentState!.validate(),
          ),
        );
      },
    );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return FormBuilderTextField(
          name: 'firstName',
          decoration: InputDecoration(
            labelText: lang.firstName,
            hintText: lang.firstName,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          enableSuggestions: false,
          validator: FormBuilderValidators.required(),
          onChanged: (firstName) => context
              .read<RegisterBloc>()
              .add(RegisterFirstNameChanged(firstName!)),
        );
      },
    );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      buildWhen: (previous, current) => previous.lastName != current.lastName,
      builder: (context, state) {
        return FormBuilderTextField(
          name: 'lastName',
          decoration: InputDecoration(
            labelText: lang.lastName,
            hintText: lang.lastName,
            border: const OutlineInputBorder(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          enableSuggestions: false,
          validator: FormBuilderValidators.required(),
          onChanged: (lastName) => context
              .read<RegisterBloc>()
              .add(RegisterLastNameChanged(lastName!)),
        );
      },
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 40.0,
                width: double.infinity,
                child: ElevatedButton(
                  style: themeData.extension<AppButtonTheme>()!.primaryElevated,
                  onPressed: (state.isValid
                      ? () {
                          context
                              .read<RegisterBloc>()
                              .add(const RegisterSubmitted());
                        }
                      : null),
                  child: Text(lang.register),
                ),
              );
      },
    );
  }
}

class _BackToLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final lang = Lang.of(context);
    final themeData = Theme.of(context);

    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        return SizedBox(
          height: 40.0,
          width: double.infinity,
          child: OutlinedButton(
            style: themeData.extension<AppButtonTheme>()!.secondaryOutlined,
            onPressed: () => GoRouter.of(context).go(RouteUri.login),
            child: Text(lang.backToLogin),
          ),
        );
      },
    );
  }
}
