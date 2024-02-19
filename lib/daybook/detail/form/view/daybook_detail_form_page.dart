import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:saved/app_provider.dart';
import 'package:saved/constants/dimens.dart';
import 'package:saved/daybook/detail/form/bloc/daybook_detail_form_bloc.dart';
import 'package:saved/daybook/detail/form/view/daybook_detail_form.dart';
import 'package:saved/widgets/portal_master_layout/portal_master_layout.dart';

class DaybookDetailFormPage extends StatefulWidget {
  final String id;
  final String daybook;

  const DaybookDetailFormPage({
    Key? key,
    required this.id,
    required this.daybook,
  }) : super(key: key);

  @override
  State<DaybookDetailFormPage> createState() => _DaybookDetailFormPageState();
}

class _DaybookDetailFormPageState extends State<DaybookDetailFormPage> {
  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    final provider = context.read<AppProvider>();

    return PortalMasterLayout(
      body: BlocProvider(
        create: (context) {
          return DaybookDetailFormBloc()
            ..add(
                DaybookDetailFormStarted(provider, widget.id, widget.daybook));
        },
        child:
            ListView(padding: const EdgeInsets.all(kDefaultPadding), children: [
          Text(
            provider.companyName,
            style: themeData.textTheme.headlineMedium,
          ),
          const Padding(
              padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: DaybookDetailForm()),
        ]),
      ),
    );
  }
}
