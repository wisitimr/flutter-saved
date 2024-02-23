import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:findigitalservice/app_provider.dart';
import 'package:findigitalservice/constants/dimens.dart';
import 'package:findigitalservice/daybook/form/bloc/daybook_form_bloc.dart';
import 'package:findigitalservice/daybook/form/view/daybook_form.dart';
import 'package:findigitalservice/widgets/portal_master_layout/portal_master_layout.dart';

class DaybookFormPage extends StatefulWidget {
  final String id;

  const DaybookFormPage({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  State<DaybookFormPage> createState() => _DaybookFormPageState();
}

class _DaybookFormPageState extends State<DaybookFormPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return DaybookFormBloc(provider)..add(DaybookFormStarted(widget.id));
        },
        child:
            ListView(padding: const EdgeInsets.all(kDefaultPadding), children: [
          Text(
            provider.companyName,
            style: themeData.textTheme.headlineMedium,
          ),
          Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: DaybookForm(id: widget.id)),
        ]),
      ),
    );
  }
}
