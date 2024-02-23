import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/login/bloc/login_bloc.dart';
import 'package:findigitalservice/login/view/login_form.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/widgets/public_master_layout/public_master_layout.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
          create: (context) {
            return LoginBloc(
              provider: context.read<AppProvider>(),
            );
          },
          child: const PublicMasterLayout(
            body: SingleChildScrollView(
              child: LoginForm(),
            ),
          ),
        ),
      ),
    );
  }
}
