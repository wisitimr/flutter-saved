import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/account/form/account_form.dart';
import 'package:saved/account/form/view/account_form.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

class AccountFormPage extends StatefulWidget {
  final String id;

  const AccountFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<AccountFormPage> createState() => _AccountFormPageState();
}

class _AccountFormPageState extends State<AccountFormPage> {
  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return AccountFormBloc()
            ..add(AccountFormStarted(provider, widget.id));
        },
        child: ListView(
            padding: const EdgeInsets.all(kDefaultPadding),
            children: const [
              Padding(
                  padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
                  child: AccountForm()),
            ]),
      ),
    );
  }
}
