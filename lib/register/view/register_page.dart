import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/widgets/public_master_layout/public_master_layout.dart';
import 'package:findigitalservice/register/register.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: BlocProvider(
            create: (context) {
              return RegisterBloc();
            },
            child: const PublicMasterLayout(
                body: SingleChildScrollView(
              child: RegisterForm(),
            ))),
      ),
    );
  }
}
